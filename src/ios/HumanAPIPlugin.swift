//
//  HumanAPIPlugin.swift
//  HumanAPIPlugin IOS Controller Class
//
//  Created by Vikram Ezhil on 04/11/18.
//

import Foundation
import UIKit

@objc(HumanAPIPlugin) class HumanAPIPlugin: CDVPlugin, HumanAPIVCDelegate {
    var command: CDVInvokedUrlCommand?

    var storyboard: UIStoryboard?

    override func pluginInitialize() {
        super.pluginInitialize()

        // Initializing the storyboard
        storyboard = UIStoryboard(name: "Main", bundle: nil)
    }

    //*************************************************************************************

    // HUMAN API

    //*************************************************************************************

    private var humanAPIVC: HumanAPIVC?
    private var humanCDVContext: CDVInvokedUrlCommand?

    ///
    /// Triggers Human API
    ///
    /// :param: command The cdv url command instance
    ///
    @objc(trigger:)
    func trigger(command: CDVInvokedUrlCommand) {
        // Saving a reference of the human API command invoke context
        humanCDVContext = command

        if let triggerType = command.arguments[0] as? String, let clientID = command.arguments[1] as? String, let clientSecret = command.arguments[2] as? String,
            let userID = command.arguments[3] as? String, let publicToken = command.arguments[4] as? String, let accessToken = command.arguments[5] as? String {
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

    // @Override HumanAPIVCDelegate Methods

    func onHumanAPIUpdate(success: Bool, humanAPIData: String) {
        let result = CDVPluginResult(status: success ? CDVCommandStatus_OK : CDVCommandStatus_ERROR, messageAs: humanAPIData)
        result?.setKeepCallbackAs(true)

        if let cdvUrl = humanCDVContext {
            self.commandDelegate!.send(result, callbackId: cdvUrl.callbackId)
        }
    }
}