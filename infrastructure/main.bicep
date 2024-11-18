@allowed(['dev', 'prod'])
param environment string

var location = 'centralus' 

var myName = 'esskegar'

targetScope = 'resourceGroup'

module appService 'appService.bicep' = {
  name: 'appService'
  params: {
    appName: 'workshop-dnazghbicep-${myName}-${environment}'
    location: location
    environment: environment
  }
}

module keyvault './keyvault.bicep' = {
  name: 'keyvault'
  params: {
    appId: appService.outputs.appServiceInfo.appId
    slotId: appService.outputs.appServiceInfo.slotId
    location: location
    appName: '${myName}-${environment}' // key vault has 24 char max so just doing your name, usually would do appname-env but that'll conflict for everyone
  }
}
