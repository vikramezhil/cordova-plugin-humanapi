//
//  HumanAPIModel.swift
//
//  Created by Vikram Ezhil on 04/11/18.
//

import Foundation

class HumanAPIModel: NSObject {
    
    ///
    /// Initializer
    ///
    override init() {
        super.init()
    }
    
    //*************************************************************************************
    
    // HUMAN API Authentication
    
    //*************************************************************************************
    
    private let baseURL: String = "https://connect.humanapi.co/"
    private let finishURL: String = "https://hapi-finish"
    private let closeURL: String = "https://hapi-close"
    private let popupDetectURL: String = "https://user.humanapi.co/x/close"
    private let popupCloseURL: String = "https://close-popup"
    
    private var id: String = ""
    private var secret: String = ""
    private var user: String = ""
    private var pToken: String = "", aToken: String = ""
    
    ///
    /// Gets the finish URL
    ///
    var finishUrl: String {
        get {
            return self.finishURL
        }
    }
    
    ///
    /// Gets the close URL
    ///
    var closeUrl: String {
        get {
            return self.closeURL
        }
    }
    
    ///
    /// Gets the popup detect url
    ///
    var popupDetectUrl: String {
        get {
            return self.popupDetectURL
        }
    }
    
    ///
    /// Gets the popup close url
    ///
    var popupCloseUrl: String {
        get {
            return self.popupCloseURL
        }
    }
    
    ///
    /// Gets & Sets the client ID
    ///
    var clientId: String {
        get {
            return self.id
        }
        
        set(id) {
            self.id = id
        }
    }
    
    ///
    /// Gets & Sets the client secret
    ///
    var clientSecret: String {
        get {
            return self.secret
        }
        
        set(secret) {
            self.secret = secret
        }
    }
    
    ///
    /// Gets & Sets the user ID
    ///
    var userId: String {
        get {
            return self.user
        }
        
        set(user) {
            self.user = user
        }
    }
    
    ///
    /// Gets & Sets the public token
    ///
    var publicToken: String {
        get {
            return self.pToken
        }
        
        set(pToken) {
            self.pToken = pToken
        }
    }
    
    ///
    /// Gets & Sets the access token
    ///
    var accessToken: String {
        get {
            return self.aToken
        }
        
        set(aToken) {
            self.aToken = aToken
        }
    }
    
    ///
    /// Gets the load URL
    ///
    var loadURL: URLRequest? {
        get {
            var urlString: String = self.baseURL
            
            urlString = urlString.appendingFormat("?client_id=\(self.clientId)")
            urlString = urlString.appendingFormat("&client_user_id=\(self.userId)")
            
            if(self.publicToken.count > 0) {
                urlString = urlString.appendingFormat("&public_token=\(self.publicToken)")
            }
            
            urlString = urlString.appendingFormat("&finish_url=\(self.finishURL)")
            urlString = urlString.appendingFormat("&close_url=\(self.closeURL)")
            
            if let url = URL(string: urlString) {
                return URLRequest(url: url)
            }

            return nil
        }
    }
    
    var tokens: [String: Any] {
        get {
            return [:]
        }
        
        set(tokens) {
            if let aToken = tokens["accessToken"] {
                self.aToken = aToken as! String
            } else {
                self.aToken = ""
            }
            
            if let pToken = tokens["publicToken"] {
                self.pToken = pToken as! String
            } else {
                self.pToken = ""
            }
        }
    }
    
    //*************************************************************************************
    
    // HUMAN API TOKENS
    
    //*************************************************************************************
    
    
    static let humanAPITokenPassBackKey: String = "humanAPITokenPassBackKey"
    private let tokenURL: String = "https://user.humanapi.co/v1/connect/tokens"
    private var humanID: String = "", sessionTOKEN: String = ""
    
    ///
    /// Sets the human API response
    ///
    /// :param: response The human API response
    ///
    public func setHumanAPIResponse(response: URL) {
        if let human = response.valueOf("humanId") {
            self.humanID = human
        } else {
            self.humanID = ""
        }
        
        if let token = response.valueOf("sessionToken") {
            self.sessionTOKEN = token
        } else {
            self.sessionTOKEN = ""
        }
    }
    
    var tokenUrl: String {
        get {
            return self.tokenURL
        }
    }
    
    var humanId: String {
        get {
            return self.humanID
        }
    }
    
    var sessionToken: String {
        get {
            return self.sessionTOKEN
        }
    }
    
    ///
    /// Gets the token request body
    ///
    /// :return: The token request body
    ///
    public func getTokenRequestBody() -> [String: Any] {
        var params: [String: Any] = [:]
        
        params["clientId"] = clientId;
        params["clientSecret"] = clientSecret
        params["humanId"] = humanId
        params["sessionToken"] = sessionToken
        
        return params
    }
    
    //*************************************************************************************
    
    // HUMAN DATA
    
    //*************************************************************************************
    
    static let humanAPIDataPassBackKey: String = "humanAPIDataPassBackKey"
    private let dataURL: String = "https://api.humanapi.co/v1/human"
    private var humanDataSet: [String: Any] = [:]
    
    var dataUrl: String {
        get {
            return self.dataURL
        }
    }
    
    var dataHeader: [String : String] {
        get {
            var header: [String : String] = [:]
            header["Authorization"] = "Bearer " + accessToken
            
            return header
        }
    }
    
    var humanData: [String: Any] {
        get {
            return self.humanDataSet
        }
        
        set(humanDataSet) {
            self.humanDataSet = humanDataSet
        }
    }
    
    //*************************************************************************************
    
    // PARSE JSON FORMAT FOR HYBRID
    
    //*************************************************************************************
    
    ///
    /// Converts HUMAN API data to JSON string for hybrid
    ///
    /// :param: pluginMsg The plugin msg if any
    ///
    /// :return: The converted HUMAN API data JSON String
    ///
    public func getHumanAPIHybridData(pluginMsg: String) -> String {
        var dataMap: [String : String] = [:]
        dataMap["clientId"] = clientId
        dataMap["clientSecret"] = clientSecret
        dataMap["userID"] = userId
        dataMap["humanID"] = humanId
        dataMap["sessionToken"] = sessionToken
        dataMap["publicToken"] = publicToken
        dataMap["accessToken"] = accessToken
        dataMap["humanAPIData"] = humanData.toJSONString()
        dataMap["pluginMsg"] = pluginMsg
        
        return dataMap.toJSONString()
    }
}