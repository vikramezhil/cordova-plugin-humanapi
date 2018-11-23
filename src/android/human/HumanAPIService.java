package com.github.vikramezhil.cordova.human;

import android.content.Context;
import android.util.Log;

import org.apache.cordova.CallbackContext;

import org.json.JSONObject;

import com.github.vikramezhil.cordova.service.Service;
import com.github.vikramezhil.cordova.service.Service.ServiceListener;

/**
 * HumanAPI Service
 *
 * @author Vikram Ezhil
 */

public class HumanAPIService {
    private final String TAG = "HumanAPIService";

    private HumanAPIModel humanAPIModel = new HumanAPIModel();
    private Service service;

    private HumanAPIListener humanAPIListener;

    /**
     * Human API Service constructor
     *
     * @param context The application context
     * @param humanAPIListener The class instance to initiate the listener
     */
    public HumanAPIService(Context context, HumanAPIListener humanAPIListener) {
        this.humanAPIListener = humanAPIListener;

        service = new Service(context, new ServiceListener() {
            @Override
            public void onServiceRunning(CallbackContext callbackContext, String passBackKey, Boolean serviceRunning) {
                Log.wtf(TAG, "Service running status for " + passBackKey + " = " + serviceRunning);
            }

            @Override
            public void onServiceResponse(CallbackContext callbackContext, String passBackKey, String serviceResponse) {
                Log.wtf(TAG, "Service response for " + passBackKey + " = " + serviceResponse);

                humanAPIListener.onHumanAPIUpdate(callbackContext, true, humanAPIModel.getHumanAPIHybridData(serviceResponse, passBackKey, "Human API Wellness data got"));
            }

            @Override
            public void onServiceError(CallbackContext callbackContext, String passBackKey, String errorMessage) {
                Log.wtf(TAG, "Service error for " + passBackKey + " = " + errorMessage);

                humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData("", passBackKey, errorMessage));
            }
        });
    }

    /**
     * Executes the human API wellness services based on key
     *
     * @param callbackContext The callback context
     * @param key The human api service key
     * @param accessToken The access token
     */
    public void execute(CallbackContext callbackContext, String key, String accessToken) {
        if(accessToken == null || accessToken.isEmpty()) {
            humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData("", key, "Access token is empty"));
        } else {
            // Getting the data url
            String url = this.humanAPIModel.getDataURL(key);

            if(url == null || url.isEmpty()) {
                humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData("", key, "Unknown data key, unable to generate url"));
            } else {
                // Saving the access token in the human api model
                this.humanAPIModel.setAccessToken(accessToken);

                service.get(callbackContext, key, url, humanAPIModel.getDataHeader());
            }   
        }
    }
}