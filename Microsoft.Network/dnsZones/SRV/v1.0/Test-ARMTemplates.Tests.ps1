Describe "$($PSScriptRoot.split('\')[-2]) $($PSScriptRoot.split('\')[-1]) Tests" {

	Context "ARM Template" {

		It "File Exists" {
			# Tests for the ARM Template
			Join-Path $PSScriptRoot 'azuredeploy.json' | Should -Exist
		}

		It "Valid JSON meets Requirements" {
			# Tests for valid JSON which contains the required elements
			$templateElementsRequired =	'$schema',
										'contentVersion',
										'functions',
										'outputs',
										'parameters',
										'resources',
										'variables'

			$templateElements = $(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name
			$templateElements | Should -Be $templateElementsRequired
		}
	}

	Context "Parameter File" {

		It "File Exists" {
			# Tests for the Parameter file
			$(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') | Should -Exist
		}

		It "Valid JSON meets Requirements" {
			# Tests for valid JSON which contains the required elements
			$parameterElementsRequired =	'$schema',
											'contentVersion',
											'parameters'

			$parameterElements = $(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name
			$parameterElements | Should -Be $parameterElementsRequired
		}
	}

	Context "README.md" {

		It "File Exists" {
			# Tests for the README file
			$(Join-Path $PSScriptRoot 'README.md') | Should -Exist
		}

		It "NotNullorEmpty" {
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