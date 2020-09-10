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
The DNS Zone you want to add the MX record to, ie.: yourdomain.com

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
[include](File:azuredeploy.parameters.json)
```