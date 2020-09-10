# Microsoft.Network/dnsZones/A/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Parameter File Example](#parameter-file-example)



## Description

ARM Template for deploying an A Record for a DNS Zone



## Required Parameters

#### dnsZone
The DNS Zone you want to create, ie.: yourdomain.com

#### aName
The Name of the A Record

#### aRecords
Takes an array of IPv4 Addresses


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


