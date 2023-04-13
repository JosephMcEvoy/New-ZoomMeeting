<#

.SYNOPSIS
Update a meeting registrant’s status.
.DESCRIPTION
Update a meeting registrant’s status.
.PARAMETER MeetingId
The meeting ID.

.OUTPUTS
.LINK
.EXAMPLE
Update-ZoomMeetingRegistrantStatus  123456789

#>

function Update-ZoomMeetingRegistrantStatus {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            Position = 0
        )]
        [Alias('meeting_id')]
        [string]$MeetingId,

        [Parameter(
            ValueFromPipelineByPropertyName = $True, 
            Position=1
        )]
        [Alias('occurence_id')]
        [string]$OccurrenceId,

        [Parameter(
            Mandatory = $True,    
            ValueFromPipelineByPropertyName = $True, 
            Position=2
        )]
        [ValidateSet('approve', 'cancel', 'deny')]
        [string]$Action,

        [Parameter(
            ValueFromPipelineByPropertyName = $True, 
            Position=3
        )]
        [hashtable[]]$Registrants
     )

    process {
        $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/meetings/$MeetingId/registrants/status"
        $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)

        if ($PSBoundParameters.ContainsKey('OcurrenceId')) {
            $query.Add('occurrence_id', $OcurrenceId)
            $Request.Query = $query.toString()
        }
        
        $requestBody = @{
            'action' = $Action
        }

        if ($PSBoundParameters.ContainsKey('registrants')) {
            $requestBody.Add('registrants', ($Registrants))
        }

        $requestBody = $requestBody | ConvertTo-Json

        $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $requestBody -Method PUT
        
        Write-Output $response
    }
}