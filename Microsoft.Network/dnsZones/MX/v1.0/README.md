# Microsoft.Network/dnsZones/CNAME/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a MX Record for a DNS Zone

## Required Parameters

#### dnsZone

The DNS Zone, in which you want to create the MX Record

#### mailExchange

The address of the mail exchanger, ie: mail.somemailserver.com

## Additional Parameters

#### mxName

The name of the MX record, defaults to: @

#### mxPreference

The preference of the mail exchanger, defaults to: 0

#### mxTTL

Time to Live for the MX Record, defaults to: 3600 (1 Hour)

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dnsZone": {
            "value": "yourdomain.com"
        },
        "mailExchange": {
            "value": "mail.somemailserver.com"
        }
    }
}
```