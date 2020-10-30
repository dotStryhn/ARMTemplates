# Microsoft.Network/dnsZones/TXT/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a TXT Record for a DNS Zone

## Required Parameters

#### dnsZone

The DNS Zone, in which you want to create the TXT Record

#### txtName

Name of the TXT Record, ie.: @

#### txtValue

The content of the TXT Record

## Additional Parameters

#### txtTTL

Time to Live for the TXT Record, defaults to: 3600 (1 Hour)

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dnsZone": {
            "value": "yourdomain.com"
        },
        "txtName": {
            "value": "@"
        },
        "txtValue": {
            "value": "Sample Text"
        }
    }
}
```