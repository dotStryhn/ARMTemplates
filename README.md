# ARMTemplates

Templates for Azure Resource Manager, these are the templates I use for my own little projects.

# File Structure Example

Example file structure shows a *service* with the following example properties:

- Name: `Microsoft.Network/dnsZones`
- Version: `v1.0`
- Documentation: `README.md`
- Template File: `azuredeploy.json`
- Parameter File: `azuredeploy.parameters.json`
- Template Test File: `Test-ARMTemplate.Tests.ps1`

```bash
│   README.md
│
└───Microsoft.Network
    └───dnsZones
        └───v1.0
                azuredeploy.json
                azuredeploy.parameters.json
                README.md
                Test-ARMTemplates.Tests.ps1
```
Tree generated using ```tree /f```