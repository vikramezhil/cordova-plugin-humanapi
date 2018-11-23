//
//  HumanAPIPlugin.swift
//  HumanAPIPlugin IOS Controller Class
//
//  Created by Vikram Ezhil on 04/11/18.
//

import Foundation
import UIKit

@objc(HumanAPIPlugin) class HumanAPIPlugin: CDVPlugin, HumanAPIVCDelegate {
    private let TAG: String = "HumanAPIPlugin"

    var command: CDVInvokedUrlCommand?

    var storyboard: UIStoryboard?

    private var humanAPIService: HumanAPIService?

    override func pluginInitialize() {
        super.pluginInitialize()

        // Initializing the storyboard
        storyboard = UIStoryboard(name: "Human", bundle: nil)
        
        humanAPIService = HumanAPIService()
        humanAPIService?.humanAPIServiceDelegate = self
    }

    //*************************************************************************************

    // HUMAN API

    //*************************************************************************************

    private var humanAPIVC: HumanAPIVC?
    private var humanCDVContext: CDVInvokedUrlCommand?

    ///
    /// Triggers Human API Authentication
    ///
    /// :param: command The cdv url command instance
    ///
    @objc(auth:)
    func auth(command: CDVInvokedUrlCommand) {
        // Saving a reference of the human API command invoke context
        humanCDVContext = command

        if let clientID = command.arguments[0] as? String, let clientSecret = command.arguments[1] as? String,
            let userID = command.arguments[2] as? String, let publicToken = command.arguments[3] as? String, 
                let accessToken = command.arguments[4] as? String {
            humanAPIVC = storyboard?.instantiateViewController(withIdentifier: "humanAPIVC") as? HumanAPIVC
            humanAPIVC?.humanAPIVCDelegate = self
            humanAPIVC?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            humanAPIVC?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

            DispatchQueue.global().async {
                DispatchQueue.main.async(execute: {
                    if let vc = self.humanAPIVC {
                        vc.initiHumanTokens(clientID: clientID, clientSecret: clientSecret, userID: userID, publicToken: publicToken, accessToken: accessToken)
                        self.viewController.present(vc, animated: true, completion: nil)
                    }
                })
            }
        }
    }

    ///
    /// Executes the human API wellness services
    ///
    /// :param: command The cdv url command instance
    ///
    @objc(execute:)
    func execute(command: CDVInvokedUrlCommand) {
        if let wellnessKey = command.arguments[0] as? String, let token = command.arguments[1] as? String {
            humanAPIService?.execute(command: command, key: wellnessKey, accessToken: token)
        }
    }

    // @Override HumanAPIVCDelegate Methods

    func onHumanAPIUpdate(command: CDVInvokedUrlCommand?, success: Bool, humanAPIData: String) {
        let result = CDVPluginResult(status: success ? CDVCommandStatus_OK : CDVCommandStatus_ERROR, messageAs: humanAPIData)
        result?.setKeepCallbackAs(true)

        if let humanCDVUrl = humanCDVContext {
            self.commandDelegate!.send(result, callbackId: humanCDVUrl.callbackId)
            humanCDVContext = nil
        } else if let cdvUrl = command {
            self.commandDelegate!.send(result, callbackId: cdvUrl.callbackId)
        } else {
            print(TAG, "Unable to send back data, callback ID is nil")
        }
    }
}