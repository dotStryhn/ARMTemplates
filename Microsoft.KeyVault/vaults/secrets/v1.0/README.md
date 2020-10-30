# Microsoft.KeyVault/vaults/secrets/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a KeyVault Secret

## Required Parameters

#### keyVaultName

Name for the KeyVault.

#### secretName

Name of the Secret

#### secretValue

Value of the Secret

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "keyVaultName": {
            "value": "rankeyvau-cba321"
        },
        "secretName": {
            "value": "ransecname"
        },
        "secretValue": {
            "value": "ransecvalue"
        }
    }
}
```
