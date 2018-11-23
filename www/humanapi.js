var exec = require('cordova/exec');
var pluginName = "HumanAPIPlugin";

/**
 * HumanAPIPlugin Constructor
 */
function HumanAPIPlugin() {}

HumanAPIPlugin.prototype.auth = function (clientID, clientSecret, userID, publicToken, accessToken, success, error) {
    exec(success, error, pluginName, 'auth', [clientID, clientSecret, userID, publicToken, accessToken]);
};

HumanAPIPlugin.prototype.execute = function (type, accessToken, success, error) {
    exec(success, error, pluginName, 'execute', [type, accessToken]);
};

// Installation constructor that binds HumanAPIPlugin to window
HumanAPIPlugin.install = function() {
    if(!window.plugin) {
      window.plugin = {};
    }

    window.plugin.humanapi = new HumanAPIPlugin();

    return window.plugin.humanapi;
};

cordova.addConstructor(HumanAPIPlugin.install);
