#Script to control the power status of Virtual Machines in Amazon Cloud Services
#This script requires the AWS Powershell module - Install-Module AWSPowershell
#This script requires the BurntToast module - Install-Module BurntToast
#You will need to create yourself a service account to use powershell with AWS
#Sign into your AWS console to do this, Services, IAM, Users, Add user - Tick programmatic access, note the relevant security keys
# Set-AWSCredentials -AccessKey xxxxxxx -SecretKey xxxxxxx -StoreAs AWSPowershell
# Get-AWSCredential -ListProfileDetail
# Initialize-AWSDefaultConfiguration -ProfileName AWSPowershell -Region eu-west-2
# Fill in the variables below

Import-Module AWSPowershell
Import-Module BurntToast

#Variables to populate begin
$VMInstanceID = "i-0cf8a3d2856e8db78"
#Variables to populate end
$scriptFolder = split-path -parent $MyInvocation.MyCommand.Definition

$VMDetails = (Get-EC2Instance -InstanceId $VMInstanceID).Instances.State.Name

If ($VMDetails -ne "running") {
    Start-EC2Instance -InstanceId $VMInstanceID 
    New-BurntToastNotification -Text "AWS SDWAN Off","AWS SDWAN is off, powering on" -AppLogo "$scriptFolder\On.jpg"
} else {
    Stop-EC2Instance -InstanceId $VMInstanceID 
    New-BurntToastNotification -Text "AWS SDWAN On","AWS SDWAN is on, powering off" -AppLogo "$scriptFolder\Off.jpg"
}
