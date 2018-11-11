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

* The swift version in Xcode should be set to <b>4</b>

<p align="center">
<img src="https://user-images.githubusercontent.com/12429051/48312323-f4567600-e5d2-11e8-8e26-b7a332e062b9.png" height="300" width="500"/>
</p>

<b><h2>Usage</h2></b>

<b>Cordova, Ionic 1</b>

    window.plugin.humanapi.trigger("init", "CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", function(result) {
        alert("Result = " + JSON.stringify(result))
    }, function(error) {
        alert("Error = " + JSON.stringify(error))
    })

<b>Ionic 2+</b>

    var humanAPI: any = window
    humanAPI.plugin.humanapi.trigger("init", "CLIENT_ID", "CLIENT_SECRET", "USER_ID", "PUBLIC_TOKEN", "ACCESS_TOKEN", (result) => {
      alert("Result = " + JSON.stringify(result))
    }, (error) => {
      alert("Error = " + JSON.stringify(error))
    })
    
<b><h2>Plugin Data Format</h2></b>

    {
      clientID: "CLIENT_ID",
      clientSecret: "CLIENT_SECRET",
      userID: "USER_ID",
      humanID: "HUMAN_ID",
      sessionToken: "SESSION_TOKEN",
      publicToken: "PUBLIC_TOKEN",
      accessToken: "ACCESS_TOKEN"
      humanAPIData: "REFER BELOW", 
      pluginMsg: "The plugin message if any"
    }
    
<b>humanAPIData</b> example data, more information can be found [here](https://reference.humanapi.co/v2.1/docs/data-overview)

    {
        "userId": "52e20cb2fff56aac62000001",
        "createdAt": "2014-01-24T06:48:18.361Z",
        "bloodGlucose": {
            "id": "52e20cb3fff56aac6200044a",
            "timestamp": "2014-01-23T22:48:19.858Z",
            "source": "glooko",
            "value": 90,
            "unit": "mg/dL"
        },
        "bloodOxygen": {
            "id": "54d1f018810a5ba429951b07",
            "timestamp": "2015-01-26T06:58:37.000Z",
            "source": "withings",
            "value": 99,
            "unit": "SpO2"
        },
        "bloodPressure": {
            "id": "550b8a8e834dd16f259683b1",
            "userId": "52e20cb2fff56aac62000001",
            "timestamp": "2015-03-19T22:48:26.000Z",
            "source": "ihealth",
            "systolic": 117,
            "diastolic": 76,
            "unit": "mmHg",
            "heartRate": 66
        },
        "bmi": {
            "id": "5702fed82add5c0900a6f95a",
            "timestamp": "2016-04-05T06:59:59.000Z",
            "source": "fitbit",
            "value": 23.98,
            "unit": "kg/m2"
        },
        "bodyFat": {
            "id": "562b08ef74a7be0700a0f88d",
            "timestamp": "2015-10-24T03:30:34.000Z",
            "source": "fitbit",
            "value": 21.4,
            "unit": "%"
        },
        "height": {
            "id": "57b531d4856bfe0a00d4cb25",
            "timestamp": "2016-08-18T03:56:04.156Z",
            "source": "fitbit",
            "value": 1730,
            "unit": "mm"
        },
        "heartRate": {
            "id": "550b8a8e834dd16f259683b2",
            "timestamp": "2015-03-19T22:48:26.000Z",
            "source": "ihealth",
            "value": 66,
            "unit": "bpm"
        },
        "weight": {
            "id": "5702fed8dfb2210c00af7405",
            "timestamp": "2016-04-05T06:59:59.000Z",
            "source": "fitbit",
            "value": 71.7,
            "unit": "kg"
        },
        "activitySummary": {
            "id": "5812b6e19e554b0800d8a1f6",
            "date": "2016-10-28",
            "duration": 0,
            "distance": 0,
            "sedentary": 954,
            "light": 0,
            "moderate": 0,
            "vigorous": 0,
            "total": 954,
            "steps": 0,
            "calories": 1113,
            "source": "fitbit"
        },
        "sleepSummary": {
            "id": "540e96b74247c3ea71d671b9",
            "userId": "52e20cb2fff56aac62000001",
            "date": "2014-09-09",
            "source": "fitbit",
            "timeAsleep": 456,
            "timeAwake": 0,
            "updatedAt": "2014-09-11T02:28:27.377Z"
        },
        "humanId": "5dc2527186aaf9de560e5841f1a44bd6"
    }
