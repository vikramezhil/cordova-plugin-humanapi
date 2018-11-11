//
//  Extensions.swift
//
//  Created by Vikram Ezhil on 04/11/18.
//

import Foundation

extension URL {
    ///
    /// Gets the value based on the query parameter name in an URL
    ///
    /// :queryParamaterName: The query parameter name
    ///
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}

extension String {
    ///
    /// Converts the string to dictionary
    ///
    /// :return: The converted data to dictionary
    ///
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}

extension Data {
    func toString() -> String? {
        if let data = String(data: self, encoding: .utf8) {
            return data
        } else {
            return nil
        }
    }
}

extension Dictionary where Key==String, Value==String {
    func toJSONString() -> String {
        do {
            // Convert to data
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            // Convert to string
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonString
            }
        } catch {
            print("toJSONString() conversion error = \(error.localizedDescription)")
        }
        
        return ""
    }
}

extension Dictionary where Key==String, Value==Any {
    func toJSONString() -> String {
        do {
            // Convert to data
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            // Convert to string
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonString
            }
        } catch {
            print("toJSONString() conversion error = \(error.localizedDescription)")
        }
        
        return ""
    }
}