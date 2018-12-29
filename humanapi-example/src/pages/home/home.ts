import { Component, NgZone } from '@angular/core';
import { NavController } from 'ionic-angular';
import { HumanapiWellnessDataKeys, HumanAPIKeys } from '../mods/human-api-properties';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})

export class HomePage {
  private static TAG = "HomePage"

  wellness: string = "activities"
  wellnessScreenData: string[] = []

  constructor(public navCtrl: NavController, public ngZone: NgZone) {
    if(localStorage.userTokens != null) {
      console.log(HomePage.TAG, "Tokens = " + JSON.stringify(localStorage.userTokens))
    }
  }

  /**
   * Triggers the human api authentication
   */
  triggerHumanAPIAuthentication() {
    var userTokens: HumanAPITokenData = {publicToken: "", accessToken: ""}
    if(localStorage.userTokens != null) {
      // Getting the user tokens if found in local storage
      userTokens = JSON.parse(localStorage.userTokens)
    }

    var human: any = window
    human.plugin.humanapi.auth(HumanAPIKeys.CLIENT_ID, HumanAPIKeys.CLIENT_SECRET, HumanAPIKeys.USER_ID, userTokens.publicToken, userTokens.accessToken, (result) => {
      let authResult: HumanAPIAuthData = JSON.parse(result)
      userTokens.accessToken = authResult.accessToken
      userTokens.publicToken = authResult.publicToken

      // Saving the new user tokens in the local storage
      localStorage.userTokens = JSON.stringify(userTokens)

      alert(authResult.pluginMsg)
    }, (error) => {
      let authErrorResult: HumanAPIAuthData = JSON.parse(error)

      alert(authErrorResult.pluginMsg)
    })
  }

  /**
   * Gets the welness data
   */
  getWellnessData() {
    this.wellnessScreenData = []

    var userTokens: HumanAPITokenData = {publicToken: "", accessToken: ""}
    if(localStorage.userTokens != null) {
      // Getting the user tokens if found in local storage
      userTokens = JSON.parse(localStorage.userTokens)
    }

    if(userTokens == null || userTokens.accessToken == null || userTokens.accessToken.length == 0) {
      alert("Please connect at least one your wearable accounts with humanapi")
    } else {
      var human: any = window
      human.plugin.humanapi.execute(this.wellness, userTokens.accessToken, (result) => {
        let welnessData: HumanAPIWelnessData = JSON.parse(result)
        this.ngZone.run(()=> {
          switch(this.wellness) {
            case HumanapiWellnessDataKeys.activities:
              let activities: Activities[] = JSON.parse(welnessData.humanAPIData)
              for(let activity of activities) {
                let data: string = "Type = " + this.wellness + ", Source = " + activity.source + ", Calories = " + activity.calories + ", Duration = " + activity.duration + ", Distance = " + activity.distance + ", Steps = " + activity.steps
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.activitiesSummaries:
              let activitiesSummaries: ActivitiesSummaries[] = JSON.parse(welnessData.humanAPIData)
              for(let activity of activitiesSummaries) {
                let data: string = "Type = " + this.wellness + ", Source = " + activity.source + ", Calories = " + activity.calories + ", Duration = " + activity.duration + ", Distance = " + activity.distance + ", Steps = " + activity.steps + ", Vigorous = " + activity.vigorous + ", Moderate = " + activity.moderate
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bloodGlucose:
              let bloodGlucose: BloodGlucose[] = JSON.parse(welnessData.humanAPIData)
              for(let bg of bloodGlucose) {
                let data: string = "Type = " + this.wellness + ", Source = " + bg.source + ", Blood Glucose = " + bg.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bloodOxygen:
              let bloodOxygen: BloodOxygen[] = JSON.parse(welnessData.humanAPIData)
              for(let bo of bloodOxygen) {
                let data: string = "Type = " + this.wellness + ", Source = " + bo.source + ", Blood Oxygen = " + bo.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bloodPressure:
              let bloodPressure: BloodPressure[] = JSON.parse(welnessData.humanAPIData)
              for(let bp of bloodPressure) {
                let data: string = "Type = " + this.wellness + ", Source = " + bp.source + ", Systolic = " + bp.systolic + ", Diastolic = " + bp.diastolic
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bodyMassIndex:
              let bodyMassIndex: BodyMassIndex[] = JSON.parse(welnessData.humanAPIData)
              for(let bmi of bodyMassIndex) {
                let data: string = "Type = " + this.wellness + ", Source = " + bmi.source + ", BMI = " + bmi.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bodyFat:
              let bodyFat: BodyFat[] = JSON.parse(welnessData.humanAPIData)
              for(let bf of bodyFat) {
                let data: string = "Type = " + this.wellness + ", Source = " + bf.source + ", Body Fat= " + bf.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.heartRate:
              let heartRate: HeartRate[] = JSON.parse(welnessData.humanAPIData)
              for(let hr of heartRate) {
                let data: string = "Type = " + this.wellness + ", Source = " + hr.source + ", Heart Rate = " + hr.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.heartRateSummaries:
              let hrSummaries: HeartRateSummaries[] = JSON.parse(welnessData.humanAPIData)
              for(let hr of hrSummaries) {
                let data: string = "Type = " + this.wellness + ", Source = " + hr.source + ", Resting Heart Rate = " + hr.restingHR
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.height:
              let height: Height[] = JSON.parse(welnessData.humanAPIData)
              for(let hgt of height) {
                let data: string = "Type = " + this.wellness + ", Source = " + hgt.source + ", Height = " + hgt.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.weight:
              let weight: Weight[] = JSON.parse(welnessData.humanAPIData)
              for(let wgt of weight) {
                let data: string = "Type = " + this.wellness + ", Source = " + wgt.source + ", Weight = " + wgt.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.sleeps:
              let sleeps: Sleeps[] = JSON.parse(welnessData.humanAPIData)
              for(let sleep of sleeps) {
                let data: string = "Type = " + this.wellness + ", Source = " + sleep.source + ", Time Asleep = " + sleep.timeAsleep + ", Time Awake = " + sleep.timeAwake + ", Efficiency = " + sleep.efficiency + ", Time To Fall Asleep = " + sleep.timeToFallAsleep + ", Time After Wakeup = " + sleep.timeAfterWakeup + ", Time In Bed = " + sleep.timeInBed
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.sleepSummaries:
              let sleepSummaries: SleepSummaries[] = JSON.parse(welnessData.humanAPIData)
              for(let sleep of sleepSummaries) {
                let data: string = "Type = " + this.wellness + ", Source = " + sleep.source + ", Time Asleep = " + sleep.timeAsleep + ", Time Awake = " + sleep.timeAwake
                this.wellnessScreenData.push(data)
              }
  
              break
          }

          if(this.wellnessScreenData.length == 0) {
            alert("No data found for " + this.wellness)
          }
        });
      }, (error) => {
        let welnessDataError: HumanAPIWelnessData = JSON.parse(error)

        alert(welnessDataError.pluginMsg)
      })
    }
  }

  /**
   * Resets the humanapi tokens in local storage
   */
  resetHumanAPITokens() {
    delete localStorage.userTokens

    alert("humanapi tokens reset success in your phone local storage, please make sure to reset it in portal")
  }
}
