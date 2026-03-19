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

@description('Tags corporativos (se aplican a LAW y a la Solución de Sentinel)')
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

//
// ✅ Solución “SecurityInsights(<workspace>)” (Microsoft Sentinel legacy solution resource)
//    Aquí es donde quieres ver también las tags.
//
resource sentinelSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${workspaceName})'
  location: location
  tags: tags
  properties: {
    workspaceResourceId: logAnalyticsWorkspace.id
  }
  plan: {
    name: 'SecurityInsights(${workspaceName})'
    product: 'OMSGallery/SecurityInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
}

output workspaceId string = logAnalyticsWorkspace.id
output sentinelSolutionId string = sentinelSolution.id
