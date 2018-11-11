package com.github.vikramezhil.cordova;

import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;
import android.content.Intent;

import com.github.vikramezhil.cordova.human.HumanAPIActivity;
import com.github.vikramezhil.cordova.human.HumanAPIActivity.HumanAPIListener;

/**
 * HumanAPIPlugin Android Controller Class
 * 
 * @author Vikram Ezhil
 */

public class HumanAPIPlugin extends CordovaPlugin implements HumanAPIListener {
    String TAG = "HumanAPIPlugin";

    public static HumanAPIPlugin context;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        context = this;
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    //*************************************************************************************

    // Active8mePlugins

    //*************************************************************************************

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Log.wtf(TAG, "Native Action = " + action);

        if (action.equals("trigger")) {
            this.trigger(callbackContext, args.getString(0), args.getString(1), args.getString(2), args.getString(3), args.getString(4), args.getString(5));

            return true;
        }

        return false;
    }

    //*************************************************************************************

    // HUMAN API

    //*************************************************************************************

    private CallbackContext humanAPICallbackContext;

    /**
     * Triggers Human API 
     * 
     * @param callbackContext The callback context
     * @param triggerType The human API trigger type
     * @param clientID The human API client ID
     * @param clientSecret The human API client secret
     * @param userID The human API user ID
     * @param publicToken The human API public token
     * @param accessToken The human API access token
     */
    private void trigger(CallbackContext callbackContext, String triggerType, String clientID, String clientSecret, String userID, String publicToken, String accessToken) {
        final CordovaInterface cordova = this.cordova;

        // Saving a reference of the human API callback context
        humanAPICallbackContext = callbackContext;

        Runnable runnable = new Runnable() {
            @Override
            public void run() { 
                Intent humanAPIIntent = new Intent(cordova.getActivity().getApplicationContext(), HumanAPIActivity.class);
                humanAPIIntent.putExtra("clientID", clientID);
                humanAPIIntent.putExtra("clientSecret", clientSecret);
                humanAPIIntent.putExtra("userID", userID);
                humanAPIIntent.putExtra("publicToken", publicToken);
                humanAPIIntent.putExtra("accessToken", accessToken);

                cordova.getActivity().startActivity(humanAPIIntent);
            }
        };

        cordova.getActivity().runOnUiThread(runnable);
    }

    // MARK: HumanAPIListener Methods

    @Override
    public void onHumanAPIUpdate(Boolean success, String humanAPIData) {
        if(humanAPICallbackContext != null) {
            PluginResult result = new PluginResult(success ?  PluginResult.Status.OK : PluginResult.Status.ERROR, humanAPIData);
            result.setKeepCallback(true);
            humanAPICallbackContext.sendPluginResult(result); 
        }
    }
}
