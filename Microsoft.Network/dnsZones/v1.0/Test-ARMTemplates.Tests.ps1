# Variables
$testResourceGroup = 'zTemplateTest'

# Paths for the required files
$templatePath = Join-Path $PSScriptRoot 'azuredeploy.json'
$parameterPath = Join-Path $PSScriptRoot 'azuredeploy.parameters.json'
$readmePath = Join-Path $PSScriptRoot 'README.md'

# Gets the content of the required files
$templateContent = Get-Content $templatePath -Raw -ErrorAction SilentlyContinue
$parameterContent = Get-Content $parameterPath -Raw -ErrorAction SilentlyContinue
$readmeContent = Get-Content $readmePath -Raw -ErrorAction SilentlyContinue

# Get the Template Name and Version from the directory structure
$armTemplateName = $($PSScriptRoot.split('\')[-2]) 
$armTemplateVersion = $($PSScriptRoot.split('\')[-1])

Describe "ARM Template Validation" {
	Context "$armTemplateName $armTemplateVersion" {
		It "ARM Template - File Exists" {
			# Tests for the ARM Template
			$templatePath | Should -Exist
		}

		It "ARM Template - Valid JSON meets Requirements" {
			# Tests for valid JSON which contains the required elements
			$templateElementsRequired =	'$schema',
										'contentVersion',
										'functions',
										'outputs',
										'parameters',
										'resources',
										'variables'

			$templateElements = $templateContent | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name
			$templateElements | Should -Be $templateElementsRequired
		}

		It "Parameter File - File Exists" {
			# Tests for the Parameter file
			$parameterPath | Should -Exist
		}

		It "Parameter File - Valid JSON meets Requirements" {
			# Tests for valid JSON which contains the required elements
			$parameterElementsRequired =	'$schema',
											'contentVersion',
											'parameters'

			$parameterElements = $parameterContent | ConvertFrom-Json -Depth 10 -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | ForEach-Object Name
			$parameterElements | Should -Be $parameterElementsRequired
		}

		It "README.md - File Exists" {
			# Tests for the README file
			$readmePath | Should -Exist
		}

		It "README.md - NotNullorEmpty" {
			# Tests for content in the README.md
			$readmeContent | Should -Not -BeNullOrEmpty
		}

		It "Test-AzResourceGroupDeployment" {
			# Tests the Deployment using 'Test-AzResourceGroupDeployment'
			Test-AzResourceGroupDeployment -ResourceGroupName $testResourceGroup -TemplateFile $templatePath -TemplateParameterFile $parameterPath
			$? | Should -Be $true
		}
  	}
}
