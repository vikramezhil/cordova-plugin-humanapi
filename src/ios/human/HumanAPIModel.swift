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
    private let integrationPopupDetectURL: String = "popup=1"
    private let popupDetectURL: String = "https://user.humanapi.co/x/close"
    private let popupCloseURL: String = "https://close-popup"
    private let popupCloseWithMsgURL: String = "https://close-popup-with-message"
    
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
    /// Gets the integration popup detect url
    ///
    var integrationPopupDetectUrl: String {
        get {
            return self.integrationPopupDetectURL
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
    /// Gets the popup close with message url
    ///
    var popupCloseWithMsgUrl: String {
        get {
            return self.popupCloseWithMsgURL
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
    
    var tokens: String {
        get {
            return ""
        }
        
        set(tokens) {
            let parseTokens = tokens.convertToDictionary()

            if let unwrappedTokens = parseTokens {
                if let aToken = unwrappedTokens["accessToken"] {
                    self.aToken = aToken as! String
                } else {
                    self.aToken = ""
                }
                
                if let pToken = unwrappedTokens["publicToken"] {
                    self.pToken = pToken as! String
                } else {
                    self.pToken = ""
                }
            } else {
                self.aToken = ""
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
    
    ///
    /// Gets the wellness data url based on key
    ///
    /// :param: dataKey The wellness data key
    ///
    /// :return: The wellness data url based on key
    ///
    func getDataURL(dataKey: String) -> String? {
        if(dataKey == "activities") {
            return HumanAPIProperties.ACTIVITIES_URL
        } else if(dataKey == "activitiesSummaries") {
            return HumanAPIProperties.ACTIVITIES_SUMMARIES_URL
        } else if(dataKey == "bloodGlucose") {
            return HumanAPIProperties.BLOOD_GLUCOSE_URL
        } else if(dataKey == "bloodOxygen") {
            return HumanAPIProperties.BLOOD_OXYGEN_URL
        } else if(dataKey == "bloodPressure") {
            return HumanAPIProperties.BLOOD_PRESSURE_URL
        } else if(dataKey == "bodyMassIndex") {
            return HumanAPIProperties.BMI_URL
        } else if(dataKey == "bodyFat") {
            return HumanAPIProperties.BODY_FAT_URL
        } else if(dataKey == "heartRate") {
            return HumanAPIProperties.HEART_RATE_URL
        } else if(dataKey == "heartRateSummaries") {
            return HumanAPIProperties.HEART_RATE_SUMMARIES_URL
        } else if(dataKey == "height") {
            return HumanAPIProperties.HEIGHT_URL
        } else if(dataKey == "weight") {
            return HumanAPIProperties.WEIGHT_URL
        } else if(dataKey == "locations") {
            return HumanAPIProperties.LOCATIONS_URL
        } else if(dataKey == "meals") {
            return HumanAPIProperties.MEALS_URL
        } else if(dataKey == "sleeps") {
            return HumanAPIProperties.SLEEPS_URL
        } else if(dataKey == "sleepSummaries") {
            return HumanAPIProperties.SLEEP_SUMMARIES_URL
        } else if(dataKey == "humanSummary") {
            return HumanAPIProperties.HUMAN_SUMMARY_URL
        } else if(dataKey == "profile") {
            return HumanAPIProperties.HUMAN_PROFILE_URL
        } else {
            return nil
        }
    }
    
    var dataHeader: [String : String] {
        get {
            var header: [String : String] = [:]
            header["Authorization"] = "Bearer " + accessToken
            
            return header
        }
    }
    
    //*************************************************************************************
    
    // PARSE JSON FORMAT FOR HYBRID
    
    //*************************************************************************************
    
    ///
    /// Converts HUMAN API tokens data to JSON string for hybrid
    ///
    /// :param: pluginMsg The plugin msg if any
    ///
    /// :return: The converted HUMAN API data JSON String
    ///
    public func getHumanAPIHybridTokensData(pluginMsg: String) -> String {
        var dataMap: [String : String] = [:]

        dataMap["clientId"] = clientId
        dataMap["clientSecret"] = clientSecret
        dataMap["userID"] = userId
        dataMap["humanID"] = humanId
        dataMap["sessionToken"] = sessionToken
        dataMap["publicToken"] = publicToken
        dataMap["accessToken"] = accessToken
        dataMap["pluginMsg"] = pluginMsg
        
        return dataMap.toJSONString()
    }

    ///
    /// Converts HUMAN API data to JSON string for hybrid
    ///
    /// :param: humanAPIData The human API data
    /// :param: key The data key
    /// :param: pluginMsg The plugin msg if any
    ///
    /// :return: The converted HUMAN API data JSON String
    ///
    public func getHumanAPIHybridData(humanAPIData: String, key: String, pluginMsg: String) -> String {
        var dataMap: [String : String] = [:]

        dataMap["humanAPIData"] = humanAPIData
        dataMap["key"] = key
        dataMap["pluginMsg"] = pluginMsg
        
        return dataMap.toJSONString()
    }
}