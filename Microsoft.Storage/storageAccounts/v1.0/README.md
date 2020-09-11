# Microsoft.Storage/storageAccounts/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a Blob Service in a Storage Account

## Required Parameters

#### storageAccountName

The Storage Account to deploy, ie: ranstoacc-cba321

## Additional Parameters

#### location

The Azure Location in which to create the Storage Account, defaults to the Resource Group Location

#### storageAccountAccesTier

Access Tier for the Storage Account, defaults to: Hot

#### storageAccountCustomDomain

To use with a Custom Domain, defaults to: ''

#### storageAccountSKUName

SKU Name for the Storage Account, defaults to: Standard_LRS

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "storageAccountName": {
            "value": "ranstoacc-cba321"
        }
    }
}
```