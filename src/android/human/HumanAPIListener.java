package com.github.vikramezhil.cordova.human;

import org.apache.cordova.CallbackContext;

public interface HumanAPIListener {
    /**
     * Sends an update with the human API data
     * 
     * @param callbackContext The callback context
     * @param success The success status
     * @param humanAPIData The human API response data
     */
    void onHumanAPIUpdate(CallbackContext callbackContext, Boolean success, String humanAPIData);
}