# Microsoft.Network/dnsZones

## Required Parameters

### dnsZone
The DNS Zone you want to create, ie.: yourdomain.com

## Parameterfile Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dnsZone": {
            "value": "yourdomain.com"
        }
    }
}
```


