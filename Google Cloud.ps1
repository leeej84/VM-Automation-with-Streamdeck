#Script to control the power status of Virtual Machines in Google Cloud Services
#This script requires the GoogleCloud module - Install-Module GoogleCloud
#This script requires the BurntToast module - Install-Module BurntToast
#You will need to populate some varaibles, one of them being the project ID
#Create a service account like this:
# gcloud iam service-accounts create powershellservice --description="PowerShell Service Account" --display-name="PowerShell Service"
# Get the account you are currently logged in with
# gcloud config list

Import-Module GoogleCloud
Import-Module BurntToast

#Variables to populate begin
$projectID = "***Insert GCP Project ID***"
$VMName = "***Insert GCP VMName***"
$VMZome = "***Insert GCP Zone Name***"
#Variables to populate end
$scriptFolder = split-path -parent $MyInvocation.MyCommand.Definition

$VMDetails = Get-GceInstance -Project $projectID -Name $VMName -Zone $VMZome | Select-Object *

If ($VMDetails.Status -ne "Running") {
    Start-GceInstance -Object $VMDetails
    New-BurntToastNotification -Text "Google SDWAN Off","GCP SDWAN is off, powering on" -AppLogo "$scriptFolder\On.jpg"
} else {
    Stop-GceInstance -Object $VMDetails
    New-BurntToastNotification -Text "Google SDWAN On","GCP SDWAN is on, powering off" -AppLogo "$scriptFolder\Off.jpg"
}

