# cordova-plugin-humanapi
Human API Cordova Plugin for Android & IOS

<b><h2>Plugin installation</h2></b>

<b>via npm</b> 

    npm i cordova-plugin-humanapi

<b>via cordova</b>

    cordova plugin add cordova-plugin-humanapi

<b><h2>Documentation</h2></b>

For a detailed documentation 📔, please have a look at the [Wiki](https://github.com/vikramezhil/cordova-plugin-humanapi/wiki).

<b><h2>IOS Prerequisites</h2></b>

* The human API code for IOS is written in <b>swift 4</b> language. In order to use this plugin, your project deployment target should be set to a minimum of <b>11</b>.

* In case your project doesn't have swift support, please add this [plugin](https://github.com/akofman/cordova-plugin-add-swift-support)

* The Xcode Version should be <b>10.0+</b>

* The swift version (found under Build Settings) in Xcode should be set to <b>4</b>

<b><h2>Usage</h2></b>

<b>Cordova, Ionic 1</b>

    window.plugin.humanapi.auth("CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", function(result) {
        alert("Result = " + result)
    }, function(error) {
        alert("Error = " + error)
    })

<b>Ionic 2+</b>

    var humanAPI: any = window
    humanAPI.plugin.humanapi.auth("CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", (result) => {
      alert("Result = " + result)
    }, (error) => {
      alert("Error = " + error)
    })
    
<b><h2>Plugin Data Format</h2></b>

    {
      clientID: "CLIENT_ID",
      clientSecret: "CLIENT_SECRET",
      userID: "USER_ID",
      humanID: "HUMAN_ID",
      sessionToken: "SESSION_TOKEN",
      publicToken: "PUBLIC_TOKEN",
      accessToken: "ACCESS_TOKEN", 
      pluginMsg: "The plugin message if any"
    }

