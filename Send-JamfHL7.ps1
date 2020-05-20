Import-Module HL7Tools

'''
  @TODO try using dotenv or other config file method for defaults
'''
Function Get-MyDefaults ($environment) {
  # Update array with the different environments you would like to utilize with this script.
  # JAMF uses 8080 as the default for JAMF Listener, but port 2575 is the Common HL7 Port
  # number assigned.  Of course you can use any port you like.  Make sure that your tenant 
  # is setup for the port that you choose.
    $defaults = @{
        Environments = @{
            Prod = @{url = "prod.domain.com"; port = 2575};
            Dev = @{url = "dev.domain.com"; port = 2575}
        }
    }
    
    return $defaults.environments["$environment"]

}


Function Send-JamfHL7Message {
    param (

        [string]
        $environment = "Dev",

        [ValidateSet(
            "A01" <#Admission#>,
            "Admission",

            "A02" <#Transfer#>,
            "Transfer",

            "A03" <#Discharge#>,
            "Discharge",

            "A11" <#Cancel Admission#>,
            "Cancel Admission",

            "A12" <#Cancel  Transfer#>,
            "Cancel Transfer",

            "A13" <#Cancel Discharge#>,
            "Cancel Discharge"
        )]
        [string]
        $adt = "A03", #Discharge

        [string]
        #refer to Epic URB room listing names for PROD use, for testing, this $bed value
        # can be anything you wish, as long as it is assigned in the {Room} field in JAMFPro
        # for the device you want to trigger rules for with this script.
        $bed = "Unit_Room_Bed",

        [string]
        $newbed = ""
    )

    $adt = switch ($adt){
             # If the word is used, transform it for HL7 message use to the ADT code instead.
            "Admission" {"A01"} <#Admission#>
            "Transfer" {"A02"} <#Transfer#>
            "Discharge" { "A03"} <#Discharge#>
            "Cancel Admission" {"A11"} <#Cancel Admission#>
            "Cancel Transfer" {"A12"} <#Cancel  Transfer#>
            "Cancel Discharge" {"A13"} <#Cancel Discharge#>
        default {$adt}
    }


    # Set values used for settings, message values and file management
    $date = $(Get-Date)
    $url = $(Get-MyDefaults "$environment").url
    $port = $(Get-MyDefaults "$environment").port
    $datestampfile = $date.ToString("yyyy-MM-dd-hh-mm-ss")
    $datestampmsg = $date.ToString("yyyyMMddhhmmss")
    # default location for saving the hl7 message file is c:\temp
    # Change the PATH for $hl7file to reflect your OS format and directory preference
    # ie macOS/Linux could be \var\tmp, or in our user home.
    $hl7file = "c:\temp\hl7\message-$datestampfile.hl7"
    $msgNumber = Get-Random -Minimum 1000 -Maximum 50000

    # change "COMPANY" to your own values
    $message = "MSH|^~\&|$env:COMPUTERNAME|COMPANY|JAMF|COMPANY|$datestampmsg|28162|ADT^$adt|$msgNumber|T|2.3|||AL|NE|||||||
PV1||IP|^^$bed|||^^$newbed"

    
    # $message | Out-File -FilePath $hl7file

    # Get-Content $hl7file
    # Get-ChildItem "$hl7file"

    $response = try{
        Send-HL7Message -HostName $url -Port $port -Path $hl7file
    } catch {
        {"Error"}
    }

    return $response
}

