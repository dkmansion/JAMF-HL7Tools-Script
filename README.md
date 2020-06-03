# JAMF-HL7Tools-Script
Script using HL7Tools package for easy running, with defaults

Requires: https://github.com/RobHolme/HL7-Powershell-Module
  HL7Tools does the heavy lifting
  This script is confirmed to work with v1.6.5
  https://github.com/RobHolme/HL7-Powershell-Module/releases/tag/v1.6.5
  
  Follow Rob's install instructions, and place this script with your scripts or Modules folder.
  You can Install it, import it into other scripts, and invoke as needed.

# Note
Though this was initially created to mimic Epic HL7 messages sent to JAMF listener, it should adapt to other HL7 message send requirements.  The message structure would change based on environment variables in your use scenarios.

That said this is not unique to JAMF usage, but started as a tool just for listener testing without having to login to the EMR to change Patient Interaction/Admitted/Discharged state to trigger messages for adhoc testing.

I hope it helps others.
DKM
