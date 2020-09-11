# Microsoft.Storage/storageAccounts/blobServices/containers/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)

## Description

ARM Template for deploying a Container in a Blob Storage

## Required Parameters

#### storageAccountName

Name of the Storage Account, ie.: ranstoacc-cba321

#### blobContainer

Name of the Container, ie.: $web

## Additional Parameters

#### containerPublicAccess

Sets the Publib Access level to either "None","Blob" or "Container", defaults to: None

## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "storageAccountName": {
            "value": "ranstoacc-cba321"
        },
        "blobContainer": {
            "value": "$web"
        }
    }
}
```