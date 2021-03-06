//
//  HumanAPIVC.swift
//
//  Created by Vikram Ezhil on 04/11/18.
//

import UIKit
import WebKit

class HumanAPIVC: UIViewController, WKUIDelegate, WKNavigationDelegate, ServiceDelegate {
    private let TAG: String = "HumanAPIVC"
    
    @IBOutlet weak var wkWVHumanAPI: WKWebView!
    @IBOutlet weak var wkWVRedirectHumanAPI: WKWebView!
    @IBOutlet weak var wkWVClose: UIButton!

    private var service: Service = Service()
    private var humanAPIModel: HumanAPIModel = HumanAPIModel()
    
    private var humanTokens: [String: String] = [:]
    
    private var multiRedirectFound: Bool = false
    
    var humanAPIVCDelegate: HumanAPIVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.serviceDelegate = self
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        wkWVHumanAPI?.configuration.preferences = preferences
        wkWVHumanAPI?.uiDelegate = self
        wkWVHumanAPI?.navigationDelegate = self
        
        wkWVRedirectHumanAPI?.configuration.preferences = preferences
        wkWVRedirectHumanAPI?.uiDelegate = self
        wkWVRedirectHumanAPI?.navigationDelegate = self
        
        if humanTokens.count == 5 {
            humanAPIModel.clientId = humanTokens["clientID"]!
            humanAPIModel.clientSecret = humanTokens["clientSecret"]!
            humanAPIModel.userId = humanTokens["userID"]!
            humanAPIModel.publicToken = humanTokens["publicToken"]!
            humanAPIModel.accessToken = humanTokens["accessToken"]!
            
            if let url = humanAPIModel.loadURL {
                wkWVHumanAPI?.load(url)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            print(TAG, "humanTokens doesn't have all the required data. Exiting.....")
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    ///
    /// Initializes the human tokens
    ///
    /// :param: clientID The client ID
    /// :param: clientSecret The client Secret
    /// :param: userID The user ID
    /// :param: publicToken The public token
    /// :param: accessToken The access token
    ///
    public func initiHumanTokens(clientID: String, clientSecret: String, userID: String, publicToken: String, accessToken: String) {
        humanTokens["clientID"] = clientID
        humanTokens["clientSecret"] = clientSecret
        humanTokens["userID"] = userID
        humanTokens["publicToken"] = publicToken
        humanTokens["accessToken"] = accessToken
    }
    
    // @Override IBAction Methods
    
    @IBAction func onClick(_ sender: UIButton) {
        switch sender {
            case wkWVClose:
                
                if(wkWVHumanAPI.isHidden) {
                    wkWVRedirectHumanAPI.isHidden = true
                    wkWVRedirectHumanAPI.load(URLRequest(url: URL(string: "about:blank")!))
                    
                    wkWVClose.isHidden = true
                    wkWVHumanAPI.isHidden = false
                }
                
                break
            
            default:
                print(TAG, "Uknown button action clicked")
                
                break
        }
    }

    // @Override WKUIDelegate Methods
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            print(TAG, "Link detected with target = '_blank'")
            
            if let requestUrl = navigationAction.request.url {
                if(requestUrl.absoluteString.contains(humanAPIModel.integrationPopupDetectUrl)) {
                    wkWVRedirectHumanAPI.load(navigationAction.request)
                    wkWVRedirectHumanAPI.isHidden = false
                    wkWVHumanAPI.isHidden = true
                } else {
                    wkWVHumanAPI.load(navigationAction.request)
                    wkWVHumanAPI.isHidden = false
                    wkWVRedirectHumanAPI.isHidden = true
                }
            }
        }
        
        return nil
    }
    
    // @Override WKNavigationDelegate Methods
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(TAG, "Navigation action url = \(String(describing: navigationAction.request.url))")
        
        if let requestUrl = navigationAction.request.url {
            let newUrl = requestUrl.absoluteString

            if(newUrl.hasPrefix(humanAPIModel.finishUrl)) {
                // Setting the human API response in the model data
                humanAPIModel.setHumanAPIResponse(response: requestUrl)
                
                // Getting the human API public token for the user
                service.post(command: nil, passbackKey: HumanAPIModel.humanAPITokenPassBackKey, requestLink: humanAPIModel.tokenUrl, customHeaders: [:], requestBody: humanAPIModel.getTokenRequestBody())
            } else if(newUrl.hasPrefix(humanAPIModel.closeUrl)) {
                humanAPIVCDelegate?.onHumanAPIUpdate(command: nil, success: true, humanAPIData: humanAPIModel.getHumanAPIHybridTokensData(pluginMsg: "Human API page closed by user"))
                
                decisionHandler(.cancel)
                
                self.dismiss(animated: true, completion: nil)
                
                return
            } else if(newUrl.hasPrefix(humanAPIModel.popupDetectUrl) && !multiRedirectFound) {
                multiRedirectFound = true
                
                // Loading any popup url in the redirect web view
                wkWVRedirectHumanAPI.load(navigationAction.request)
                
                decisionHandler(.cancel)
                
                return
            } else if(newUrl.hasPrefix(humanAPIModel.popupCloseWithMsgUrl) || newUrl.hasPrefix(humanAPIModel.popupCloseUrl)) {
                let parts = newUrl.components(separatedBy: "?")
                if(parts.count > 1) {
                    let message = parts[1]
                    let js = "window.postMessage(decodeURIComponent('\(message)'), '*');"
                    
                    self.wkWVHumanAPI.evaluateJavaScript(js, completionHandler: {(innerHtml, error) in
                        print(self.TAG, "evaluateJavaScript for wkWVHumanAPI completed")
                        
                        self.multiRedirectFound = false
                        self.wkWVHumanAPI.isHidden = false
                        self.wkWVRedirectHumanAPI.isHidden = true
                    })
                }
            }
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let url = String(describing: webView.url)
        wkWVClose.isHidden = (url.contains(humanAPIModel.baseUrl) || url.contains(humanAPIModel.closeUrl) || url.contains(humanAPIModel.finishUrl) || url.contains("about:blank"))

        print(TAG, "Completed navigation = \(url)")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        humanAPIVCDelegate?.onHumanAPIUpdate(command: nil, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridTokensData(pluginMsg: "Web API load error = \(error.localizedDescription)"))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // @Override ServiceDelegate Methods
    
    func onServiceRunning(command: CDVInvokedUrlCommand?, passBackKey: String, serviceRunning: Bool) {
        print(TAG, "Service running status for \(passBackKey) = \(serviceRunning)")
    }
    
    func onServiceResponse(command: CDVInvokedUrlCommand?, passBackKey: String, serviceResponse: String) {
        print(TAG, "Service success for \(passBackKey) = \(serviceResponse)")
        
        switch passBackKey {
            case HumanAPIModel.humanAPITokenPassBackKey:
                
                // Setting the token in the model data
                humanAPIModel.tokens = serviceResponse
                
                print(TAG, "clientID = \(humanAPIModel.clientId)");
                print(TAG, "clientSecret = \(humanAPIModel.clientSecret)");
                print(TAG, "userID = \(humanAPIModel.userId)");
                print(TAG, "humanID = \(humanAPIModel.humanId)");
                print(TAG, "sessionToken = \(humanAPIModel.sessionToken)");
                print(TAG, "publicToken = \(humanAPIModel.publicToken)");
                print(TAG, "accessToken = \(humanAPIModel.accessToken)");
                
                if(humanAPIModel.accessToken.count == 0) {
                    humanAPIVCDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridTokensData(pluginMsg: "Access token is empty"))
                } else {
                    humanAPIVCDelegate?.onHumanAPIUpdate(command: command, success: true, humanAPIData: humanAPIModel.getHumanAPIHybridTokensData(pluginMsg: "Human API tokens got"))
                }
                
                self.dismiss(animated: true, completion: nil)

                break
            
            default:
                break
        }
    }
    
    func onServiceError(command: CDVInvokedUrlCommand?, passBackKey: String, errorMessage: String) {
        print(TAG, "Service error for \(passBackKey) = \(errorMessage)")
        
        humanAPIVCDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridTokensData(pluginMsg: errorMessage))
        
        self.dismiss(animated: true, completion: nil)
    }
}