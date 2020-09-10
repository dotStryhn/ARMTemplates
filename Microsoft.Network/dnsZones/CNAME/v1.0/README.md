# Microsoft.Network/dnsZones/CNAME/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a CNAME Record for a DNS Zone

## Required Parameters

#### dnsZone
The DNS Zone you want to add the CNAME record to, ie.: yourdomain.com

#### cname
The Name of the CNAME record

#### cnameAlias
The alias for the CNAME

## Additional Parameters

#### cnameTTL

Time to Live for the CNAME, defaults to: 3600 (1 Hour)

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dnsZone": {
            "value": "yourdomain.com"
        },
        "aName": {
            "value": "www"
        },
        "aRecord": {
            "value": [
                {
                    "ipv4Address": "10.0.0.1"
                }
            ]
        }
    }
}
```
