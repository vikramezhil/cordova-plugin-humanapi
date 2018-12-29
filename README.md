# cordova-plugin-humanapi
humanapi cordova plugin for android & ios

<b><h2>Plugin installation</h2></b>

<b>via npm</b> 

    npm i cordova-plugin-humanapi

<b>via cordova</b>

    cordova plugin add cordova-plugin-humanapi

<b>via ionic</b>

    ionic cordova plugin add cordova-plugin-humanapi

<b><h2>Documentation</h2></b>

For a detailed documentation 📔, please have a look at the [Wiki](https://github.com/vikramezhil/cordova-plugin-humanapi/wiki).

<b><h2>IOS Prerequisites</h2></b>

* The human API code for IOS is written in <b>swift 4</b> language. In order to use this plugin, your project deployment target should be set to a minimum of <b>11</b>.

* In case your project doesn't have swift support, please add this [plugin](https://github.com/akofman/cordova-plugin-add-swift-support)

* The Xcode Version should be <b>10.0+</b>

* The swift version (found under Build Settings) in Xcode should be set to <b>4</b>

<b><h2>Usage</h2></b>

<b><h3>Cordova, Ionic 1</h3></b>

<b>Authentication</b>

    window.plugin.humanapi.auth("CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", function(result) {
        alert("Result = " + result)
    }, function(error) {
        alert("Error = " + error)
    })

<b>Wellness Data</b>

    window.plugin.humanapi.execute("WELLNESS_NAME", "ACCESS_TOKEN", function(result) {
        alert("Result = " + result)
    }, function(error) {
        alert("Error = " + error)
    })

<b>Source Data</b>

    window.plugin.humanapi.execute("sources", "ACCESS_TOKEN", function(result) {
        alert("Result = " + result)
    }, function(error) {
        alert("Error = " + error)
    })

<b><h3>Ionic 2+</h3></b>

<b>Authentication</b>

    var human: any = window
    human.plugin.humanapi.auth("CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", (result) => {
      alert("Result = " + result)
    }, (error) => {
      alert("Error = " + error)
    })

<b>Wellness Data</b>

    var human: any = window
    human.plugin.humanapi.execute("WELLNESS_NAME", "ACCESS_TOKEN", (result) => {
      alert("Result = " + result)
    }, (error) => {
      alert("Error = " + error)
    })
    
<b>Source Data</b>

    var human: any = window
    human.plugin.humanapi.execute("sources", "ACCESS_TOKEN", (result) => {
      alert("Result = " + result)
    }, (error) => {
      alert("Error = " + error)
    })

<b><h3>Authentication Data Format</h3></b>

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

<b><h3>Wellness Supported API's & Data Format</h3></b>

Currently the plugin supports 17 wellness API's (excluding Genetic Traits & Genotypes). Please refer for the list of wellness API's and data formats [here](https://reference.humanapi.co/v2.1/reference#wellness-api-introduction)

For plugin examples, please refer [here](https://github.com/vikramezhil/cordova-plugin-humanapi/wiki/6.-API-calls)
