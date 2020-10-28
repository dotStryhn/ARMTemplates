# Required Elements in different files
$parameterElementsRequired	=	'$schema',
								'contentVersion',
								'parameters'

$templateElementsRequired	=	'$schema',
								'contentVersion',
								'functions',
								'outputs',
								'parameters',
								'resources',
								'variables'

Describe "$($PSScriptRoot.split('\')[-2]) $($PSScriptRoot.split('\')[-1]) Tests" {

	Context "ARM Template" {

		It "File Exists" {
			# Tests for the ARM Template
			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.json'
			}
			
			Join-Path @joinPathParams | Should -Exist
		}

		It "Valid JSON" {
			# Tests for valid JSON by using ConvertFrom-Json
			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.json'
			}
			
			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction = 'SilentlyContinue'
			}

			$convertFromJsonParams = @{
				Depth		= 25
				ErrorAction = 'SilentlyContinue'
			}

			Get-Content @getContentParams | ConvertFrom-Json @convertFromJsonParams
			$? | Should -Be $true
		}

		It "Latest API Version" {
			# Tests for the latest API version
			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.json'
			}

			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction	= 'SilentlyContinue'
			}

			$convertFromJsonParams = @{
				Depth		= 25
				ErrorAction = 'SilentlyContinue'
			}

			$armTemplate = Get-Content @getContentParams | ConvertFrom-Json @convertFromJsonParams
			$providerNamespace,$resourceTypeName = $armTemplate.resources.type.Split('/',2)	
	
			$getAzResourceProviderParams = @{
				ProviderNamespace = $providerNamespace
			}

			try {	
				$latestApiVersion = (((Get-AzResourceProvider -ProviderNamespace $providerNamespace).ResourceTypes | Where-Object ResourceTypeName -EQ $resourceTypeName).ApiVersions | Where-Object { $_ -NotLike "*-preview" } | Sort-Object -Descending)[0]
			}	
			catch {	
				Set-ItResult -Inconclusive -Because 'Missing API Version from Azure'	
			}	
			
			$armTemplate.resources.apiversion | Should -Be $latestApiVersion
		}

		$templateTestCases = @()
		$templateElementsRequired |
			ForEach-Object {
				$templateTestCases += @{
					requiredElement = $_
				}
			}

		It "Required Element: <requiredElement>" -TestCases $templateTestCases {
			# Tests for Required Elements in the Template
			param(
				$requiredElement
			)

			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.json'
			}

			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction = 'SilentlyContinue'
			}

			$convertFromJsonParams = @{
				Depth		= 25
				ErrorAction = 'SilentlyContinue'
			}

			$getMemberParams = @{
				MemberType	= 'NoteProperty'
			}

			$templateElements = (Get-Content @getContentParams | ConvertFrom-Json @convertFromJsonParams | Get-Member @getMemberParams).Name
			$templateElements -contains $requiredElement | Should -Be $true
		}
	}

	Context "Parameter File" {

		It "File Exists" {
			# Tests for the Parameter file
			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.json'
			}

			Join-Path @joinPathParams | Should -Exist
		}

		It "Valid JSON" {
			# Tests for valid JSON by using ConvertFrom-Json
			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.parameters.json'
			}

			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction = 'SilentlyContinue'
			}

			$convertFromJsonParams = @{
				Depth		= 25
				ErrorAction = 'SilentlyContinue'
			}

			Get-Content @getContentParams | ConvertFrom-Json @convertFromJsonParams
			$? | Should -Be $true
		}

		$parameterTestCases = @()
		$parameterElementsRequired |
			ForEach-Object {
				$parameterTestCases += @{
					requiredElement = $_
				}
			}

		It "Required Element: <requiredElement>" -TestCases $parameterTestCases {
			# Tests for Required Elements in the Parameter File
			param(
				$requiredElement
			)

			$joinPathParams = @{
				Path		= "$PSScriptRoot"
				ChildPath	= 'azuredeploy.parameters.json'
			}

			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction = 'SilentlyContinue'
			}

			$convertFromJsonParams = @{
				Depth		= 25
				ErrorAction = 'SilentlyContinue'
			}
			
			$getMemberParams = @{
				MemberType	= 'NoteProperty'
			}

			$parameterElements = (Get-Content @getContentParams | ConvertFrom-Json @convertFromJsonParams | Get-Member @getMemberParams).Name
			$parameterElements -contains $requiredElement | Should -Be $true
		}
	}

	Context "README.md" {

		It "File Exists" {
			# Tests for the README file
			$joinPathParams = @{
				Path 		= "$PSScriptRoot"
				ChildPath	= 'README.md'
			}

			Join-Path @joinPathParams | Should -Exist
		}

		It "Not Empty" {
			# Tests for content in the README.md
			$joinPathParams = @{
				Path 		= "$PSScriptRoot"
				ChildPath	= 'README.md'
			}

			$getContentParams = @{
				Path		= Join-Path @joinPathParams
				Raw			= $true
				ErrorAction = 'SilentlyContinue'
			}

			Get-Content @getContentParams | Should -Not -BeNullOrEmpty
		}
	}

	Context "Deployment to Azure" {
		
		It "Test-AzResourceGroupDeployment" {
			# Tests the Deployment using 'Test-AzResourceGroupDeployment'
			$joinPathTParams = @{
				Path		= "$PSScriptRoot" 
				ChildPath	= 'azuredeploy.json'
			}

			$joinPathPParams = @{
				Path		= "$PSScriptRoot" 
				ChildPath	= 'azuredeploy.parameters.json'
			}

			$TestAzRecourceGroupDeploymentParams = @{
				ResourceGroupName = 'zTemplateTest'
				TemplateFile = Join-Path @joinPathTParams
				TemplateParameterFile = Join-Path @joinPathPParams
			}

			Test-AzResourceGroupDeployment @TestAzRecourceGroupDeploymentParams
			$? | Should -Be $true
		}
	}
}