# JAMF-HL7Tools-Script
Script using HL7Tools package for easy running, with defaults

Requires: https://github.com/RobHolme/HL7-Powershell-Module
  HL7Tools does the heavy lifting
  >Update 2020-06-04! This script is confirmed to work with release v1.6.7
  
  >https://github.com/RobHolme/HL7-Powershell-Module/releases/tag/v1.6.7
  
  Follow Rob's install instructions, and place his module in your Modules ($Env:PSModulePath) path.
  You can Install it, import it into other scripts, and invoke as needed.
  
Setup 
PowershellCore /Mac
  - Unzip release from HL7 Powershell Module release above.
  - Copy HL7Tools folder to Modules folder (one of values returned with $Env:PSModulePath)
  - Verify Available
    - `Get-Module -ListAvailable | grep HL7Tools`
    - Try and invoke `Send-HL7Message`, should be viewable in powershell console available commands
    
    - Copy Send-JamfHL7.ps1 into a scripts folder or into your `$Env:PSModulePath` (preferred)
    - Edit and save the script for your environments, and other perferred default
    - Open Powershell console
    - Load the script `. [path_to_file]/JAMF-HL7Script.ps1 `
    - Test #\#` Send-JAMFHL7Message`
    


# Note
Though this was initially created to mimic Epic HL7 messages sent to JAMF listener, it should adapt to other HL7 message send requirements.  The message structure would change based on environment variables in your use scenarios.

That said this is not unique to JAMF usage, but started as a tool just for listener testing without having to login to the EMR to change Patient Interaction/Admitted/Discharged state to trigger messages for adhoc testing.

I hope it helps others.
DKM


# Usage Examples
@TODO Will alsoo add to the module 
- Use All Defaults in script  
  
  `Send-JAMFHL7Message`
- Provide Param overides at runtime [each param is optional]
  
  `Send-JamfHL7Message -environment "dev" -adt "A01" -bed "Unit1_Room1_Bed01" -newbed "TransferBed01"`
