<#

.SYNOPSIS
Upload a user’s profile picture.
.DESCRIPTION
Upload a user’s profile picture.
.PARAMETER UserId
The user ID or email address.
.PARAMETER FileName
The path to the file to be uploaded.
.PARAMETER ApiKey
The Api Key.
.PARAMETER ApiSecret
The Api Secret.
.OUTPUTS
A hastable with the Zoom API response.
.EXAMPLE
Update-ZoomProfilePicture -UserId 'jmcevoy@lawfirm.com' -FileName "C:\Development\Zoom\PSZoom\mcevoy.jpg"
.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/users/userpicture

#>

function Update-ZoomProfilePicture {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            Position = 0, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('Email', 'EmailAddress', "Id")]
        [string[]]$UserId,

        [Parameter(
            Mandatory = $True,
            ValueFromPipelineByPropertyName = $True,
            Position = 1
        )]
        [ValidateScript({Test-Path -Path $_})]
        [string]$FileName,

        [ValidateNotNullOrEmpty()]
        [string]$ApiKey,

        [ValidateNotNullOrEmpty()]
        [string]$ApiSecret
    )

    begin {
        #Generate Header with JWT (JSON Web Token) using the Api Key/Secret
        $headers = New-ZoomHeaders -ApiKey $ApiKey -ApiSecret $ApiSecret
    }

    process {
        foreach ($user in $UserId) {
            $request = [System.UriBuilder]"https://api.zoom.us/v2/users/$user/picture"
            $LF = "`r`n";

            if ($PSVersionTable.PSVersion.Major -lt 6) {
                $fileBytes = Get-Content -Path $FileName -Encoding Byte
            } else {
                $fileBytes = Get-Content -Path $FileName -AsByteStream
            }
            
            $fileContent = [System.Text.Encoding]::GetEncoding('iso-8859-1').GetString($fileBytes);
            $boundary = [System.Guid]::NewGuid().ToString()
    
    
            $requestBody = ( 
                "--$boundary",
                "Content-Disposition: form-data; name=`"pic_file`"; filename=`"$FileName`"",
                "Content-Type: image/jpeg$LF",
                "$fileContent",
                "--$boundary--"
            ) -join $LF
    
            $response = Invoke-ZoomRestMethod -Uri $request.Uri -ContentType "multipart/form-data; boundary=`"$boundary`"" -Headers ([ref]$headers) -Body $requestBody -Method POST -ApiKey $ApiKey -ApiSecret $ApiSecret

            Write-Output $response
        }
    }
}