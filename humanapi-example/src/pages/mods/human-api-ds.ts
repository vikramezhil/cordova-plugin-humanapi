//**************************************************//
// Humanapi Plugin
//**************************************************//

interface HumanAPITokenData {
    publicToken: string,
    accessToken: string
}

interface HumanAPIAuthData {
    clientID: string,
    clientSecret: string,
    userID: string,
    humanID: string,
    sessionToken: string,
    publicToken: string,
    accessToken: string,
    pluginMsg: string
}

interface HumanAPIWelnessData {
    humanAPIData: any,
    key: string,
    pluginMsg: string
}

//**************************************************//
// Humanapi Wellness Activities
//**************************************************//

interface Activities {
    id: string,
    userId: string,
    startTime: string,
    endTime: string,
    tzOffset: string,
    type: string,
    source: string,
    duration: number,
    distance: number,
    steps: number,
    calories: number,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Activities Summaries
//**************************************************//

interface ActivitiesSummaries {
    id: string,
    userId: string,
    date: string,
    duration: number,
    distance: number,
    steps: number,
    calories: number,
    source: string,
    vigorous: number,
    moderate: number,
    light: number,
    sedentary: number,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Blood Glucose
//**************************************************//

interface BloodGlucose {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Blood Oxygen
//**************************************************//

interface BloodOxygen {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Blood Pressure
//**************************************************//

interface BloodPressure {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    systolic: number,
    diastolic: number,
    unit: number,
    heartRate: number,
    source: string,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Body Mass Index
//**************************************************//

interface BodyMassIndex {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Body Fat
//**************************************************//

interface BodyFat {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Heart Rate
//**************************************************//

interface HeartRate {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: string,
    source: string,
    sourceData: {},
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Heart Rate Summaries
//**************************************************//

interface HeartRateSummaries {
    id: string,
    userId: string,
    date: string,
    zones: HeartRateZones[],
    restingHR: number,
    averageHR: number,
    maxHR: number,
    minHR: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

interface HeartRateZones {
    name: string,
    max: number,
    min: number,
    duration: number,
    caloriesBurned: number
}

//**************************************************//
// Humanapi Wellness Height
//**************************************************//

interface Height {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Weight
//**************************************************//

interface Weight {
    id: string,
    userId: string,
    timestamp: string,
    tzOffset: string,
    value: number,
    unit: number,
    source: string,
    sourceData: any,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Sleeps
//**************************************************//

interface Sleeps {
    id: string,
    userId: string,
    day: string,
    startTime: string,
    endTime: string,
    tzOffset: string,
    source: string,
    mainSleep: boolean,
    timeAsleep: number,
    timeAwake: number,
    efficiency: number,
    timeToFallAsleep: number,
    timeAfterWakeup: number,
    timeInBed: number,
    createdAt: string,
    updatedAt: string,
    humanId: string
}

//**************************************************//
// Humanapi Wellness Sleep Summaries
//**************************************************//

interface SleepSummaries {
    id: string,
    userId: string,
    date: string,
    source: string,
    timeAsleep: number,
    timeAwake: number,
    createdAt: string,
    updatedAt: string,
    humanId: string
}