import { Component, NgZone } from '@angular/core';
import { NavController } from 'ionic-angular';
import { HumanapiWellnessDataKeys, HumanAPIKeys } from '../mods/human-api-properties';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})

/**
 * HomePage
 *
 * @author Vikram Ezhil
 */

export class HomePage {
  private static TAG = "HomePage"

  wellnessData: string[] = []

  wellness: string = "activities"
  wellnessScreenData: string[] = []

  constructor(public navCtrl: NavController, public ngZone: NgZone) {
    if(localStorage.userTokens != null) {
      console.log(HomePage.TAG, "Tokens = " + JSON.stringify(localStorage.userTokens))
    }

    for(let key of Object.keys(HumanapiWellnessDataKeys)) {
      this.wellnessData.push(key)
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
    // Resetting the wellness screen data
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
  
            case HumanapiWellnessDataKeys.bloodGlucoseLatest:
            case HumanapiWellnessDataKeys.bloodGlucose:
              let bloodGlucose: BloodGlucose[] = []
              if(this.wellness == HumanapiWellnessDataKeys.bloodGlucoseLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  bloodGlucose = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                bloodGlucose = JSON.parse(welnessData.humanAPIData)
              }

              for(let bg of bloodGlucose) {
                let data: string = "Type = " + this.wellness + ", Source = " + bg.source + ", Blood Glucose = " + bg.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bloodOxygenLatest:
            case HumanapiWellnessDataKeys.bloodOxygen:
              var bloodOxygen: BloodOxygen[] = []
              if(this.wellness == HumanapiWellnessDataKeys.bloodOxygenLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  bloodOxygen = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                bloodOxygen = JSON.parse(welnessData.humanAPIData)
              }

              for(let bo of bloodOxygen) {
                let data: string = "Type = " + this.wellness + ", Source = " + bo.source + ", Blood Oxygen = " + bo.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bloodPressureLatest:
            case HumanapiWellnessDataKeys.bloodPressure:
              var bloodPressure: BloodPressure[] = []
              if(this.wellness == HumanapiWellnessDataKeys.bloodPressureLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  bloodPressure = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                bloodPressure = JSON.parse(welnessData.humanAPIData)
              }

              for(let bp of bloodPressure) {
                let data: string = "Type = " + this.wellness + ", Source = " + bp.source + ", Systolic = " + bp.systolic + ", Diastolic = " + bp.diastolic
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bodyMassIndexLatest:
            case HumanapiWellnessDataKeys.bodyMassIndex:
              var bodyMassIndex: BodyMassIndex[] = []
              if(this.wellness == HumanapiWellnessDataKeys.bodyMassIndexLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  bodyMassIndex = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                bodyMassIndex = JSON.parse(welnessData.humanAPIData)
              }

              for(let bmi of bodyMassIndex) {
                let data: string = "Type = " + this.wellness + ", Source = " + bmi.source + ", BMI = " + bmi.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.bodyFatLatest:
            case HumanapiWellnessDataKeys.bodyFat:
              var bodyFat: BodyFat[] = []
              if(this.wellness == HumanapiWellnessDataKeys.bodyFatLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  bodyFat = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                bodyFat = JSON.parse(welnessData.humanAPIData)
              }

              for(let bf of bodyFat) {
                let data: string = "Type = " + this.wellness + ", Source = " + bf.source + ", Body Fat= " + bf.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.heartRateLatest:
            case HumanapiWellnessDataKeys.heartRate:
              var heartRate: HeartRate[] = []
              if(this.wellness == HumanapiWellnessDataKeys.heartRateLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  heartRate = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                heartRate = JSON.parse(welnessData.humanAPIData)
              }
              
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
  
            case HumanapiWellnessDataKeys.heightLatest:
            case HumanapiWellnessDataKeys.height:
              var height: Height[] = []
              if(this.wellness == HumanapiWellnessDataKeys.heightLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  height = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                height = JSON.parse(welnessData.humanAPIData)
              }

              for(let hgt of height) {
                let data: string = "Type = " + this.wellness + ", Source = " + hgt.source + ", Height = " + hgt.value
                this.wellnessScreenData.push(data)
              }
  
              break
  
            case HumanapiWellnessDataKeys.weightLatest:
            case HumanapiWellnessDataKeys.weight:
              let weight: Weight[] = []
              if(this.wellness == HumanapiWellnessDataKeys.weightLatest) {
                if(JSON.parse(welnessData.humanAPIData) != {}) {
                  weight = [JSON.parse(welnessData.humanAPIData)]
                }
              } else {
                weight = JSON.parse(welnessData.humanAPIData)
              }

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
