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
            public void onServiceResponse(CallbackContext callbackContext, String passBackKey, JSONObject serviceResponse) {
                humanAPIListener.onHumanAPIUpdate(callbackContext, true, humanAPIModel.getHumanAPIHybridData(serviceResponse, passBackKey, "Data got"));
            }

            @Override
            public void onServiceError(CallbackContext callbackContext, String passBackKey, String errorMessage) {
                Log.wtf(TAG, "Service error for " + passBackKey + " = " + errorMessage);

                humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData(null, passBackKey, errorMessage));
            }
        });
    }

    /**
     * Starts the human api service
     *
     * @param callbackContext The callback context
     * @param key The human api service key
     * @param accessToken The access token
     */
    public void start(CallbackContext callbackContext, String key, String accessToken) {
        if(accessToken == null || accessToken.isEmpty()) {
            humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData(null, key, "Invalid access token"));
        } else {
            // Getting the data url
            String url = this.humanAPIModel.getDataURL(key);

            if(url == null || url.isEmpty()) {
                humanAPIListener.onHumanAPIUpdate(callbackContext, false, humanAPIModel.getHumanAPIHybridData(null, key, "Unknown data key, unable to generate url"));
            } else {
                // Saving the access token in the human api model
                this.humanAPIModel.setAccessToken(accessToken);

                service.get(callbackContext, key, url, humanAPIModel.getDataHeader());
            }   
        }
    }
}