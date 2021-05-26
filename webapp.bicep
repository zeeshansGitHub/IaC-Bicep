param appServiceName string = 'AzureDevOpsBicepTest'
param planName string = 'AzureDevOpsBicep'
param location string = 'West Europe'

// Create Windows app service plan into west europe region. Size is F1.
resource appServicePlan 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: planName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 0
  }
  kind: 'app'
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

// Create app service into our app service plan.
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceName
  location: location
  identity: {
    type: 'SystemAssigned' // Default use system assigned ID for app service
  }
  properties: {
    serverFarmId: appServicePlan.id // Use appServicePlan variable that is defined as resource above.
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2' // Allow only TLS 1.2 that is good practice for security
    }
  }
}
