@description('Ubicación del despliegue')
param location string

@description('Nombre del Log Analytics Workspace')
param workspaceName string

@description('Retención en días (730 = 2 años)')
param retentionInDays int = 730

@description('SKU del Log Analytics Workspace')
@allowed([
  'PerGB2018'
  'Standard'
])
param skuName string = 'PerGB2018'

@description('Tags corporativos')
param tags object

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  tags: tags
  properties: {
    sku: {
      name: skuName
    }
    retentionInDays: retentionInDays
  }
}

output workspaceId string = logAnalyticsWorkspace.id
output workspaceNameOut string = logAnalyticsWorkspace.name
