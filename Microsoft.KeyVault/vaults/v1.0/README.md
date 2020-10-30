# Microsoft.KeyVault/vaults/v1.0

## Contents

* [Description](#description)
* [Required Parameters](#required-parameters)
* [Additional Parameters](#additional-parameters)
* [Parameter File Example](#parameter-file-example)
* [Parameter File Example with Access Policies](#parameter-file-example-with-access-policies)

## Description

ARM Template for deploying a KeyVault

## Required Parameters

#### keyVaultName
Name for the KeyVault, has to be globally unique.

## Additional Parameters

#### location

Specifies the Azure location where the key vault should be created, defaults to the location of the Resource Group.

#### tenantId

The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.

#### skuName

Allowed Values: Standard, Premium
Specify whether the key vault is a standard vault or a premium vault.

#### accessPolicies

Access Policies object, see the Parameter File Examples

#### enabledForDeployment

Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.

#### enabledForDiskEncryption

Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.

#### enabledForTemplateDeployment

Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.

#### enableSoftDelete

Property to specify whether the 'soft delete' functionality is enabled for this key vault.

#### softDeleteRetentionInDays

Soft delete data retention days. It accepts >=7 and <=90.

#### createMode

The vault's create mode to indicate whether the vault need to be recovered or not.

#### enablePurgeProtection

Property specifying whether protection against purge is enabled for this vault.


## Parameter File Example

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "keyVaultName": {
            "value": "rankeyvau-cba321"
        }
    }
}
```

## Parameter File Example with Access Policies

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "keyVaultName": {
            "value": "rankeyvau-cba321"
        },
        "accessPolicies": [
            {
                "tenantId": "abcd1234-ab12-ab12-ab12-abcdef123456",
                "objectId": "1234abcd-12ab-12ab-12ab-123456abcdef",
                "applicationId": "",
                "permissions": {
                    "keys": [],
                    "secrets": [
                        "Get"
                    ],
                    "certificates": [],
                    "storage": []
                }
            }
        ]
    }
}
```