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
    static let HUMAN_URLS: [String : String] = [
                                                    "activities" : HumanAPIProperties.ACTIVITIES_URL, 
                                                    "activitiesSummaries" : HumanAPIProperties.ACTIVITIES_SUMMARIES_URL,
                                                    "bloodGlucoseLatest" : HumanAPIProperties.BLOOD_GLUCOSE_LATEST_URL,
                                                    "bloodGlucose" : HumanAPIProperties.BLOOD_GLUCOSE_URL,
                                                    "bloodOxygenLatest" : HumanAPIProperties.BLOOD_OXYGEN_LATEST_URL,
                                                    "bloodOxygen" : HumanAPIProperties.BLOOD_OXYGEN_URL,
                                                    "bloodPressureLatest" : HumanAPIProperties.BLOOD_PRESSURE_LATEST_URL,
                                                    "bloodPressure" : HumanAPIProperties.BLOOD_PRESSURE_URL,
                                                    "bodyMassIndexLatest" : HumanAPIProperties.BMI_LATEST_URL,
                                                    "bodyMassIndex" : HumanAPIProperties.BMI_URL,
                                                    "bodyFatLatest" : HumanAPIProperties.BODY_FAT_LATEST_URL,
                                                    "bodyFat" : HumanAPIProperties.BODY_FAT_URL,
                                                    "heartRateLatest" : HumanAPIProperties.HEART_RATE_LATEST_URL,
                                                    "heartRate" : HumanAPIProperties.HEART_RATE_URL,
                                                    "heartRateSummaries" : HumanAPIProperties.HEART_RATE_SUMMARIES_URL,
                                                    "heightLatest" : HumanAPIProperties.HEIGHT_LATEST_URL,
                                                    "height" : HumanAPIProperties.HEIGHT_URL,
                                                    "weightLatest" : HumanAPIProperties.WEIGHT_LATEST_URL,
                                                    "weight" : HumanAPIProperties.WEIGHT_URL,
                                                    "locations" : HumanAPIProperties.LOCATIONS_URL,
                                                    "meals" : HumanAPIProperties.MEALS_URL,
                                                    "sleeps" : HumanAPIProperties.SLEEPS_URL,
                                                    "sleepSummaries" : HumanAPIProperties.SLEEP_SUMMARIES_URL,
                                                    "humanSummary" : HumanAPIProperties.HUMAN_SUMMARY_URL,
                                                    "profile" : HumanAPIProperties.HUMAN_PROFILE_URL,
                                                    "sources" : HumanAPIProperties.HUMAN_SOURCE_URL
                                                ]

    // https://reference.humanapi.co/v2.1/reference#activities
    private static let ACTIVITIES_URL = "https://api.humanapi.co/v1/human/activities"

    // https://reference.humanapi.co/v2.1/reference#activity-summaries
    private static let ACTIVITIES_SUMMARIES_URL = "https://api.humanapi.co/v1/human/activities/summaries"

    // https://reference.humanapi.co/v2.1/reference#blood-glucose
    private static let BLOOD_GLUCOSE_LATEST_URL = "https://api.humanapi.co/v1/human/blood_glucose"
    private static let BLOOD_GLUCOSE_URL = "https://api.humanapi.co/v1/human/blood_glucose/readings"

    // https://reference.humanapi.co/v2.1/reference#blood-oxygen
    private static let BLOOD_OXYGEN_LATEST_URL = "https://api.humanapi.co/v1/human/blood_oxygen"
    private static let BLOOD_OXYGEN_URL = "https://api.humanapi.co/v1/human/blood_oxygen/readings"

    // https://reference.humanapi.co/v2.1/reference#blood-pressure
    private static let BLOOD_PRESSURE_LATEST_URL = "https://api.humanapi.co/v1/human/blood_pressure"
    private static let BLOOD_PRESSURE_URL = "https://api.humanapi.co/v1/human/blood_pressure/readings"

    // https://reference.humanapi.co/v2.1/reference#body-mass-index-bmi
    private static let BMI_LATEST_URL = "https://api.humanapi.co/v1/human/bmi"
    private static let BMI_URL = "https://api.humanapi.co/v1/human/bmi/readings"

    // https://reference.humanapi.co/v2.1/reference#body-fat
    private static let BODY_FAT_LATEST_URL = "https://api.humanapi.co/v1/human/body_fat"
    private static let BODY_FAT_URL = "https://api.humanapi.co/v1/human/body_fat/readings"

    // https://reference.humanapi.co/v2.1/reference#heart-rate
    private static let HEART_RATE_LATEST_URL = "https://api.humanapi.co/v1/human/heart_rate"
    private static let HEART_RATE_URL = "https://api.humanapi.co/v1/human/heart_rate/readings"

    // https://reference.humanapi.co/v2.1/reference#heart-rate-summaries
    private static let HEART_RATE_SUMMARIES_URL = "https://api.humanapi.co/v1/human/heart_rate/summaries"

    // https://reference.humanapi.co/v2.1/reference#height
    private static let HEIGHT_LATEST_URL = "https://api.humanapi.co/v1/human/height"
    private static let HEIGHT_URL = "https://api.humanapi.co/v1/human/height/readings"

    // https://reference.humanapi.co/v2.1/reference#weight
    private static let WEIGHT_LATEST_URL = "https://api.humanapi.co/v1/human/weight"
    private static let WEIGHT_URL = "https://api.humanapi.co/v1/human/weight/readings"

    // https://reference.humanapi.co/v2.1/reference#locations
    private static let LOCATIONS_URL = "https://api.humanapi.co/v1/human/locations"

    // https://reference.humanapi.co/v2.1/reference#meals
    private static let MEALS_URL = "https://api.humanapi.co/v1/human/food/meals"

    // https://reference.humanapi.co/v2.1/reference#sleeps
    private static let SLEEPS_URL = "https://api.humanapi.co/v1/human/sleeps"

    // https://reference.humanapi.co/v2.1/reference#sleep-summaries
    private static let SLEEP_SUMMARIES_URL = "https://api.humanapi.co/v1/human/sleeps/summaries"

    // https://reference.humanapi.co/v2.1/reference#human-summary
    private static let HUMAN_SUMMARY_URL = "https://api.humanapi.co/v1/human"

    // https://reference.humanapi.co/v2.1/reference#profile-1
    private static let HUMAN_PROFILE_URL = "https://api.humanapi.co/v1/human/profile"

    // https://reference.humanapi.co/v2.1/reference#sources
    private static let HUMAN_SOURCE_URL = "https://api.humanapi.co/v1/human/sources"
}