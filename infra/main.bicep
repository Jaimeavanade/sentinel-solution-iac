@description('Ubicación de despliegue (ej: westeurope)')
param location string

@description('Nombre del Log Analytics Workspace')
param workspaceName string

@description('Retención en días para Log Analytics (máx 730 = 2 años)')
param retentionInDays int = 730

@description('Tags corporativos a aplicar al Log Analytics Workspace')
param tags object

@description('SKU del Log Analytics Workspace')
@allowed([
  'PerGB2018'
  'Standard'
])
param skuName string = 'PerGB2018'

@description('Límite de ingesta diaria (GB). 0 desactiva el cap.')
param dailyQuotaGb int = 0

resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  tags: tags
  properties: {
    retentionInDays: retentionInDays
    sku: {
      name: skuName
    }
    workspaceCapping: {
      dailyQuotaGb: dailyQuotaGb
    }
  }
}

output workspaceResourceId string = law.id
output workspaceNameOut string = law.name
``
