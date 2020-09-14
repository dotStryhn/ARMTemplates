# Required Elements in different files
$parameterElementsRequired	= '$schema', 'contentVersion', 'parameters'
$templateElementsRequired	= '$schema', 'contentVersion', 'functions', 'outputs', 'parameters', 'resources', 'variables'

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

		It "Latest API Version" {			$templateTestCases = @()
			# Tests for the latest API version
			$armTemplate = $(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue
			$templateElementsRequired | ForEach-Object { $templateTestCases += @{ requiredElement = $_ } }
			$providerNamespace,$resourceTypeName = $armTemplate.resources.type.Split('/',2)	
			
			try {	
				$latestApiVersion = ((Get-AzResourceProvider -ProviderNamespace $providerNamespace).ResourceTypes | Where-Object ResourceTypeName -EQ $resourceTypeName).ApiVersions[0]
			}	
			catch {	
				Set-ItResult -Inconclusive -Because 'Missing API Version from Azure'	
			}	
			
			$armTemplate.resources.apiversion | Should -Be $latestApiVersion
		}

		$templateTestCases = @()
		$templateElementsRequired | ForEach-Object { $templateTestCases += @{ requiredElement = $_ } }

		It "Required Element: <requiredElement>" -TestCases $templateTestCases {
			# Tests for Required Elements in the Template
			param($requiredElement)
			$templateElements = ($(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty).Name
			$templateElements -contains $requiredElement | Should -Be $true
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

		$parameterTestCases = @()
		$parameterElementsRequired | ForEach-Object { $parameterTestCases += @{ requiredElement = $_ } }

		It "Required Element: <requiredElement>" -TestCases $parameterTestCases {
			# Tests for Required Elements in the Parameter File
			param($requiredElement)
			$parameterElements = ($(Get-Content $(Join-Path $PSScriptRoot 'azuredeploy.parameters.json') -Raw -ErrorAction SilentlyContinue) | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty).Name
			$parameterElements -contains $requiredElement | Should -Be $true
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