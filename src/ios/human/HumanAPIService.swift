//
//  HumanAPIService.swift
//
//  Created by Vikram Ezhil on 23/11/18.
//

import Foundation

class HumanAPIService: NSObject, ServiceDelegate {
    private let TAG: String = "HumanAPIService"
    
    private var service: Service = Service()
    private var humanAPIModel: HumanAPIModel = HumanAPIModel()

    weak var humanAPIServiceDelegate: HumanAPIVCDelegate?

    ///
    /// Initializer
    ///
    override init() {
        super.init()

        service.serviceDelegate = self
    }

    ///
    /// Executes the human API services based on key
    ///
    /// :param: command The callback context
    /// :param: key The human api service key
    /// :param: accessToken The access token
    ///
    func execute(command: CDVInvokedUrlCommand, key: String, accessToken: String) {
        if(accessToken.count == 0) {
            humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: "", key: key, pluginMsg: "Access token is empty"))
        } else {
            if let url = humanAPIModel.getDataURL(dataKey: key) {
                // Saving the access token in the human api model
                humanAPIModel.accessToken = accessToken

                service.get(command: command, passbackKey: key, requestLink: url, customHeaders: humanAPIModel.dataHeader)
            } else {
                humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: "", key: key, pluginMsg: "Unknown data key, unable to generate url"))
            }
        }
    }

    ///
    /// Executes the human API services based on key & filter
    ///
    /// :param: command The callback context
    /// :param: key The human api service key
    /// :param: accessToken The access token
    /// :param: filterName The filter name
    ///
    func executeByFilter(command: CDVInvokedUrlCommand, key: String, accessToken: String, filterName: String) {
        if(accessToken.count == 0) {
            humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: "", key: key, pluginMsg: "Access token is empty"))
        } else {
            if let url = humanAPIModel.getDataURL(dataKey: key) {
                // Saving the access token in the human api model
                humanAPIModel.accessToken = accessToken

                let filterUrl: String = "\(url)?source=\(filterName)"
                service.get(command: command, passbackKey: key, requestLink: filterUrl, customHeaders: humanAPIModel.dataHeader)
            } else {
                humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: "", key: key, pluginMsg: "Unknown data key, unable to generate url"))
            }
        }
    }

    // @Override ServiceDelegate Methods
    
    func onServiceRunning(command: CDVInvokedUrlCommand?, passBackKey: String, serviceRunning: Bool) {
        print(TAG, "Service running status for \(passBackKey) = \(serviceRunning)")
    }
    
    func onServiceResponse(command: CDVInvokedUrlCommand?, passBackKey: String, serviceResponse: String) {
        print(TAG, "Service success for \(passBackKey) = \(serviceResponse)")
        
        humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: true, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: serviceResponse, key: passBackKey, pluginMsg: "Human API Wellness data got"))
    }
    
    func onServiceError(command: CDVInvokedUrlCommand?, passBackKey: String, errorMessage: String) {
        print(TAG, "Service error for \(passBackKey) = \(errorMessage)")
        
        humanAPIServiceDelegate?.onHumanAPIUpdate(command: command, success: false, humanAPIData: humanAPIModel.getHumanAPIHybridData(humanAPIData: "", key: passBackKey, pluginMsg: errorMessage))
    }
}