#Script to control the power status of Virtual Machines in Azure Cloud Services
#This script requires the Azure Powershell module - Install-Module AzureRM
#This script requires the BurntToast module - Install-Module BurntToast
#You will need to create yourself a service account to use powershell with Azure
#Once the modules are installed, connect interactively and configure your service account
# Create a service principal in the cloud shell
# az ad sp create-for-rbac -n "AzurePowershell" 
# Fill in the variables below, App ID and App Secret

Import-Module AWSPowershell
Import-Module BurntToast

#Variables to populate begin
$VMName = "***Insert VM Name Here***"
$VMResourceGroup = "***Insert VM Resource Group Here***"
$spApplicationId = "***Insert AppID from step above when creating SPN***"
$spSecret = "***Insert App Secret from step above when creating SPN***"
$azTenant = "***Insert Azure Tenant ID***"
#Variables to populate end
$scriptFolder = split-path -parent $MyInvocation.MyCommand.Definition

$pscredential = New-Object -TypeName System.Management.Automation.PSCredential($spApplicationId, ($spSecret | ConvertTo-SecureString -AsPlainText -Force))
Connect-AzureRmAccount -ServicePrincipal -Credential $pscredential -Tenant $azTenant

$VMDetails = (Get-AzureRmVM -Name $VMName -ResourceGroupName $VMResourceGroup -Status).Statuses.DisplayStatus | Where-Object {$_ -ne "Provisioning succeeded"}

If ($VMDetails -ne "VM running") {
    Start-AzureRmVM -Name $VMName -ResourceGroupName $VMResourceGroup
    New-BurntToastNotification -Text "Azure SDWAN Off","Azure SDWAN is off, powering on" -AppLogo "$scriptFolder\On.jpg"
} else {
    Stop-AzureRmVM -Name $VMName -ResourceGroupName $VMResourceGroup -Force
    New-BurntToastNotification -Text "Azure SDWAN On","Azure SDWAN is on, powering off" -AppLogo "$scriptFolder\Off.jpg"
}
