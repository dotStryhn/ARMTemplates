# Required Elements in different files
$templateElementsRequired	=	'$schema', 'contentVersion', 'functions', 'output', 'parameters', 'resources', 'variables'
$parameterElementsRequired	=	'$schema', 'contentVersion', 'parameters'

Describe "$($PSScriptRoot.split('\')[-2]) $($PSScriptRoot.split('\')[-1]) Tests" {

	Context "ARM Template" {

		It "File Exists" {
			# Tests for the ARM Template
			Join-Path $PSScriptRoot 'azuredeploy.json' | Should -Exist
		}

		It "Valid JSON" {
			# Tests for valid JSON by using ConvertFrom-Json
			$(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue
			$? | Should -Be $true
		}

		$templateElements = $(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name

		foreach ($requiredTemplateElement in $templateElementsRequired) {

			It "Required Element: $requiredTemplateElement" {
				# Tests for each the Required Template Elements
				$templateElements -contains $requiredTemplateElement | Should -Be $true
			}
		}
	}

	Context "Parameter File" {

		It "File Exists" {
			# Tests for the Parameter file
			$(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') | Should -Exist
		}

		It "Valid JSON" {
			# Tests for valid JSON by using ConvertFrom-Json
			$(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue
			$? | Should -Be $true
		}

		$templateElements = $(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name

		foreach ($requiredParameterElement in $parameterElementsRequired) {

			It "Required Element: $requiredParameterElement" {
				# Tests for each the Required Parameter Elements
				$templateElements -contains $requiredParameterElement | Should -Be $true
			}
		}
	}

	Context "README.md" {

		It "File Exists" {
			# Tests for the README file
			$(Join-Path $PSScriptRoot 'README.md') | Should -Exist
		}

		It "Not Empty" {
			# Tests for content in the README.md
			$(Get-Content $(Join-Path $PSScriptRoot 'README.md') -Raw -ErrorAction SilentlyContinue) | Should -Not -BeNullOrEmpty
		}
	}

	Context "Deployment to Azure" {
		
		It "Test-AzResourceGroupDeployment" {
			# Tests the Deployment using 'Test-AzResourceGroupDeployment'
			Test-AzResourceGroupDeployment -ResourceGroupName 'zTemplateTest' -TemplateFile $(Join-Path $PSScriptRoot 'azuredeploy.json') -TemplateParameterFile $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json')
			$? | Should -Be $true
		}
	}
}