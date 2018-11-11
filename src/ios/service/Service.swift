//
//  Service.swift
//
//  Created by Vikram Ezhil on 04/11/18.
//

import Foundation

protocol ServiceDelegate: class {
    //
    // Updates with the service running status
    //
    // :param: passBackKey The pass back key
    // :param: serviceRunning The service running status
    //
    func onServiceRunning(passBackKey: String, serviceRunning: Bool)
    
    //
    // Updates with the service response
    //
    // :param: passBackKey The pass back key
    // :param: serviceResponse The service response
    //
    func onServiceResponse(passBackKey: String, serviceResponse: [String: Any])
    
    //
    // Updates with the service error
    //
    // :param: passBackKey The pass back key
    // :param: errorMessage The error message
    //
    func onServiceError(passBackKey: String, errorMessage: String)
}

class Service: NSObject {
    
    private let TAG: String = "Service"

    weak var serviceDelegate: ServiceDelegate?
    
    ///
    /// Initializer
    ///
    override init() {
        super.init()
    }
    
    ///
    /// Sends a POST request
    ///
    /// :param: passBackKey The pass back key
    /// :param: requestLink The request link
    /// :param: customHeaders The custom headers if any
    /// :param: requestBody The request body
    ///
    /// :callbacks: ServiceDelegate onServiceRunning, onServiceResponse, onServiceError
    ///
    public func post(passbackKey: String, requestLink: String, customHeaders: [String: String], requestBody: [String: Any]) {
        print(TAG, "Request type = POST");
        print(TAG, "Pass back key = \(passbackKey)");
        print(TAG, "Request link = \(requestLink)");
        print(TAG, "Custom headers = \(customHeaders)");
        print(TAG, "Request params = \(requestBody)");
        
        let request = NSMutableURLRequest(url: NSURL(string: requestLink)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        // Adding custom headers if applicable
        if customHeaders.count > 0 {
            request.allHTTPHeaderFields = customHeaders
        }
        
        // Setting the http body
        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        request.httpBody = jsonData
        
        // Sending back the service running status
        serviceDelegate?.onServiceRunning(passBackKey: passbackKey, serviceRunning: true)

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            // Sending back the service running status
            self.serviceDelegate?.onServiceRunning(passBackKey: passbackKey, serviceRunning: false)
            
            if(error == nil) {
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200) {
                        if let responseData = data, let responseString = responseData.toString(), let responseDict = responseString.convertToDictionary() {
                            self.serviceDelegate?.onServiceResponse(passBackKey: passbackKey, serviceResponse: responseDict)
                        } else {
                            self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Data conversion error = \(String(describing: data))")
                        }
                    } else {
                        self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Service error, status code = \(httpResponse.statusCode)")
                    }
                } else {
                    self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Service error, status code unavailable")
                }
            } else {
                self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: error.debugDescription)
            }
        })
        
        task.resume()
    }
    
    
    ///
    /// Sends a GET request
    ///
    /// :param: passBackKey The pass back key
    /// :param: requestLink The request link
    /// :param: customHeaders The custom headers if any
    ///
    /// :callbacks: ServiceDelegate onServiceRunning, onServiceResponse, onServiceError
    ///
    public func get(passbackKey: String, requestLink: String, customHeaders: [String: String]) {
        print(TAG, "Request type = GET");
        print(TAG, "Pass back key = \(passbackKey)");
        print(TAG, "Request link = \(requestLink)");
        print(TAG, "Custom headers = \(customHeaders)");
        
        let request = NSMutableURLRequest(url: NSURL(string: requestLink)! as URL)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        // Adding custom headers if applicable
        if customHeaders.count > 0 {
            request.allHTTPHeaderFields = customHeaders
        }
        
        // Sending back the service running status
        serviceDelegate?.onServiceRunning(passBackKey: passbackKey, serviceRunning: true)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            // Sending back the service running status
            self.serviceDelegate?.onServiceRunning(passBackKey: passbackKey, serviceRunning: false)
            
            if(error == nil) {
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200) {
                        if let responseData = data, let responseString = responseData.toString(), let responseDict = responseString.convertToDictionary() {
                            self.serviceDelegate?.onServiceResponse(passBackKey: passbackKey, serviceResponse: responseDict)
                        } else {
                            self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Data conversion error = \(String(describing: data))")
                        }
                    } else {
                        self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Service error, status code = \(httpResponse.statusCode)")
                    }
                } else {
                    self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: "Service error, status code unavailable")
                }
            } else {
                self.serviceDelegate?.onServiceError(passBackKey: passbackKey, errorMessage: error.debugDescription)
            }
        })
        
        task.resume()
    }
}