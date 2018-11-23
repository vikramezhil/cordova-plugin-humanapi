//
//  HumanAPIProperties.swift
//
//  Created by Vikram Ezhil on 23/11/18.
//

import Foundation

protocol HumanAPIVCDelegate: class {
    ///
    /// Sends an update with the human API data
    ///
    /// :param: command The callback context 
    /// :param: success The success status
    /// :param: humanAPIData The human API response data
    ///
    func onHumanAPIUpdate(command: CDVInvokedUrlCommand?, success: Bool, humanAPIData: String)
}

struct HumanAPIProperties {
    // https://reference.humanapi.co/v2.1/reference#activities
    static let ACTIVITIES_URL = "https://api.humanapi.co/v1/human/activities"

    // https://reference.humanapi.co/v2.1/reference#activity-summaries
    static let ACTIVITIES_SUMMARIES_URL = "https://api.humanapi.co/v1/human/activities/summaries"

    // https://reference.humanapi.co/v2.1/reference#blood-glucose
    static let BLOOD_GLUCOSE_URL = "https://api.humanapi.co/v1/human/blood_glucose"

    // https://reference.humanapi.co/v2.1/reference#blood-oxygen
    static let BLOOD_OXYGEN_URL = "https://api.humanapi.co/v1/human/blood_oxygen"

    // https://reference.humanapi.co/v2.1/reference#blood-pressure
    static let BLOOD_PRESSURE_URL = "https://api.humanapi.co/v1/human/blood_pressure"

    // https://reference.humanapi.co/v2.1/reference#body-mass-index-bmi
    static let BMI_URL = "https://api.humanapi.co/v1/human/bmi"

    // https://reference.humanapi.co/v2.1/reference#body-fat
    static let BODY_FAT_URL = "https://api.humanapi.co/v1/human/body_fat"

    // https://reference.humanapi.co/v2.1/reference#heart-rate
    static let HEART_RATE_URL = "https://api.humanapi.co/v1/human/heart_rate"

    // https://reference.humanapi.co/v2.1/reference#heart-rate-summaries
    static let HEART_RATE_SUMMARIES_URL = "https://api.humanapi.co/v1/human/heart_rate/summaries"

    // https://reference.humanapi.co/v2.1/reference#height
    static let HEIGHT_URL = "https://api.humanapi.co/v1/human/height"

    // https://reference.humanapi.co/v2.1/reference#weight
    static let WEIGHT_URL = "https://api.humanapi.co/v1/human/weight"

    // https://reference.humanapi.co/v2.1/reference#locations
    static let LOCATIONS_URL = "https://api.humanapi.co/v1/human/locations"

    // https://reference.humanapi.co/v2.1/reference#meals
    static let MEALS_URL = "https://api.humanapi.co/v1/human/food/meals"

    // https://reference.humanapi.co/v2.1/reference#sleeps
    static let SLEEPS_URL = "https://api.humanapi.co/v1/human/sleeps"

    // https://reference.humanapi.co/v2.1/reference#sleep-summaries
    static let SLEEP_SUMMARIES_URL = "https://api.humanapi.co/v1/human/sleeps/summaries"

    // https://reference.humanapi.co/v2.1/reference#human-summary
    static let HUMAN_SUMMARY_URL = "https://api.humanapi.co/v1/human"

    // https://reference.humanapi.co/v2.1/reference#profile-1
    static let HUMAN_PROFILE_URL = "https://api.humanapi.co/v1/human/profile"
}