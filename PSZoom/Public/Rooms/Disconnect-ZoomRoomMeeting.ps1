<#

.SYNOPSIS
Join a meeting from the Zoom Rooms Client if the meeting number is available. Start an instant meeting if the 
meeting number is empty.

.DESCRIPTION
Join a meeting from the Zoom Rooms Client if the meeting number is available. Start an instant meeting if the 
meeting number is empty.

.PARAMETER RoomId
The ID of the room that is leaving the meeting.

.PARAMETER JsonRPC
A string specifying the version of the JSON-RPC protocol. Default is 2.0.

.OUTPUTS
JSON object that looks like:
{
  "jsonrpc": "2.0",
  "result": {
    "room_id": "63UtYMhSQZaBRPCNRXrD8A",
    "send_at": "2017-09-15T01:26:05Z"
  },
  "id": "49cf01a4-517e-4a49-b4d6-07237c38b749"
}
.LINK
https://marketplace.zoom.us/docs/guides/zoom-rooms/zoom-rooms-api

.EXAMPLE
Disconnect-ZoomRoomMeeting dEaS6ZJZTOCBKL1oeyc9rA

.EXAMPLE
Disconnect-ZoomRoomMeeting -RoomId dEaS6ZJZTOCBKL1oeyc9rA

#>

function Disconnect-ZoomRoomMeeting {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True, 
            ValueFromPipeline = $True, 
            ValueFromPipelineByPropertyName = $True,
            Position = 0
        )]
        [Alias('zr_id', 'roomids')]
        [string[]]$RoomId,

        [string]$JsonRPC = '2.0',

        [string]$Method = 'leave'
     )

    process {
        foreach ($id in $RoomId) {
            $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/rooms/$id/meetings"  

            $requestBody = @{
                'jsonrpc' = $JsonRpc
                'method'  = $Method
            }
            
            $requestBody = ConvertTo-Json $requestBody -Depth 2
            $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $RequestBody -Method POST
    
            Write-Output $response
        }
    }
}
