# VM-Automation-with-Streamdeck
Power on VM's with a touch of a button using streamdeck and powershell

All scripts have dependencies on PowerShell modules being installed and potentially configured correct before being used. Please read the entry comments in each script dependent on your cloud provider.

* Extract the scripts into a folder
* Stream deck Action is "System\Open".
* Assign to relevant cloud provider image to the button
* Streamdeck App/File:
  * C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\Cloud Automation Streamdeck\Azure Cloud.ps1"
