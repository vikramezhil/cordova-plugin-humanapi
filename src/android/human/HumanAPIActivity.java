package com.github.vikramezhil.cordova.human;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.content.res.Resources;

import org.json.JSONObject;

import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;

import com.github.vikramezhil.cordova.HumanAPIPlugin;
import com.github.vikramezhil.cordova.service.Service;
import com.github.vikramezhil.cordova.service.Service.ServiceListener;

/**
 * Human API Web Auth Activity
 *
 * @author Vikram Ezhil
 */

public class HumanAPIActivity extends Activity {
    private final String TAG = "HumanAPIActivity";

    private WebView wvHumanAPI;

    private HumanAPIModel humanAPIModel = new HumanAPIModel();
    private Service service;

    private HumanAPIListener humanAPIListener;

    public interface HumanAPIListener {
        /**
         * Sends an update with the human API data
         * 
         * @param success The success status
         * @param humanAPIData The human API response data
         */
        void onHumanAPIUpdate(Boolean success, String humanAPIData);
    }

    @SuppressLint("SetJavaScriptEnabled")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if(getActionBar() != null) {
            getActionBar().hide();
        }

        // Initializing the human API listener
        humanAPIListener = (HumanAPIListener) HumanAPIPlugin.context;
        
        String packageName = getApplication().getPackageName();
        Resources resources = getApplication().getResources();

        // Setting the layout
        setContentView(resources.getIdentifier("activity_human", "layout", packageName));

        if(getIntent() != null) {
            humanAPIModel.setClientId(getIntent().hasExtra("clientID") ? getIntent().getStringExtra("clientID") : null);
            humanAPIModel.setClientSecret(getIntent().hasExtra("clientSecret") ? getIntent().getStringExtra("clientSecret") : null);
            humanAPIModel.setUserId(getIntent().hasExtra("userID") ? getIntent().getStringExtra("userID") : null);
            humanAPIModel.setPublicToken(getIntent().hasExtra("publicToken") ? getIntent().getStringExtra("publicToken") : null);
            humanAPIModel.setAccessToken(getIntent().hasExtra("accessToken") ? getIntent().getStringExtra("accessToken") : null);
        }

        service = new Service(this, new ServiceListener() {
            @Override
            public void onServiceRunning(String passBackKey, Boolean serviceRunning) {
                Log.wtf(TAG, "Service running status for " + passBackKey + " = " + serviceRunning);
            }

            @Override
            public void onServiceResponse(String passBackKey, JSONObject serviceResponse) {
                if(passBackKey.equals(HumanAPIModel.humanAPITokenPassBackKey)) {
                    // Setting the tokens in the model data
                    humanAPIModel.setTokens(serviceResponse);

                    Log.wtf(TAG, "clientID = " + humanAPIModel.getClientId());
                    Log.wtf(TAG, "clientSecret = " + humanAPIModel.getClientSecret());
                    Log.wtf(TAG, "userID = " +  humanAPIModel.getUserId());
                    Log.wtf(TAG, "humanID = " + humanAPIModel.getHumanId());
                    Log.wtf(TAG, "sessionToken = " + humanAPIModel.getSessionToken());
                    Log.wtf(TAG, "publicToken = " + humanAPIModel.getPublicToken());
                    Log.wtf(TAG, "accessToken = " + humanAPIModel.getAccessToken());
                    
                    if(humanAPIModel.getAccessToken() == null) {
                        humanAPIListener.onHumanAPIUpdate(false, humanAPIModel.getHumanAPIHybridData("Access token is null, unable to proceed"));

                        finish();
                    } else {
                        // Getting the user human connected health data
                        service.get(HumanAPIModel.humanAPIDataPassBackKey, humanAPIModel.getDataURL(), humanAPIModel.getDataHeader());
                    }
                } else if(passBackKey.equals(HumanAPIModel.humanAPIDataPassBackKey)) {
                    // Setting the human data in the model
                    humanAPIModel.setHumanData(serviceResponse);

                    // Sending back the human API data update
                    humanAPIListener.onHumanAPIUpdate(true, humanAPIModel.getHumanAPIHybridData("Human API data got"));

                    finish();
                }
            }

            @Override
            public void onServiceError(String passBackKey, String errorMessage) {
                Log.wtf(TAG, "Service error for " + passBackKey + " = " + errorMessage);

                humanAPIListener.onHumanAPIUpdate(false, humanAPIModel.getHumanAPIHybridData(errorMessage));

                finish();
            }
        });

        int wvHumanAPIID = resources.getIdentifier("wvHumanAPI", "id", packageName);
        wvHumanAPI = findViewById(wvHumanAPIID);
        wvHumanAPI.getSettings().setJavaScriptEnabled(true);
        wvHumanAPI.getSettings().setLoadWithOverviewMode(true);
        wvHumanAPI.getSettings().setUseWideViewPort(true);
        wvHumanAPI.setWebChromeClient(new WebChromeClient());
        wvHumanAPI.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                if(request.getUrl().toString().startsWith(humanAPIModel.getFinishURL())) {
                    // Setting the human API response in the model
                    humanAPIModel.setHumanAPIResponse(request.getUrl().toString());

                    // Getting the human API public token for the user
                    service.post(HumanAPIModel.humanAPITokenPassBackKey, humanAPIModel.getTokenURL(), null, humanAPIModel.getTokenRequestBody());

                    return true;
                } else if(request.getUrl().toString().startsWith(humanAPIModel.getCloseURL())) {
                    humanAPIListener.onHumanAPIUpdate(true, humanAPIModel.getHumanAPIHybridData("Human API page closed by user"));

                    finish();
                    
                    return true;
                }

                return false;
            }

            @Override
            public void onLoadResource(WebView view, String url) {
                super.onLoadResource(view, url);
            }
        });

        String url = humanAPIModel.getLoadURL();
        if(url != null) {
            wvHumanAPI.loadUrl(url);
        } else {
            finish();
        }
    }

    @Override
    public void onBackPressed() {
        if(wvHumanAPI.canGoBack()) {
            wvHumanAPI.goBack();
        } else {
            super.onBackPressed();
        }
    }
}
