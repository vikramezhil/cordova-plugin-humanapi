package com.github.vikramezhil.cordova.service;

import android.content.Context;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.ServerError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.apache.cordova.CallbackContext;

import org.json.JSONObject;

import java.util.Map;

/**
 * Service class
 *
 * @author Vikram Ezhil
 */

public class Service {
    private final String TAG = "Service";

    private Context context;
    private ServiceListener serviceListener;

    public interface ServiceListener {
        /**
         * Updates with the service running status
         *
         * @param callbackContext The callback context
         * @param passBackKey The pass back key
         * @param serviceRunning The service running status
         */
        void onServiceRunning(CallbackContext callbackContext, String passBackKey, Boolean serviceRunning);

        /**
         * Updates with the service response
         *
         * @param callbackContext The callback context
         * @param passBackKey The pass back key
         * @param serviceResponse The service response
         */
        void onServiceResponse(CallbackContext callbackContext, String passBackKey, String serviceResponse);

        /**
         * Updates with the service error
         *
         * @param callbackContext The callback context
         * @param passBackKey The pass back key
         * @param errorMessage The error message
         */
        void onServiceError(CallbackContext callbackContext, String passBackKey, String errorMessage);
    }

    /**
     * Service constructor
     *
     * @param context The application context
     * @param serviceListener The class instance which implements the service listener
     */
    public Service(Context context, ServiceListener serviceListener) {
        this.context = context;
        this.serviceListener = serviceListener;
    }

    /**
     * Sends a POST request
     *
     * @param callbackContext The callback context
     * @param passBackKey The pass back key
     * @param requestLink The request link
     * @param customHeaders The custom headers if any
     * @param requestBody The request body
     *
     * Listener Interface => ServiceListener
     */
    public void post(final CallbackContext callbackContext, final String passBackKey, final String requestLink, final Map<String, String> customHeaders, final JSONObject requestBody) {
        try {
            Log.wtf(TAG, "Request type = POST");
            Log.wtf(TAG, "Pass back key = " + passBackKey);
            Log.wtf(TAG, "Request link = " + requestLink);
            Log.wtf(TAG, "Request params = " + requestBody.toString());
            if(customHeaders != null) {
                Log.wtf(TAG, "Custom headers = " + customHeaders.toString());
            }

            serviceListener.onServiceRunning(callbackContext, passBackKey, true);

            RequestQueue requestQueue = Volley.newRequestQueue(context);
            StringRequest request = new StringRequest(Request.Method.POST, requestLink, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Log.wtf(TAG, "Response = " + response);

                    serviceListener.onServiceRunning(callbackContext, passBackKey, false);

                    serviceListener.onServiceResponse(callbackContext, passBackKey, response);
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    serviceListener.onServiceRunning(callbackContext, passBackKey, false);

                    NetworkResponse response = error.networkResponse;
                    if (error instanceof ServerError && response != null) {
                        try {
                            String res = new String(response.data, HttpHeaderParser.parseCharset(response.headers, "utf-8"));

                            serviceListener.onServiceError(callbackContext, passBackKey, res);

                            return;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                    serviceListener.onServiceError(callbackContext, passBackKey, error.getLocalizedMessage());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public Map<String, String> getHeaders() throws AuthFailureError {
                    if(customHeaders != null) {
                        return customHeaders;
                    }

                    return super.getHeaders();
                }

                @Override
                public byte[] getBody() throws AuthFailureError {
                    try {
                        return requestBody.toString().getBytes("utf-8");
                    } catch (Exception e) {
                        e.printStackTrace();

                        Log.wtf(TAG, "Unsupported Encoding while trying to get the bytes of = " + requestBody.toString());

                        return null;
                    }
                }

                @Override
                protected Response<String> parseNetworkResponse(NetworkResponse response) {
                    return super.parseNetworkResponse(response);
                }
            };

            requestQueue.add(request);
        } catch (Exception e) {
            e.printStackTrace();

            serviceListener.onServiceRunning(callbackContext, passBackKey, false);
        }
    }

    /**
     * Sends a GET request
     *
     * @param callbackContext The callback context
     * @param passBackKey The pass back key
     * @param requestLink The request link
     * @param customHeaders The custom headers if any
     *
     * Listener Interface => ServiceListener
     */
    public void get(final CallbackContext callbackContext, final String passBackKey, final String requestLink, final Map<String, String> customHeaders) {
        try {
            Log.wtf(TAG, "Request type = GET");
            Log.wtf(TAG, "Pass back key = " + passBackKey);
            Log.wtf(TAG, "Request link = " + requestLink);
            if(customHeaders != null) {
                Log.wtf(TAG, "Custom headers = " + customHeaders.toString());
            }

            serviceListener.onServiceRunning(callbackContext, passBackKey, true);

            RequestQueue requestQueue = Volley.newRequestQueue(context);
            StringRequest request = new StringRequest(Request.Method.GET, requestLink, new Response.Listener<String>() {
                @Override
                public void onResponse(String response) {
                    Log.wtf(TAG, "Response = " + response);

                    serviceListener.onServiceRunning(callbackContext, passBackKey, false);

                    serviceListener.onServiceResponse(callbackContext, passBackKey, response);
                }
            }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    serviceListener.onServiceRunning(callbackContext, passBackKey, false);

                    NetworkResponse response = error.networkResponse;
                    if (error instanceof ServerError && response != null) {
                        try {
                            String res = new String(response.data, HttpHeaderParser.parseCharset(response.headers, "utf-8"));

                            serviceListener.onServiceError(callbackContext, passBackKey, res);

                            return;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                    serviceListener.onServiceError(callbackContext, passBackKey, error.getLocalizedMessage());
                }
            }) {
                @Override
                public String getBodyContentType() {
                    return "application/json; charset=utf-8";
                }

                @Override
                public Map<String, String> getHeaders() throws AuthFailureError {
                    if(customHeaders != null) {
                        return customHeaders;
                    }

                    return super.getHeaders();
                }

                @Override
                protected Response<String> parseNetworkResponse(NetworkResponse response) {
                    return super.parseNetworkResponse(response);
                }
            };

            requestQueue.add(request);
        } catch (Exception e) {
            e.printStackTrace();

            serviceListener.onServiceRunning(callbackContext, passBackKey, false);
        }
    }
}
