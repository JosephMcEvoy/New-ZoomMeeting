<#

.SYNOPSIS
Create a meeting for a user.

.DESCRIPTION
Create a meeting for a user. The expiration time for the start_url object is two hours. For API users, the expiration time is 90 days.

.PARAMETER UserId
The user ID or email address.

.PARAMETER ScheduleFor
Email or userId if you want to schedule meeting for another user.

.PARAMETER Topic
Meeting topic.

.PARAMETER StartTime
Meeting start time. When using a format like \"yyyy-MM-dd'T'HH:mm:ss'Z'\", always use GMT time. When using a format like \"yyyy-MM-dd'T'HH:mm:ss\", 
you should use local time and specify the time zone. This is only used for scheduled meetings and recurring meetings with a fixed time.

.PARAMETER Duration
Meeting duration (minutes). Used for scheduled meetings only.

.PARAMETER Timezone
Time zone to format start_time. For example, \"America/Los_Angeles\". For scheduled meetings only. 
Please reference our [time zone](https://marketplace.zoom.us/docs/api-reference/other-references/abbreviation-lists#timezones) list for supported time zones and their formats.

.PARAMETER Password
Password to join the meeting. Password may only contain the following characters: [a-z A-Z 0-9 @ - _ *]. Max of 10 characters.

.PARAMETER Agenda
Meeting description.

.PARAMETER TrackingFields
Tracking fields. An array of objects where each object contains two keys (field, value). Example: @(@{field = value, value = value}, @{field = value, value = value})

.PARAMETER Recurrence
Recurrence object. Pass an entire recurrence object directly. Cannot be used with other recurrence parameters.

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
Select how many timse the meeting will recur before it is canceled. (Cannot be used with "EndDateTime".)

.PARAMETER EndDateTime
Select a date the meeting will recur before it is canceled. Should be in UTC time, such as 2017-11-25T12:00:00Z. (Cannot be used with "EndTimes".)

.PARAMETER Settings
Meeting settings object. Pass an entire settings object directly.

.PARAMETER HostVideo
Start video when the host joins the meeting.

.PARAMETER ParticipantVideo
Start video when participants join the meeting.

.PARAMETER CNMeeting
Host meeting in China.

.PARAMETER INMeeting
Host meeting in India.

.PARAMETER JoinBeforeHost
Allow participants to join the meeting before the host starts the meeting. Only used for scheduled or recurring meetings.

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
RegisterForEachOccurence' - Attendees need to register for each occurrence to attend.(2)
RegisterOnceAndChooseOccurences' - Attendees register once and can choose one or more occurrences to attend.(3)

.PARAMETER Audio
Determine how participants can join the audio portion of the meeting.<br>`both` - Both Telephony and VoIP.<br>`telephony` - Telephony only.<br>`voip` - VoIP only.

.PARAMETER AutoRecording
Automatic recording:
local - Record on local.
cloud -  Record on cloud.
none - Disabled.
.PARAMETER EnforceLogin
Only signed in users can join this meeting. This parameter is deprecated and will not be supported in the future. 
As an alternative, use the "MeetingAuthentication", "AuthenticationOption" and "AuthenticationDomains" parameters.

.PARAMETER EnforceLoginDomains
Only signed in users with specified domains can join meetings. This parameter is deprecated and will not be supported in the future. 
As an alternative, use the "MeetingAuthentication", "AuthenticationOption" and "AuthenticationDomains" parameters.

.PARAMETER AlternativeHosts
Alternative host's emails or IDs: multiple values separated by a comma.

.PARAMETER CloseRegistration
Close registration after event date

.PARAMETER WaitingRoom
Enable waiting room

.PARAMETER GlobalDialInCountries
List of global dial-in countries

.PARAMETER ContactName
Contact name for registration

.PARAMETER ContacEmail
Contact email for registration

.PARAMETER MeetingAuthentication
Only authenticatd users can join meetings.

.PARAMETER AuthenticationOption
Meeting authentication option id.

.PARAMETER AuthenticationDomains
If user has configured "Sign into Zoom with Specified Domains" option, this will list the doamins that are authenticated.

.PARAMETER AuthenticationName
Authentication name set in the authentication profile.

.LINK
https://github.com/JosephMcEvoy/New-ZoomMeeting

.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/meetings/meetingcreate

.LINK
https://marketplace.zoom.us/docs/api-reference/introduction

.EXAMPLE
Start an instant meeting.
New-ZoomMeeting -Topic 'Test Topic' -UserId 'testuserid@company.com'

.EXAMPLE
Schedule a meeting. 
New-ZoomMeeting -Topic 'Test Topic' -UserId $UserId -StartTime '2019-10-18T15:00:00Z' -Duration 60

.EXAMPLE
Start an instant meeting with some custom settings.
Note: Objects are not necessary. "Splatting" was only used to make it easier to read.

$mandatoryParams = @{    
    Topic  = 'Test Topic'
    UserId = $UserId
}

$optionalparams = @{
    Schedulefor = 'TestUser@Company.com'
    Timezone    = 'Timezone'
    Password    = 'TestPassword'
    Agenda      = 'TestAgenda'
}

$settingsparams = @{
    Alternativehosts      = 'alternativehosttest@company.com'
    Approvaltype          = 'automatic'
    Audio                 = 'both'
    Autorecording         = 'local'
    Closeregistration     = $True
    Cnmeeting             = $True
    Registrationtype      = 'RegisterOnceAndAttendAll'
}

New-ZoomMeeting @mandatoryParams @optionalparams @settingsparams

.EXAMPLE
Schedule a daily repeating meeting. 
New-ZoomMeeting`
-Topic 'Test Topic'`
-UserId 'testuser@company.com'`
-StartTime '2019-10-18T15:00:00Z'`
-Duration 60`
-EndTimes 2`
-Daily`
-RepeatInterval 1`

.EXAMPLE
Schedule a weekly repeating meeting that repeats every Sunday, Monday and Tuesday of every other week.

    $mandatoryParams = @{    
        Topic  = 'Test Topic'
        UserId = $UserId
    }

    $scheduleParams = @{
        StartTime = '2019-10-18T15:00:00Z'
        Duration = 60
    }

    $params = @{
        WeeklyDays = 'Sunday', 'Monday', 'Tuesday'
        EndDateTime = '2019-11-25T12:00:00Z'
        RepeatInterval = 2
    }
  
    New-ZoomMeeting @params @mandatoryParams @scheduleParams

.EXAMPLE
Schedule a meeting that repeats on the same day each month.

    $mandatoryParams = @{    
        Topic  = 'Test Topic'
        UserId = $UserId
    }

    $scheduleParams = @{
        StartTime = '2019-10-18T15:00:00Z'
        Duration = 60
    }

    $params = @{
        MonthlyDay = 28
        EndDateTime = '2019-11-25T12:00:00Z'
    }
  
    New-ZoomMeeting @params @mandatoryParams @scheduleParams

.EXAMPLE
Schedule a monthly meeting that repeats every second Tuesday of every other month.

New-ZoomMeeting @params @mandatoryParams @scheduleParams -Topic 'Test Topic' -UserId $UserId`
-StartTime '2019-10-18T15:00:00Z' -Duration 60 -MonthlyWeek 'SecondWeek'`
-MonthlyWeekDay 'Tuesday' -EndDateTime '2019-11-25T12:00:00Z' -RepeatInterval 2
  
#>

function New-ZoomMeeting {
    [CmdletBinding(DefaultParameterSetName = "Instant")]
    param (
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'Instant', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'ScheduledMeeting', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceNoFixedTime', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('user_id', 'id')]
        [string]$UserId,
  
        [Parameter(
            ParameterSetName = 'Instant', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'ScheduledMeeting', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceNoFixedTime', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('schedule_for')]
        [string]$ScheduleFor,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'Instant', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'ScheduledMeeting', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceNoFixedTime', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [string]$Topic,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'ScheduledMeeting', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('start_time')]
        [string]$StartTime,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'ScheduledMeeting'
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay'
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek'
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay'
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek'
        )]
        [int]$Duration,

        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceNoFixedTime', 
            ValueFromPipelineByPropertyName = $True
        )]
        [switch]$RecurrenceNoFixedTime,
  
        [string]$Timezone,
  
        [ValidatePattern("[A-Za-z0-9@\-_\*]{1,10}")] #Letters, numbers, '@', '-', '_', '*' from 1 to 10 chars
        [string]$Password,
  
        [string]$Agenda,
  
        [Alias('tracking_fields')]
        [hashtable[]]$TrackingFields,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateRange(1, 90)]
        [Alias('recurrence_repeat_interval', 'repeat_interval')]
        [int]$RepeatInterval,

        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [switch]$Daily,

        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 1, 2, 3, 4, 5, 6, 7)]
        [Alias('recurrence_weekly_days', 'weekly_days', 'recurrenceweeklydays')]
        [string[]]$WeeklyDays,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateRange(1, 31)]
        [Alias('recurrence_monthly_day', 'monthly_day', 'recurrencemonthlyday')]
        [int]$MonthlyDay,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('LastWeek', 'FirstWeek', 'SecondWeek', 'ThirdWeek', 'FourthWeek', -1, 1, 2, 3, 4)]
        [Alias('recurrence_monthly_week', 'monthly_week')]
        $MonthlyWeek,
  
        [Parameter(
            Mandatory = $True, 
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 1, 2, 3, 4, 5, 6, 7)]
        [Alias('recurrence_monthly_weekday')]
        $MonthlyWeekDay,
  
        [Parameter(
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateRange(1, 50)]
        [Alias('recurrence_end_times', 'end_times', 'endafter')]
        [int]$EndTimes,
      
        [Parameter(
            ParameterSetName = 'RecurrenceByDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthDay', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Parameter(
            ParameterSetName = 'RecurrenceByMonthWeek', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('recurrence_end_datetime', 'end_date_time', 'endafterdatetime')]
        [string]$EndDateTime,

        #Settings
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('host_video')]
        [bool]$HostVideo,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('participant_video')]
        [bool]$ParticipantVideo,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('cn_meeting')]
        [bool]$CNMeeting = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('in_meeting')]
        [bool]$INMeeting = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('join_before_host')]
        [bool]$JoinBeforeHost = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('mute_before_entry')]
        [bool]$MuteUponEntry = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [bool]$Watermark = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('use_pmi')]
        [bool]$UsePMI = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('Automatic', 'Manual', 'None', 0, 1, 2)]
        [Alias('approval_type')]
        $ApprovalType = 'None',
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('RegisterOnceAndAttendAll', 'RegisterForEachOccurence', 'RegisterOnceAndChooseOccurences', 0, 1, 2)]
        [Alias('registration_type')]
        $RegistrationType = 'RegisterOnceAndAttendAll',
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('both', 'telephony', 'voip')]
        [string]$Audio,
  
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [ValidateSet('local', 'cloud', 'none')]
        [Alias('auto_recording')]
        [string]$AutoRecording = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('enforce_login')]
        [bool]$EnforceLogin,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('enforce_login_domains')]
        [string]$EnforceLoginDomains,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('alternative_hosts')]
        [string]$AlternativeHosts,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('close_registration')]
        [bool]$CloseRegistration = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('waiting_room')]
        [bool]$WaitingRoom = $false,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('global_dialin_countries')]
        [string[]]$GlobalDialInCountries,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('contact_name')]
        [string]$ContactName,
      
        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('contact_email')]
        [string]$ContactEmail,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('registrants_email_notification')]
        [bool]$RegistrantsEmailNotification,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('meeting_authentication')]
        [bool]$MeetingAuthentication,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('authentication_option')]
        [string]$AuthenticationOption,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('authentication_domains')]
        [string]$AuthenticationDomains,

        [Parameter(ValueFromPipelineByPropertyName = $True)]
        [Alias('authentication_name')]
        [string]$AuthenticationName
    )
    
    begin {
        $Uri = "https://api.$ZoomURI/v2/users/$userId/meetings"
    }
    
    process {
        $Type = switch ($PSCmdlet.ParameterSetName) {
            'Instant'               { 1 }
            'ScheduledMeeting'      { 2 }
            'RecurrenceNoFixedTime' { 3 }
            'RecurrenceByDay'       { 8 }
            'RecurrenceByWeek'      { 8 }
            'RecurrenceByMonthDay'  { 8 }
            'RecurrenceByMonthWeek' { 8 }
        }
    
        #The following parameters are added by default as they are requierd by all parameter sets so they are automatically added to the request body
        $requestBody = @{
            'topic'      = $Topic
            'type'       = $Type
        }
  
        function Remove-NonPsBoundParameters {
            <#This function looks at the values of the keys passed to it then determines if they were passed in the process scope.
            Only the parameters that were passed that match the value names are outputted.#>
            param (
                $Obj,
                $Parameters = $PSBoundParameters
            )
  
            process {
                $NewObj = @{ }
      
                foreach ($Key in $Obj.Keys) {
                    if ($Parameters.ContainsKey($Obj.$Key)) {
                        $Newobj.Add($Key, (get-variable $Obj.$Key).value)
                    }
                }
      
                return $NewObj
            }
        }
  
        #These are optional meeting parameters for all parameter sets.
        $OptionalParameters = @{
            'schedule_for'    = 'ScheduleFor'
            'timezone'        = 'Timezone'
            'password'        = 'Password'
            'agenda'          = 'Agenda'
            'tracking_fields' = 'TrackingFields'
        }
  
        $OptionalParameters = Remove-NonPsBoundParameters($OptionalParameters)
  
        $OptionalParameters.Keys | ForEach-Object {
            $requestBody.Add($_, $OptionalParameters.$_)
        }
  
        ##### Scheduled Meetings Begin #####
        #These parameters are added by default for all scheudle type parameter sets.
        if (('ScheduledMeeting', 'RecurrenceByDay', 'RecurrenceByWeek', 'RecurrenceByMonthDay', 'RecurrenceByMonthWeek').Contains($PSCmdlet.ParameterSetName)) {
            $requestBody.Add('start_time', $StartTime)
            $requestBody.Add('duration', $Duration)
        }
        
        #This is for recurrence parameter sets.
        if (('RecurrenceByDay', 'RecurrenceByWeek', 'RecurrenceByMonthDay', 'RecurrenceByMonthWeek').Contains($PSCmdlet.ParameterSetName)) {    
            $Recurrence = @{}

            $RecurrenceType = switch ($PSCmdlet.ParameterSetName) {
                'RecurrenceByDay'       { 1 }
                'RecurrenceByWeek'      { 2 }
                'RecurrenceByMonthDay'  { 3 }
                'RecurrenceByMonthWeek' { 3 }
            }

            #Per Zoom API Reference, repeat interval by month has a maximum of 3 and by week has a maximum of 12.
            if ($PSCmdlet.ParameterSetName -eq 'RecurrenceByMonthDay' -or $PSCmdlet.ParameterSetName -eq 'RecurrenceByMonthWeek' ) {
                if ($RepeatInterval -gt 3) {
                    Throw 'Recurrences by month have a max value of 3.'
                }
            } elseif ($PSCmdlet.ParameterSetName -eq 'RecurrenceByWeek') {
                if ($RepeatInterval -gt 12) {
                    Throw 'Recurrences by week have a max value of 12.'
                }
            }
            
            if ($PSBoundParameters.ContainsKey('WeeklyDays')) {
                $WeeklyDays | ForEach-Object {
                    #Loops through each day and changes it because this parameter is an array
                    $WeeklyDays[$WeeklyDays.IndexOf($_)] = switch ($_) {
                        'Sunday'    { 1 }
                        'Monday'    { 2 }
                        'Tuesday'   { 3 }
                        'Wednesday' { 4 }
                        'Thursday'  { 5 }
                        'Friday'    { 6 }
                        'Saturday'  { 7 }
                    }
                }
            }

            if ($PSBoundParameters.ContainsKey('MonthlyWeek')) {
                $MonthlyWeek = switch ($MonthlyWeek) {
                    'LastWeek'   { -1 }
                    'FirstWeek'  { 1 }
                    'SecondWeek' { 2 }
                    'ThirdWeek'  { 3 }
                    'FourthWeek' { 4 }
                }
            }

            if ($PSBoundParameters.ContainsKey('MonthlyWeekDay')) {
                $MonthlyWeekDay = switch ($MonthlyWeekDay) {
                    'Sunday'    { 1 }
                    'Monday'    { 2 }
                    'Tuesday'   { 3 }
                    'Wednesday' { 4 }
                    'Thursday'  { 5 }
                    'Friday'    { 6 }
                    'Saturday'  { 7 }
                }
            }
            
            #Default values for recurrence
            $Recurrence = @{
                'type'            = $RecurrenceType
                'repeat_interval' = $RepeatInterval   
            }

            #Sets $EndTimes to 1 if no value is provided for $EndTimes or $EndDateTime. This is in line with Zoom's documentaiton which declares a default value for EndTimes.
            if ($PSBoundParameters.ContainsKey('EndTimes')) {
                $Recurrence.Add('end_times', $EndTimes)
            } elseif ($PSBoundParameters.ContainsKey('EndDateTime')) {
                $Recurrence.Add('end_date_time', $EndDateTime)
            } else {
                $EndTimes = 1
                $Recurrence.Add('end_times', $EndTimes)
            }

            #These values are mandatory depending on parameter set used
            #For some reason, Zoom requires this to be a string of integers separated by a comma, instead of an array.
            if ($PSBoundParameters.ContainsKey('WeeklyDays')){
                $Recurrence.Add('weekly_days', (ConvertTo-StringWithCommas($WeeklyDays)))
            }

            $RecurrenceSettings = @{
                'monthly_day'     = 'MonthlyDay'
                'monthly_week'    = 'MonthlyWeek'
                'monthly_weekday' = 'MonthlyWeekDay'
            }

            $RecurrenceSettings = Remove-NonPsBoundParameters($RecurrenceSettings)
    
            $RecurrenceSettings.Keys | ForEach-Object {
                $Recurrence.Add($_, $RecurrenceSettings.$_)
            }
            $requestBody.Add('recurrence', $Recurrence)
        }
        ##### Scheduled Meetings End #####
  
        #### Misc Settings Start #####  
        if ($PSBoundParameters.ContainsKey('ApprovalType')) {
            $ApprovalType = switch ($ApprovalType) {
                'Automatic' { 0 }
                'Manual'    { 1 }
                'None'      { 2 }
                Default     { 2 }
            }
        }
  
        if ($PSBoundParameters.ContainsKey('RegistrationType')) {
            $RegistrationType = switch ($RegistrationType) {
                'RegisterOnceAndAttendAll'        { 1 }
                'RegisterForEachOccurence'        { 2 }
                'RegisterOnceAndChooseOccurences' { 3 }
            }
        }
  
        $Settings = @{
            'alternative_hosts'              = 'AlternativeHosts'
            'approval_type'                  = 'ApprovalType'
            'audio'                          = 'Audio'
            'auto_recording'                 = 'AutoRecording'
            'close_registration'             = 'CloseRegistration'
            'cn_meeting'                     = 'CNMeeting'
            'contact_email'                  = 'ContacEmail'
            'contact_name'                   = 'ContactName'
            'enforce_login'                  = 'Enfogin'
            'enforce_login_domains'          = 'EnforceLoginDomains'
            'global_dialin_countries'        = 'GlobalDialInCountries'
            'host_video'                     = 'HostVideo'
            'participant_video'              = 'ParticipantVideo'
            'in_meeting'                     = 'INMeeting'
            'join_before_host'               = 'JoinBeforeHost'
            'mute_upon_entry'                = 'MuteUponEntry'
            'registration_type'              = 'RegistrationType'
            'use_pmi'                        = 'UsePMI'
            'waiting_room'                   = 'WaitingRoom'
            'watermark'                      = 'Watermark'
            'meeting_authentication'         = 'MeetingAuthentication'
            'registrants_email_notification' = 'RegistrantsEmailNotification'
            'authentication_option'          = 'AuthenticationOption' 
            'authentication_domains'         = 'AuthenticationDomains'
            'authentication_name'            = 'AuthenticationName'   
        }
  
        #Adds additional setting parameters to Settings object.
        $Settings = Remove-NonPsBoundParameters($Settings)
  
        if ($Settings.Keys.Count -gt 0) {
            $requestBody.Add('settings', $Settings)
        }
  
        #### Misc Settings End #####

        $requestBody = ConvertTo-Json $requestBody -Depth 10
        $response = Invoke-ZoomRestMethod -Uri $Uri -Body $requestBody -Method Post

        Write-Output $response
    }
}
