package com.github.vikramezhil.cordova.human;

import android.net.Uri;

import org.json.JSONObject;

import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import com.github.vikramezhil.cordova.human.HumanAPIProperties;

/**
 * HumanAPI Model
 *
 * @author Vikram Ezhil
 */

public class HumanAPIModel {

    public HumanAPIModel() {}

    //*************************************************************************************

    // HUMAN API Authentication

    //*************************************************************************************

    private static final String baseURL = "https://connect.humanapi.co/";
    private static final String finishURL = "https://hapi-finish";
    private static final String closeURL = "https://hapi-close";
    private String clientId = null, clientSecret = null, userId = null, publicToken = null, accessToken = null;

    /**
     * Sets the client ID
     *
     * @param clientId The client ID
     */
    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    /**
     * Sets the client secret
     *
     * @param clientSecret The client secret
     */
    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }

    /**
     * Sets the user ID
     *
     * @param userId The user ID
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * Sets the public token
     *
     * @param publicToken The public token
     */
    public void setPublicToken(String publicToken) {
        this.publicToken = publicToken;
    }

    /**
     * Sets the access token
     *
     * @param accessToken The access token
     */
    public void setAccessToken(String accessToken) { this.accessToken = accessToken; }

    /**
     * Sets the public token
     *
     * @param tokenResponse The token service response
     */
    public void setTokens(String tokenResponse) {
        try {
            JSONObject parseTokenResponse = new JSONObject(tokenResponse);

            if(parseTokenResponse.has("accessToken")) {
                this.accessToken = parseTokenResponse.getString("accessToken");
            } else {
                this.accessToken = null;
            }

            if(parseTokenResponse.has("publicToken")) {
                this.publicToken = parseTokenResponse.getString("publicToken");
            } else {
                this.publicToken = null;
            }
        } catch (Exception e) {
            e.printStackTrace();

            this.accessToken = null;
            this.publicToken = null;
        }
    }

    /**
     * Gets the base url
     *
     * @return The base url
     */
    private String getBaseURL() {
        return baseURL;
    }

    /**
     * Gets the finish url
     *
     * @return The finish url
     */
    public String getFinishURL() {
        return finishURL;
    }

    /**
     * Gets the close url
     *
     * @return The close url
     */
    public String getCloseURL() {
        return closeURL;
    }

    /**
     * Gets the client ID
     *
     * @return The client ID
     */
    public String getClientId() {
        return clientId;
    }

    /**
     * Gets the client secret
     *
     * @return The client secret
     */
    public String getClientSecret() {
        return clientSecret;
    }

    /**
     * Gets the user ID
     *
     * @return The user ID
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Gets the public token
     *
     * @return The public token
     */
    public String getPublicToken() {
        return publicToken;
    }

    /**
     * Gets the access token
     *
     * @return The access token
     */
    public String getAccessToken() {
        return accessToken;
    }

    /**
     * Gets the load url
     *
     * @return The load url if successful, else null
     */
    public String getLoadURL() {
        Uri.Builder urlBuilder = new Uri.Builder();

        if(getClientId() != null && getClientSecret() != null && getUserId() != null) {
            try {
                URL base = new URL(getBaseURL());
                urlBuilder.scheme(base.getProtocol());
                urlBuilder.authority(base.getHost());

                urlBuilder.path("embed");
                urlBuilder.appendQueryParameter("client_id", getClientId());
                urlBuilder.appendQueryParameter("client_user_id", getUserId());
                if (getPublicToken() != null && getPublicToken().length() > 0) {
                    urlBuilder.appendQueryParameter("public_token", getPublicToken());
                }
                urlBuilder.appendQueryParameter("finish_url", getFinishURL());
                urlBuilder.appendQueryParameter("close_url", getCloseURL());

                return urlBuilder.build().toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    //*************************************************************************************

    // HUMAN API TOKENS

    //*************************************************************************************

    static final String humanAPITokenPassBackKey = "humanAPITokenPassBackKey";
    private static final String tokenURL = "https://user.humanapi.co/v1/connect/tokens";
    private String humanId = "", sessionToken = "";

    /**
     * Sets the human API response
     *
     * @param response The human API response
     */
    public void setHumanAPIResponse(String response) {
        Uri uri = Uri.parse(response);

        this.humanId = uri.getQueryParameter("human_id");
        this.sessionToken = uri.getQueryParameter("session_token");
    }

    /**
     * Gets the token url
     *
     * @return The token url
     */
    public String getTokenURL() {
        return tokenURL;
    }

    /**
     * Gets the human ID of the user
     *
     * @return The human ID of the user
     */
    public String getHumanId() {
        return humanId;
    }

    /**
     * Gets the session token of the user
     *
     * @return The session token of the user
     */
    public String getSessionToken() {
        return sessionToken;
    }

    /**
     * Gets the token request body
     *
     * @return The token request body
     */
    public JSONObject getTokenRequestBody() {
        JSONObject params = new JSONObject();

        try{
            params.put("clientId", getClientId());
            params.put("clientSecret", getClientSecret());
            params.put("humanId", getHumanId());
            params.put("sessionToken", getSessionToken());

            return params;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    //*************************************************************************************

    // HUMAN DATA

    //*************************************************************************************

    /**
     * Gets the wellness data url based on key
     *
     * @param key The wellness data key
     *
     * @return The wellness data url based on key
     */
    public String getDataURL(String key) {
        if(key.equals("activities")) {
            return HumanAPIProperties.ACTIVITIES_URL;
        } else if(key.equals("activitiesSummaries")) {
            return HumanAPIProperties.ACTIVITIES_SUMMARIES_URL;
        } else if(key.equals("bloodGlucose")) {
            return HumanAPIProperties.BLOOD_GLUCOSE_URL;
        } else if(key.equals("bloodOxygen")) {
            return HumanAPIProperties.BLOOD_OXYGEN_URL;
        } else if(key.equals("bloodPressure")) {
            return HumanAPIProperties.BLOOD_PRESSURE_URL;
        } else if(key.equals("bodyMassIndex")) {
            return HumanAPIProperties.BMI_URL;
        } else if(key.equals("bodyFat")) {
            return HumanAPIProperties.BODY_FAT_URL;
        } else if(key.equals("heartRate")) {
            return HumanAPIProperties.HEART_RATE_URL;
        } else if(key.equals("heartRateSummaries")) {
            return HumanAPIProperties.HEART_RATE_SUMMARIES_URL;
        } else if(key.equals("height")) {
            return HumanAPIProperties.HEIGHT_URL;
        } else if(key.equals("weight")) {
            return HumanAPIProperties.WEIGHT_URL;
        } else if(key.equals("locations")) {
            return HumanAPIProperties.LOCATIONS_URL;
        } else if(key.equals("meals")) {
            return HumanAPIProperties.MEALS_URL;
        } else if(key.equals("sleeps")) {
            return HumanAPIProperties.SLEEPS_URL;
        } else if(key.equals("sleepSummaries")) {
            return HumanAPIProperties.SLEEP_SUMMARIES_URL;
        } else if(key.equals("humanSummary")) {
            return HumanAPIProperties.HUMAN_SUMMARY_URL;
        } else if(key.equals("profile")) {
            return HumanAPIProperties.HUMAN_PROFILE_URL;
        } else if(key.equals("sources")) {
            return HumanAPIProperties.HUMAN_SOURCE_URL;
        } else {
            return null;
        }
    }

    /**
     * Gets the data header
     *
     * @return The data header
     */
    public Map<String, String> getDataHeader() {
        Map<String, String> header = new HashMap<String, String>();

        header.put("Authorization", "Bearer " + getAccessToken());

        return header;
    }

    //*************************************************************************************

    // PARSE JSON FORMAT FOR HYBRID

    //*************************************************************************************

    /**
     * Converts HUMAN API tokens data to JSON string for hybrid
     *
     * @param pluginMsg The plugin msg if any
     * 
     * @return The converted HUMAN API tokens data JSON String
     */
    public String getHumanAPIHybridTokensData(String pluginMsg) {
        HashMap<String, String> dataMap = new HashMap<String, String>();

        try {
            dataMap.put("clientID", getClientId());
            dataMap.put("clientSecret", getClientSecret());
            dataMap.put("userID", getUserId());
            dataMap.put("humanID", getHumanId());
            dataMap.put("sessionToken", getSessionToken());
            dataMap.put("publicToken", getPublicToken());
            dataMap.put("accessToken", getAccessToken());
            dataMap.put("pluginMsg", pluginMsg);

            return new Gson().toJson(dataMap);
        } catch(Exception e) {
            e.printStackTrace();

            return "Data conversion error";
        }
    }

    /**
     * Converts HUMAN API data to JSON string for hybrid
     *
     * @param humanAPIData The human API data
     * @param key The data key
     * @param pluginMsg The plugin msg if any
     * 
     * @return The converted HUMAN API data JSON String
     */
    public String getHumanAPIHybridData(String humanAPIData, String key, String pluginMsg) {
        HashMap<String, String> dataMap = new HashMap<String, String>();

        try {
            dataMap.put("humanAPIData", humanAPIData);
            dataMap.put("key", key);
            dataMap.put("pluginMsg", pluginMsg);

            return new Gson().toJson(dataMap);
        } catch(Exception e) {
            e.printStackTrace();

            return "Data conversion error";
        }
    }
}