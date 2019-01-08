package com.github.vikramezhil.cordova.human;

import java.util.HashMap;
import java.util.Map;

/**
 * HumanAPI Properties
 * 
 * @author Vikram Ezhil
 */

public class HumanAPIProperties {
    public static final Map<String, String> HUMAN_URLS = new HashMap<String, String>() {{
        put("activities", ACTIVITIES_URL);
        put("activitiesSummaries", ACTIVITIES_SUMMARIES_URL);
        put("bloodGlucoseLatest", BLOOD_GLUCOSE_LATEST_URL);
        put("bloodGlucose", BLOOD_GLUCOSE_URL);
        put("bloodOxygenLatest", BLOOD_OXYGEN_LATEST_URL);
        put("bloodOxygen", BLOOD_OXYGEN_URL);
        put("bloodPressureLatest", BLOOD_PRESSURE_LATEST_URL);
        put("bloodPressure", BLOOD_PRESSURE_URL);
        put("bodyMassIndexLatest", BMI_LATEST_URL);
        put("bodyMassIndex", BMI_URL);
        put("bodyFatLatest", BODY_FAT_LATEST_URL);
        put("bodyFat", BODY_FAT_URL);
        put("heartRateLatest", HEART_RATE_LATEST_URL);
        put("heartRate", HEART_RATE_URL);
        put("heartRateSummaries", HEART_RATE_SUMMARIES_URL);
        put("heightLatest", HEIGHT_LATEST_URL);
        put("height", HEIGHT_URL);
        put("weightLatest", WEIGHT_LATEST_URL);
        put("weight", WEIGHT_URL);
        put("locations", LOCATIONS_URL);
        put("meals", MEALS_URL);
        put("sleeps", SLEEPS_URL);
        put("sleepSummaries", SLEEP_SUMMARIES_URL);
        put("humanSummary", HUMAN_SUMMARY_URL);
        put("profile", HUMAN_PROFILE_URL);
        put("sources", HUMAN_SOURCE_URL);
    }};

    // https://reference.humanapi.co/v2.1/reference#activities
    private static final String ACTIVITIES_URL = "https://api.humanapi.co/v1/human/activities";

    // https://reference.humanapi.co/v2.1/reference#activity-summaries
    private static final String ACTIVITIES_SUMMARIES_URL = "https://api.humanapi.co/v1/human/activities/summaries";

    // https://reference.humanapi.co/v2.1/reference#blood-glucose
    private static final String BLOOD_GLUCOSE_LATEST_URL = "https://api.humanapi.co/v1/human/blood_glucose";
    private static final String BLOOD_GLUCOSE_URL = "https://api.humanapi.co/v1/human/blood_glucose/readings";

    // https://reference.humanapi.co/v2.1/reference#blood-oxygen
    private static final String BLOOD_OXYGEN_LATEST_URL = "https://api.humanapi.co/v1/human/blood_oxygen";
    private static final String BLOOD_OXYGEN_URL = "https://api.humanapi.co/v1/human/blood_oxygen/readings";

    // https://reference.humanapi.co/v2.1/reference#blood-pressure
    private static final String BLOOD_PRESSURE_LATEST_URL = "https://api.humanapi.co/v1/human/blood_pressure";
    private static final String BLOOD_PRESSURE_URL = "https://api.humanapi.co/v1/human/blood_pressure/readings";

    // https://reference.humanapi.co/v2.1/reference#body-mass-index-bmi
    private static final String BMI_LATEST_URL = "https://api.humanapi.co/v1/human/bmi";
    private static final String BMI_URL = "https://api.humanapi.co/v1/human/bmi/readings";

    // https://reference.humanapi.co/v2.1/reference#body-fat
    private static final String BODY_FAT_LATEST_URL = "https://api.humanapi.co/v1/human/body_fat";
    private static final String BODY_FAT_URL = "https://api.humanapi.co/v1/human/body_fat/readings";

    // https://reference.humanapi.co/v2.1/reference#heart-rate
    private static final String HEART_RATE_LATEST_URL = "https://api.humanapi.co/v1/human/heart_rate";
    private static final String HEART_RATE_URL = "https://api.humanapi.co/v1/human/heart_rate/readings";

    // https://reference.humanapi.co/v2.1/reference#heart-rate-summaries
    private static final String HEART_RATE_SUMMARIES_URL = "https://api.humanapi.co/v1/human/heart_rate/summaries";

    // https://reference.humanapi.co/v2.1/reference#height
    private static final String HEIGHT_LATEST_URL = "https://api.humanapi.co/v1/human/height";
    private static final String HEIGHT_URL = "https://api.humanapi.co/v1/human/height/readings";

    // https://reference.humanapi.co/v2.1/reference#weight
    private static final String WEIGHT_LATEST_URL = "https://api.humanapi.co/v1/human/weight";
    private static final String WEIGHT_URL = "https://api.humanapi.co/v1/human/weight/readings";

    // https://reference.humanapi.co/v2.1/reference#locations
    private static final String LOCATIONS_URL = "https://api.humanapi.co/v1/human/locations";

    // https://reference.humanapi.co/v2.1/reference#meals
    private static final String MEALS_URL = "https://api.humanapi.co/v1/human/food/meals";

    // https://reference.humanapi.co/v2.1/reference#sleeps
    private static final String SLEEPS_URL = "https://api.humanapi.co/v1/human/sleeps";

    // https://reference.humanapi.co/v2.1/reference#sleep-summaries
    private static final String SLEEP_SUMMARIES_URL = "https://api.humanapi.co/v1/human/sleeps/summaries";

    // https://reference.humanapi.co/v2.1/reference#human-summary
    private static final String HUMAN_SUMMARY_URL = "https://api.humanapi.co/v1/human";

    // https://reference.humanapi.co/v2.1/reference#profile-1
    private static final String HUMAN_PROFILE_URL = "https://api.humanapi.co/v1/human/profile";

    // https://reference.humanapi.co/v2.1/reference#sources
    private static final String HUMAN_SOURCE_URL = "https://api.humanapi.co/v1/human/sources";
}