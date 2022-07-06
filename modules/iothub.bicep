param iotHubName string
param location string

resource iothub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: iotHubName
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}
