$templateContent = Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue
$parameterContent = Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') -Raw -ErrorAction SilentlyContinue

$armTemplateName = $($PSScriptRoot.split('\')[-2]) 
$armTemplateVersion = $($PSScriptRoot.split('\')[-1])

Describe "ARM Template Validation" {
	Context "$armTemplateName $armTemplateVersion" {
		It "Template File Exists" {
			Test-Path $(Join-Path $PSScriptRoot 'azuredeploy.json') -PathType Leaf | Should -Be $true
		}

		It "Parameter File Exists" {
			Test-Path $(Join-Path $PSScriptRoot 'azuredeploy.json') -PathType Leaf | Should -Be $true
		}

		It "Template File is valid JSON" {
			$templateContent | ConvertFrom-Json -ErrorAction SilentlyContinue | Should -Not -Be $null
		}

		It "Parameter File is valid JSON" {
			$parameterContent | ConvertFrom-Json -ErrorAction SilentlyContinue | Should -Not -Be $null
		}

		It "Testing ARM Deployment to Azure" {
			Test-AzResourceGroupDeployment -ResourceGroupName 'zTemplateTest' -TemplateFile .\azuredeploy.json -TemplateParameterFile .\azuredeploy.parameters.json | Should -BeNullOrEmpty
		}
  	}
}