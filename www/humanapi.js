var exec = require('cordova/exec');
var pluginName = "HumanAPIPlugin";

/**
 * HumanAPIPlugin Constructor
 */
function HumanAPIPlugin() {}

HumanAPIPlugin.prototype.trigger = function (triggerType, clientID, clientSecret, userID, publicToken, accessToken, success, error) {
    exec(success, error, pluginName, 'trigger', [triggerType, clientID, clientSecret, userID, publicToken, accessToken]);
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
