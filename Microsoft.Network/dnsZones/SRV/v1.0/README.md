# Microsoft.Network/dnsZones/SRV/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a SRV Record for a DNS Zone

## Required Parameters

#### dnsZone

The DNS Zone, in which you want to create the SRV Record

#### srvName

Consists of the Service and the Protocol, ie. _sip and _tls becomes _sip._tls

#### srvPriority

The priority, the lower the value the higher the priority

#### srvWeight

A relative weight for SRV records with the same priority

#### srvPort

The port of the serivice, ie: 5000

#### srvTarget

The serveraddress of the service, ie.: service.someprovider.com

## Additional Parameters

#### srvTTL

Time to Live for the SRV Record, defaults to: 3600 (1 Hour)

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "dnsZone": {
            "value": "yourdomain.com"
        },
        "srvName": {
            "value": "_sip._tcp"
        },
        "srvPriority": {
            "value": 10
        },
        "srvWeight": {
            "value": 50
        },
        "srvPort": {
            "value": 22
        },
        "srvTarget": {
            "value": "service.someserviceprovider.com"
        }
    }
}
```