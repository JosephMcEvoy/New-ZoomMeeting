<#

.SYNOPSIS
Update a user on your account.

.PARAMETER Type
Basic (1)
Pro (2)
Corp (3)

.PARAMETER LoginType
The user's login method. Valid inputs are:
Facebook
Google
Apple
Microsoft
Mobile
RingCentra
API
ZoomWorkEmail
SSO

The following are also available in China:
Phone
WeChat
Alipay
                    
.PARAMETER FirstName
User's first namee: cannot contain more than 5 Chinese words.

.PARAMETER LastName
User's last name: cannot contain more than 5 Chinese words.

.PARAMETER Pmi
Personal Meeting ID, long, length must be 10.

.PARAMETER UsePmi
Use Personal Meeting ID for instant meetings.

.PARAMETER Language
Language.

.PARAMETER Dept
Department for user profile: use for report.

.PARAMETER VanityName
Personal meeting room name.

.PARAMETER HostKey
Host key. It should be a 6-10 digit number.

.PARAMETER CMSUserId
Kaltura user ID.

.PARAMETER JobTitle
Users's job title.

.PARAMETER Company
Users's company.

.PARAMETER Location
Users's location.

.PARAMETER PhoneNumber
Deprecated: Phone number of the user, To update you must also provide the PhoneCountry field.

.PARAMETER PhoneCountry
Deprecated: Country ID of the phone number. eg. AU for Australia.

.PARAMETER GroupID
Unique identifier of the group that you would like to add a pending user to.

.PARAMETER ApiKey
The API key.

.PARAMETER ApiSecret
THe API secret.

.OUTPUTS
No output. Can use Passthru switch to pass UserId to output.

.EXAMPLE
Update a user's name.
Update-ZoomUser -UserId askywakler@thejedi.com -Type Pro -FirstName Anakin -LastName Skywalker -ApiKey $ApiKey -ApiSecret $ApiSecret

.EXAMPLE
Update the host key of all users that have 'jedi' in their email.
(Get-ZoomUsers -allpages) | select Email | ? {$_ -like '*jedi*'} | update-zoomuser -hostkey 001138

.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/users/userupdate

#>

function Update-ZoomUser {    
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

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('Facebook', 'Google', 'API', 'Zoom', 'SSO', 'Apple', 'Microsoft', 'Mobile', 'RingCentral', 'ZoomWorkEmail', 0, 1, 11, 21, 23, 24, 27, 97, 98, 99, 100, 101)]
        [Alias('login_type')]
        [string]$LoginType,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('Basic', 'Pro', 'Corp', 1, 2, 3)]
        $Type,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateLength(1, 64)]
        [Alias('first_name')]
        [string]$FirstName,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateLength(1, 64)]
        [Alias('last_name')]
        [string]$LastName,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateRange(1000000000, 9999999999)]
        [long]$Pmi = $null,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('use_pmi')]
        [bool]$UsePmi,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateScript({
                (Get-ZoomTimeZones).Contains($_)
        })]
        [string]$Timezone,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [string]$Language,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('department')]
        [string]$Dept,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('vanity_name')]
        [string]$VanityName,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidatePattern("[0-9]{6,10}")] #A six to ten digit number.
        [Alias('host_key')]
        [string]$HostKey,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('cms_user_id')]
        [string]$CmsUserId,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('job_title')]
        [string]$JobTitle,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [string]$Company,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [string]$Location,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('phone_number')]
        [string]$PhoneNumber,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('phone_country')]
        [string]$PhoneCountry,
        
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('group_id')]
        [string]$GroupID,

        [ValidateNotNullOrEmpty()]
        [string]$ApiKey,
        
        [ValidateNotNullOrEmpty()]
        [string]$ApiSecret,

        [switch]$PassThru
    )
    
    begin {
        #Generate Header with JWT (JSON Web Token) using the Api Key/Secret
        $Headers = New-ZoomHeaders -ApiKey $ApiKey -ApiSecret $ApiSecret
    }

    process {
        foreach ($user in $UserId) {
            $Request = [System.UriBuilder]"https://api.zoom.us/v2/users/$user"
            $RequestBody = @{ }   

            if ($PSBoundParameters.ContainsKey('LoginType')) {
                $LoginType = switch ($LoginType) {
                    'Facebook'      { 0 }
                    'Google'        { 1 }
                    'Phone'         { 11 }
                    'WeChat'        { 21 }
                    'Alipay'        { 22 }
                    'Apple'         { 24 }
                    'Microsoft'     { 27 }
                    'Mobile'        { 97 }
                    'RingCentra'    { 98 }
                    'API'           { 99 }
                    'ZoomWorkEmail' { 100 }
                    'SSO'           { 101 }
                    Default         { $LoginType }
                }
                $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)  
                $query.Add('login_type', $LoginType)
                $Request.Query = $query.ToString()
            }

            if ($Type) {
                $Type = switch ($Type) {
                    'Basic' { 1 }
                    'Pro' { 2 }
                    'Corp' { 3 }
                    Default { $Type }
                }

                $RequestBody.Add('type', $Type)
            }

            if ($Pmi -ne 0) {
                $RequestBody.Add('pmi', $Pmi)
            }

            $KeyValuePairs = @{
                'first_name'    = $FirstName
                'last_name'     = $LastName
                'timezone'      = $Timezone
                'language'      = $Language
                'use_pmi'       = $UsePmi
                'dept'          = $Dept
                'vanity_name'   = $VanityName
                'host_key'      = $HostKey
                'cms_user_id'   = $CmsUserId
                'job_title'     = $JobTitle
                'company'       = $Company
                'location'      = $Location
                'phone_number'  = $PhoneNumber
                'phone_country' = $PhoneCountry
                'group_id'      = $GroupID
            }

            $KeyValuePairs.Keys | ForEach-Object {
                if (-not ([string]::IsNullOrEmpty($KeyValuePairs.$_))) {
                    $RequestBody.Add($_, $KeyValuePairs.$_)
                }
            }

            $RequestBody = $RequestBody | ConvertTo-Json

            if ($pscmdlet.ShouldProcess) {
                $response = Invoke-ZoomRestMethod -Uri $request.Uri -Headers ([ref]$Headers) -Body $requestBody -Method PATCH -ApiKey $ApiKey -ApiSecret $ApiSecret
        
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
