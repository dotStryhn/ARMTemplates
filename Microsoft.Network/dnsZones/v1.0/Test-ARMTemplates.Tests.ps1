# Variables
$TestResourceGroup = 'zTemplateTest'

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
	Context "$armTemplateName $armTemplateVersion - ARM Template and Parameter File" {
		It "File Exists - ARM Template" {
			# Tests for the ARM Template
			$templatePath | Should -Exists
		}

		It "File Exists - Parameter File" {
			# Tests for the Parameter file
			$parameterPath | Should -Exists
		}

		It "File Exists - README File" {
			# Tests for the README file
			$readmePath | Should -Exists
		}

		It "Valid JSON - ARM Template" {
			# Test the content of the ARM template for valid JSON
			$templateContent | ConvertFrom-Json -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
		}

		It "Valid JSON - Parameter File" {
			# Test the content of the parameter file for valid JSON
			$parameterContent | ConvertFrom-Json -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
		}

		It "NotNullorEmpty - README.md" {
			# Tests for content in the README.md
			$readmeContent | Should -Not -BeNullOrEmpty
		}

		It "Test-AzResourceGroupDeployment" {
			# Tests the Deployment, for this not to fail you need an existing ResourceGroup defined in the # Variables
			Test-AzResourceGroupDeployment -ResourceGroupName $TestResourceGroup -TemplateFile $templatePath -TemplateParameterFile $parameterPath | Should -BeNullOrEmpty
		}
  	}
}
