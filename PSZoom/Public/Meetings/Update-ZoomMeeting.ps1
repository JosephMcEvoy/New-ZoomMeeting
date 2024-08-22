<#

.SYNOPSIS
Update the details of a meeting.
.DESCRIPTION
Update the details of a meeting.
This API has a rate limit of 100 requests per day. Therefore, a meeting can only be updated for a maximum of 100 
times within a 24 hour window.
.PARAMETER MeetingId
The meeting ID.
.PARAMETER OccurrenceId
Meeting Occurrence id. Support change of agenda, start_time, duration, settings: {host_video, participant_video, 
join_before_host, mute_upon_entry, waiting_room, auto_recording}
.PARAMETER ScheduleFor
Email or userid if you want to schedule meeting for another user.
.PARAMETER Topic
Meeting topic.
.PARAMETER Type
Meeting type. 
Instant meeting (1)
Scheduled meeting (2)
Recurring meeting with no fixed time (3)
Recurring meeting with fixed time. (8)
.PARAMETER StartTime
Meeting start time. When using a format like "yyyy-MM-dd'T'HH:mm:ss'Z'", always use GMT time. When using a format 
like "yyyy-MM-dd'T'HH:mm:ss", you should use local time and specify the time zone. This is only used for scheduled 
meetings and recurring meetings with a fixed time.
.PARAMETER Duration
Meeting duration (minutes). Used for scheduled meetings only.
.PARAMETER Timezone
Time zone to format start_time. For example, \"America/Los_Angeles\". For scheduled meetings only. 
Please reference our [time zone](https://marketplace.zoom.us/docs/api-reference/other-references/abbreviation-lists#timezones) 
list for supported time zones and their formats.
.PARAMETER Password
Password to join the meeting. Password may only contain the following characters: [a-z A-Z 0-9 @ - _ *]. 
Max of 10 characters.
.PARAMETER Agenda
Meeting description.
.PARAMETER RecurrenceType
Recurrence meeting types: 
Daily (1)
Weekly (2)
Monthly (3)
.PARAMETER RepeatInterval
At which interval should the meeting repeat? For a daily meeting there's a maximum of 90 days. 
For a weekly meeting there is a maximum of 12 weeks. 
For a monthly meeting there is a maximum of 3 months.
.PARAMETER WeeklyDays
Days of the week the meeting should repeat. Note: Multiple values should be separated by a comma. 
Sunday (1)
Monday (2)
Tuesday (3)
Wednesday (4)
Thursday (5)
Friday (6)
Saturday (7)
.PARAMETER MonthlyDay
Day in the month the meeting is to be scheduled. The value is from 1 to 31.
.PARAMETER MonthlyWeek
The week a meeting will recur each month.
Last week (-1)
First week (1)
Second week (2)
Third week (3)
Fourth week (4)
.PARAMETER MonthlyWeekDay
The weekday a meeting should recur each month.
Sunday (1)
Monday (2)
Tuesday (3)
Wednesday (4)
Thursday (5)
Friday (6)
Saturday (7)
.PARAMETER EndTimes
Select how many timse the meeting will recur before it is canceled. (Cannot be used with "RecurrenceEndDateTime".)
.PARAMETER EndDateTime
Select a date the meeting will recur before it is canceled. Should be in UTC time, such as 2017-11-25T12:00:00Z. 
(Cannot be used with "RecurrenceEndTimes".)
.PARAMETER HostVideo
Start video when the host joins the meeting.
.PARAMETER ParticipantVideo
Start video when participants join the meeting.
.PARAMETER CNMeeting
Host meeting in China.
.PARAMETER INMeeting
Host meeting in India.
.PARAMETER JoinBeforeHost
Allow participants to join the meeting before the host starts the meeting. Only used for scheduled or recurring 
meetings.
.PARAMETER MuteUponEntry
Mute participants upon entry.
.PARAMETER Watermark
Add watermark when viewing a shared screen.
.PARAMETER UsePMI
Use a personal meeting ID. Only used for scheduled meetings and recurring meetings with no fixed time.
.PARAMETER ApprovalType
Automatic - Automatically approve (0)
Manual - Manually approve (1)
None - No registration required (2)
.PARAMETER RegistrationType
Registration type. Used for recurring meeting with fixed time only. 
RegisterOnceAndAttendAll' - Attendees register once and can attend any of the occurrences.(1)
RegisterForEachoccurrence' - Attendees need to register for each occurrence to attend.(2)
RegisterOnceAndChooseoccurrences' - Attendees register once and can choose one or more occurrences to attend.(3)
.PARAMETER Audio
Determine how participants can join the audio portion of the meeting.
`both` - Both Telephony and VoIP
`telephony` - Telephony only
`voip` - VoIP only
.PARAMETER AutoRecording
Automatic recording:
local - Record on local.
cloud -  Record on cloud.
none - Disabled.
.PARAMETER EnforceLogin
Only signed in users can join this meeting. This parameter is deprecated and will not be supported in the future. 
As an alternative, use the "MeetingAuthentication", "AuthenticationOption" and "AuthenticationDomains" parameters.
.PARAMETER EnforceLoginDomains
Only signed in users with specified domains can join meetings. This parameter is deprecated and will not be 
supported in the future. As an alternative, use the "MeetingAuthentication", "AuthenticationOption" and 
"AuthenticationDomains" parameters.
.PARAMETER AlternativeHosts
Alternative host's emails or IDs: multiple values separated by a comma.
.PARAMETER CloseRegistration
Close registration after event date.
.PARAMETER WaitingRoom
Enable waiting room.
.PARAMETER GlobalDialInCountries
List of global dial-in countries.
.PARAMETER GlobalDialInNumbers
List of global dial-in numbers. This is an array of objects. Format:
    [string]'country'      = 'BR'
    [string]'country_name' = 'Brazil
    [string]'city'         = 'Sao Paulo'
    [string]'number'       = '+12332357613'
    [string]'type'         = <Type of number>
.PARAMETER MeetingAuthentication
Only authenticatd users can join meetings.
.PARAMETER AuthenticationOption
Meeting authentication option id.
.PARAMETER AuthenticationDomains
If user has configured "Sign into Zoom with Specified Domains" option, this will list the doamins that are 
authenticated.
.PARAMETER AuthenticationName
Authentication name set in the authentication profile.
.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/meetings/meetingupdate

#>

function Update-ZoomMeeting {
  [CmdletBinding(DefaultParameterSetName="Instant")]
  param (
    [Parameter(
        Mandatory = $True, 
        Position = 0,
        ValueFromPipeline = $True,
        ValueFromPipelineByPropertyName = $True
    )]
    [Alias('meeting_id')]
    [string]$MeetingId,

    [Parameter(
        Position=1,
        ValueFromPipelineByPropertyName = $True
    )]
    [Alias('occurrence_id')]
    [string]$OccurrenceId,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateNotNullOrEmpty()]
    [Alias('schedule_for')]
    [string]$ScheduleFor,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateNotNullOrEmpty()]
    [string]$Topic,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('Instant', 'Scheduled', 'RecurringNoFixedTime', 'RecurringFixedTime', 1, 2, 3, 8)]
    [ValidateNotNullOrEmpty()]
    [string]$Type = 'Scheduled',

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('start_time')]
    [string]$StartTime,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [int]$Duration,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [string]$Timezone,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidatePattern("[A-Za-z0-9@\-_\*]{1,10}")] #Letters, numbers, '@', '-', '_', '*' from 1 to 10 chars
    [string]$Password,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [string]$Agenda,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('tracking_fields')]
    [hashtable[]]$TrackingFields,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('Daily', 'Weekly', 'Monthly', 1, 2, 3)]
    [Alias('recurrence_type')]
    [string]$RecurrenceType,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateRange(1,90)]
    [Alias('recurrence_repeat_interval')]
    [int]$RecurrenceRepeatInterval,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 1, 2, 3, 4, 5, 6, 7)]
    [Alias('weekley_days')]
    [string[]]$WeeklyDays,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateRange(1,31)]
    [Alias('monthly_day')]
    [int]$MonthlyDay,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('LastWeek', 'FirstWeek', 'SecondWeek', 'ThirdWeek', 'FourthWeek')]
    [Alias('monthly_week')]
    [string]$MonthlyWeek,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 1, 2, 3, 4, 5, 6, 7)]
    [Alias('monthly_week_day')]
    [string]$MonthlyWeekDay,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateRange(1,50)]
    [Alias('end_times')]
    [int]$EndTimes,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidatePattern("^(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\\.[0-9]+)?(Z)?$")] 
    #Example: 2016-04-06T10:10:09Z. Regex taken from https://www.regextester.com/94925
    [Alias('end_datetime')]
    [string]$EndDateTime,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('host_video')]
    [bool]$HostVideo,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('participant_video')]
    [bool]$ParticipantVideo,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('cn_meeting')]
    [bool]$CNMeeting,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('in_meeting')]
    [bool]$INMeeting,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('join_before_host')]
    [bool]$JoinBeforeHost,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('mute_upon_entry')]
    [bool]$MuteUponEntry,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [bool]$Watermark,
    
    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('use_pmi')]
    [bool]$UsePMI,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('Automatic', 'Manual', 'None', 0, 1, 2)]
    [Alias('approval_type')]
    [string]$ApprovalType,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('RegisterOnceAndAttendAll', 'RegisterForEachoccurrence', 'RegisterOnceAndChooseoccurrences', 0, 1, 2)]
    [Alias('registration_type')]
    [string]$RegistrationType,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('both', 'telephony', 'voip')]
    [string]$Audio,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [ValidateSet('local','cloud','none')]
    [Alias('auto_recording')]
    [string]$AutoRecording,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('enforc_elogin')]
    [bool]$EnforceLogin,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('enforce_login_domains')]
    [bool]$EnforceLoginDomains,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('alternative_hosts')]
    [string]$AlternativeHosts,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('close_registration')]
    [bool]$CloseRegistration,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('waitin_groom')]
    [bool]$WaitingRoom,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('global_dial_in_countries')]
    [string[]]$GlobalDialInCountries,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('contact_name')]
    [string]$ContactName,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('contact_email')]
    [string]$ContactEmail,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('global_dial_in_numbers')]
    [hashtable[]]$GlobalDialInNumbers,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('Registrants_Email_Notification')]
    [bool]$RegistrantsEmailNotification,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('meeting_authentication')]
    [bool]$MeetingAuthentication,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('authentication_option')]
    [string]$AuthenticationOption,

    [Parameter(ValueFromPipelineByPropertyName = $True)]
    [Alias('authentication_domains')]
    [string]$AuthenticationDomains
  )
    
  process {
    $Request = [System.UriBuilder]"https://api.$ZoomURI/v2/meetings/$MeetingId"

    $requestBody=@{}

    if ($PSBoundParameters.ContainsKey('OccurrenceId')) {
        $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)  
        $query.Add('occurrence_id', $OccurrenceId)
        $Request.Query = $query.ToString()
    }

    if ($PSBoundParameters.ContainsKey('Type')) {
        $Type = switch ($Type) {
            'Instant'              { '1' }
            'Scheduled'            { '2' }
            'RecurringNoFixedTime' { '3' }
            'RecurringFixedTime'   { '8' }
        }
    }

    #These are optional meeting parameters.
    $OptionalParameters = @{
        'schedule_for'    = 'ScheduleFor'
        'topic'           = 'Topic'
        'type'            = 'Type'
        'timezone'        = 'Timezone'
        'password'        = 'Password'
        'agenda'          = 'Agenda'
        'tracking_fields' = 'TrackingFields'
        'start_time'      = 'StartTime'
    }

    function Remove-NonPSBoundParameters {
        param (
            $Obj,
            $Parameters = $PSBoundParameters
        )
    
        process {
            $NewObj = @{}
    
            foreach ($Key in $Obj.Keys) {
                if ($Parameters.ContainsKey($Obj.$Key)){
                    $Newobj.Add($Key, (get-variable $Obj.$Key).value)
                }
            }
    
            return $NewObj
        }
    }
    
    #Removes parameter if not provided in function call.
    $OptionalParameters = Remove-NonPSBoundParameters($OptionalParameters)

    #Adds parameters to requestBody
    foreach ($Key in $OptionalParameters.Keys) {
        if ($OptionalParameters.$Key -gt 0) {
            $requestBody.Add($Key, $OptionalParameters.$Key)
        }
    }

    #Recurrence object
    if ($PSBoundParameters.ContainsKey('RegistrationType')) {
        $RegistrationType = switch ($RegistrationType) {
            'RegisterOnceAndAttendAll'         { '1' }
            'RegisterForEachoccurrence'        { '2' }
            'RegisterOnceAndChooseoccurrences' { '3' }
        }
    }

    if ($PSBoundParameters.ContainsKey('WeeklyDays')) {
        $WeeklyDays | ForEach-Object {
            $WeeklyDays[$WeeklyDays.IndexOf($_)] = switch ($_) { #loops through each day and changes it because this parameter is an array
                'Sunday'    { '1' }
                'Monday'    { '2' }
                'Tuesday'   { '3' }
                'Wednesday' { '4' }
                'Thursday'  { '5' }
                'Friday'    { '6' }
                'Saturday'  { '7' }
            }
        }
    }

    if ($PSBoundParameters.ContainsKey('MonthlyWeek')) {
        $MonthlyWeek = switch ($MonthlyWeek) {
            'LastWeek'   { '-1' }
            'FirstWeek'  { '1' }
            'SecondWeek' { '2' }
            'ThirdWeek'  { '3' }
            'FourthWeek' { '4' }
        }
    }

    if ($PSBoundParameters.ContainsKey('MonthlyWeekDay')) {
        $MonthlyWeekDay = switch ($_) {
            'Sunday'    { '1' }
            'Monday'    { '2' }
            'Tuesday'   { '3' }
            'Wednesday' { '4' }
            'Thursday'  { '5' }
            'Friday'    { '6' }
            'Saturday'  { '7' }
        }
    }

    $Recurrence = @{
        'type'             = 'RecurrenceType'
        'repeat_interval'  = 'RecurrenceRepeatInterval'
        'weekly_days'      = 'WeeklyDays'
        'monthly_day'      = 'MonthlyDay'
        'monthly_week_day' = 'MonthlyWeekDay'
        'end_times'        = 'EndTimes'
        'end_date_time'    = 'EndDateTime'
    }

    $Recurrence = Remove-NonPSBoundParameters($Recurrence)


    #Settings Object
    if ($PSBoundParameters.ContainsKey('ApprovalType')) {
        $ApprovalType = switch ($ApprovalType) {
            'Automatic' { '0' }
            'Manual'    { '1' }
            'None'      { '2' }
            Default     { '2' }
        }
    }

    if ($PSBoundParameters.ContainsKey('RegistrationType')) {
        $RegistrationType = switch ($RegistrationType) {
            'RegisterOnceAndAttendAll' { '1' }
            'RegisterForEachoccurrence' { '2' }
            'RegisterOnceAndChooseoccurrences' { '3' }
        }
    }

    $Settings = @{
        'host_video'              = 'HostVideo'
        'participant_video'       = 'ParticipantVideo'
        'cn_meeting'              = 'CNMeeting'
        'in_meeting'              = 'INMeeting'
        'join_before_host'        = 'JoinBeforeHost'
        'mute_upon_entry'         = 'MuteUponEntry'
        'watermark'               = 'Watermark'
        'use_pmi'                 = 'UsePMI'
        'approval_type'           = 'ApprovalType'
        'registration_type'       = 'RegistrationType'
        'audio'                   = 'Audio'
        'auto_recording'          = 'AutoRecording'
        'enforce_login'           = 'Enfogin'
        'enforce_login_domains'   = 'EnforceLoginDomains'
        'alternative_hosts'       = 'AlternativeHosts'
        'close_registration'      = 'CloseRegistration'
        'waiting_room'            = 'WaitingRoom'
        'global_dialin_countries' = 'GlobalDialInCountries'
        'contact_name'            = 'ContactName'
        'contact_email'           = 'ContacEmail'
        'global_dial_in_numbers'  = 'GlobalDialInNumbers'
        'meeting_authentication'  = 'MeetingAuthentication'
        'authentication_option'   = 'AuthenticationOption' 
        'authentication_domains'  = 'AuthenticationDomains'
        'authentication_name'     = 'AuthenticationName'   
    }

    $Settings = Remove-NonPSBoundParameters($Settings)
        
    $allObjects = @{
        'recurrence' = $Recurrence
        'settings'   = $Settings
    }

    #Add objects to requestBody if not empty.
    foreach ($Key in $allObjects.Keys) {
        if ($allObjects.$Key.Count -gt 0) {
            $requestBody.Add($Key, $allObjects.$Key)
        }
    }

    $requestBody = ConvertTo-Json $requestBody -Depth 10
    $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $requestBody -Method PATCH

    Write-Output $response
  }
}
