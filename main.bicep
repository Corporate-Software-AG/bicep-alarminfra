param location string = resourceGroup().location

param iotHubName string = 'iotHub-${uniqueString(resourceGroup().id)}'

param functionAppName string = 'funcName-${uniqueString(resourceGroup().id)}'
param appSrvPlanName string = 'appSrvPlan-${uniqueString(resourceGroup().id)}'

param logAnalyticsName string = 'logAnalytics-${uniqueString(resourceGroup().id)}'
param appInsightsName string = 'appInsights-${uniqueString(resourceGroup().id)}'

param strgAccName string = 'strg${uniqueString(resourceGroup().id)}'

module iothub 'modules/iothub.bicep' = {
  name: '${deployment().name}-iothub'
  params: {
    iotHubName: iotHubName
    location: 'westeurope'
  }
}

module storage 'modules/storage.bicep' = {
  name: '${deployment().name}-storage'
  params: {
    location: location
    strgAccName: strgAccName
  }
}

module monitoring 'modules/monitoring.bicep' = {
  name: '${deployment().name}-monitoring'
  params: {
    appInsightsName: appInsightsName
    location: location
    logAnalyticsName: logAnalyticsName
  }
}

module functionapp 'modules/functionapp.bicep' = {
  name: '${deployment().name}-functionapp'
  params: {
    appSrvPlanName: appSrvPlanName
    functionAppName: functionAppName
    location: location
    strgAccountName: storage.outputs.strgAccountName
    appInsightsName: monitoring.outputs.appInsightsName
  }
}
