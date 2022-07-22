<#

.SYNOPSIS
Generate a Zoom API access token.

.PARAMETER ApiKey
The Zoom API key.

.PARAMETER ApiSecret
The Zoom API secret.

.PARAMETER ValidforSeconds
The length of time, in seconds, that the token is valid.

.EXAMPLE
$Token = New-ZoomApiToken -ApiKey $ApiKey -ApiSecret $ApiSecret

.OUTPUTS
Zoom API access token as a string.

#>

function New-ZoomApiToken {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter()]
        [string]$ApiKey,

        [Parameter()]
        [string]$ApiSecret,

        [Parameter()]
        [int]$ValidforSeconds = 30
    )

    $Credentials = Get-ZoomApiCredentials -ZoomApiKey $ApiKey -ZoomApiSecret $ApiSecret

    if (-not $Global:ZoomAppType) {

        Write-Verbose "Creating new JWT Token"
        $Token = New-Jwt -Algorithm 'HS256' -type 'JWT' -Issuer $Credentials.ApiKey -SecretKey $Credentials.ApiSecret -ValidforSeconds $ValidforSeconds

    }
    elseif ($Global:ZoomAppType -eq "ServerOAuth") {

        if (-not $Global:ZoomAccountID) {

            throw "Global variable `"AccountID`" not defined"

        }
        else {

            $Token = New-OAuth -ClientID $Credentials.ApiKey -ClientSecret $Credentials.ApiSecret -AccountID $Global:ZoomAccountID

        }
        
    }
    
    Write-Output $Token

}
