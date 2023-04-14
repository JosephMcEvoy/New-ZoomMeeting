<#

.SYNOPSIS
Alter calling plan on a Zoom Phone User
                    
.PARAMETER LicenseType
License Type that is to applied to target phone account.
Use following command to get available license types for Zoom instance.
Get-ZoomPhoneCallingPlans

.OUTPUTS
No output. Can use Passthru switch to pass UserId to output.

.EXAMPLE
Update-ZoomPhoneUserCallingPlans -UserId askywakler@thejedi.com -Type 200

.LINK
https://developers.zoom.us/docs/api/rest/reference/phone/methods/#operation/updateCallingPlan

.LINK
https://developers.zoom.us/docs/api/rest/other-references/plans/

#>

function Update-ZoomPhoneUserCallingPlans {    
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param(
        [Parameter(
            Mandatory = $True,       
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            Position = 0
        )]
        [ValidateLength(1, 128)]
        [Alias('Email', 'Emails', 'EmailAddress', 'EmailAddresses', 'Id', 'ids', 'user_id', 'user', 'users', 'userids')]
        [string[]]$UserId,

        [Parameter(
            Mandatory = $True, 
            Position = 1
        )]
        [Alias('License_Type')]
        [int]$LicenseType,

        [switch]$PassThru
    )
    


    process {
        foreach ($user in $UserId) {

            $CurrentLicense = Get-ZoomPhoneUser -UserId $user | Select-Object -ExpandProperty "calling_plans" | Select-Object -ExpandProperty "type"

            $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/phone/users/$user/calling_plans"
            $RequestBody = @{ }


            $KeyValuePairs = @{
                'source_type'    = $CurrentLicense
                'target_type'    = $LicenseType

            }

            $KeyValuePairs.Keys | ForEach-Object {
                if (-not ([string]::IsNullOrEmpty($KeyValuePairs.$_))) {
                    $RequestBody.Add($_, $KeyValuePairs.$_)
                }
            }

            $RequestBody = $RequestBody | ConvertTo-Json

            if ($pscmdlet.ShouldProcess) {
                $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $requestBody -Method POST
        
                if (-not $PassThru) {
                    Write-Output $response
                }
            }
        }

        if ($PassThru) {
            Write-Output $UserId
        }
    }
}
