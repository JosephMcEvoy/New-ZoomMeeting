<#

.SYNOPSIS
Update a user on your account.

.PARAMETER UserId
The user ID or email address.

.PARAMETER HostVideo 
Start meetings with host video on.

.PARAMETER ParticipantsVideo
Start meetings with participants video on.

.PARAMETER AudioType
Determine how participants can join the audio portion of the meeting.
both - Telephony and VoIP.
telephony - Audio PSTN telephony only.
voip - VoIP only.
thirdParty - Third party audio conference.

.PARAMETER JoinBeforeHost 
Join the meeting before host arrives.

.PARAMETER ForcePmiJbhPassword 
Require a password for personal meetings if attendees can join before host.

.PARAMETER PstnPasswordProtected 
Generate and require password for participants joining by phone.

.PARAMETER

.PARAMETER UsePmiForScheduledMeetings 
Use Personal Meeting ID (PMI) when scheduling a meeting.

.PARAMETER UsePmiForInstantMeetings 
Use Personal Meeting ID (PMI) when starting an instant meeting.

.PARAMETER RequirePasswordForSchedulingNewMeetings
Require a passcode for meetings which have already been scheduled.

.PARAMETER RequirePasswordForScheduledMeetings
"Passcode for already scheduled meetings."

.PARAMETER RequirePasswordForInstantMeetings
Require a passcode for instant meetings. If you use PMI for your instant meetings, this option will be disabled. 
This setting is always enabled for free accounts and Pro accounts with a single host and cannot be modified for 
these accounts.

.PARAMETER RequirePasswordForPmiMeetings
Require a passcode for Personal Meeting ID (PMI). This setting is always enabled for free accounts and Pro accounts 
with a single host and cannot be modified for these accounts.

.PARAMETER EmbedPasswordInJoinLink
If the value is set to `true`, the meeting passcode will be encrypted and included in the join meeting link to allow 
participants to join with just one click without having to enter the passcode.

.PARAMETER MeetingPasswordRequirement
Account wide meeting/webinar passcode requirements. Read more about the object properties in the API documentation.

.PARAMETER E2eEncryption 
End-to-end encryption required for all meetings.

.PARAMETER Chat            
Enable chat during meeting for all participants.

.PARAMETER PrivateChat            
Enable 11 private chat between participants during meetings.

.PARAMETER AutoSavingChat        
Auto save all in-meeting chats.

.PARAMETER EntryExitChim
Play sound when participants join or leave
host - When host joins or leaves.
all - When any participant joins or leaves.
none - No join or leave sound.

.PARAMETER RecordPlayVoice 
Record and play their own voice.

.PARAMETER FileTransfer  
Enable file transfer through in-meeting chat.

.PARAMETER Feedback  
Enable option to send feedback to Zoom at the end of the meeting.

.PARAMETER CoHost  
Allow the host to add co-hosts.

.PARAMETER Polling  
Add polls to the meeting controls.

.PARAMETER AttendeeOnHold  
Allow host to put attendee on hold.

.PARAMETER Annotation  
Allow participants to use annotation tools.

.PARAMETER RemoteControl  
Enable remote control during screensharing.

.PARAMETER NonVerbalFeedback  
Enable non-verbal feedback through screens.

.PARAMETER BreakoutRoom  
Allow host to split meeting participants into separate breakout rooms.

.PARAMETER RemoteSupport  
Allow host to provide 11 remote support to a participant.

.PARAMETER ClosedCaption  
Enable closed captions.

.PARAMETER GroupHd  
Enable group HD video.

.PARAMETER VirtualBackground  
Enable virtual background.

.PARAMETER FarEndCameraControl  
Allow another user to take control of the camera.

.PARAMETER AttentionTracking  
Allow host to see if a participant does not have Zoom in focus during screen sharing.

.PARAMETER WaitingRoom  
Enable Waiting room - if enabled, attendees can only join after host approves.

.PARAMETER AllowLiveStreaming 
Allow live streaming.

.PARAMETER WorkplaceByFacebook 
Allow livestreaming by host through Workplace by Facebook.

.PARAMETER CustomLiveStreaming 
Allow custom live streaming.

.PARAMETER CustomServiceInstructions 

Custom service instructions.
.PARAMETER JbhReminder  
When attendees join meeting before host.

.PARAMETER CancelMeetingReminder  
When a meeting is cancelled.

.PARAMETER AlternativeHostReminder  

When an alternative host is set or removed from a meeting.

.PARAMETER ScheduleForReminder  
Notify the host there is a meeting is scheduled, rescheduled, or cancelled.

.PARAMETER LocalRecording 
Local recording.

.PARAMETER CloudRecording  
Cloud recording.

.PARAMETER RecordSpeakerView  
Record the active speaker view.

.PARAMETER RecordGalleryView  
Record the gallery view.

.PARAMETER RecordAudioFile  
Record an audio only file.

.PARAMETER SaveChatText  
Save chat text from the meeting.

.PARAMETER ShowTimestamp  
Show timestamp on video.

.PARAMETER RecordingAudioTranscript 
Audio transcript.

.PARAMETER AutoRecording
Automatic recording.
local - Record on local.
cloud - Record on cloud.
none - Disabled.

.PARAMETER HostPauseStopRecording  
Host can pause/stop the auto recording in the cloud.

.PARAMETER AutoDeleteCmr  
Auto delete cloud recordings.

.PARAMETER AutoDeleteCmrDays 
A specified number of days of auto delete cloud recordings.

.PARAMETER RecordingDisclaimer
Show a disclaimer to participants before a recording starts.

.PARAMETER AskParticipantsToConsentDisclaimer
This field can be used if `recording_disclaimer` is set to true. 
This field indicates whether or not you would like to ask participants for consent when a recording starts. 
The value can be one of the following:
true: Ask participants for consent when a recording starts.
false: Do not ask participants for consent when a recording starts.

.PARAMETER AskHostToConfirmDisclaimer
Ask host to confirm the disclaimer.

.PARAMETER RecordingPasswordRequirement
This object represents the minimum passcode requirements set for recordings via Account Recording Settings. 
Read more about the object properties in the API documentation.

.PARAMETER ThirdPartyAudio 
Third party audio conference.

.PARAMETER AudioConferenceInfo
Third party audio conference info.

.PARAMETER ShowInternationalNumbersLink 
Show the international numbers link on the invitation email.

.PARAMETER MeetingCapacity 
User's meeting capacity.

.PARAMETER LargeMeeting 
Large meeting feature.

.PARAMETER LargeMeetingCapacity 
Large meeting capacity can be 500 or 1000, depending on the user has a large meeting capacity plan subscription or not.

.PARAMETER Webinar 
Webinar feature.

.PARAMETER WebinarCapacity 
Webinar capacity can be 100, 500, 1000, 3000, 5000 or 10000, depending on if the user has a webinar capacity plan subscription or not.

.PARAMETER ZoomPhone 
Zoom phone feature.

.PARAMETER RevenueAccelerator 
Zoom phone feature.

.PARAMETER CallOut 
Call Out.

.PARAMETER CallOutCountries 
Call Out Countries/Regions. 

.PARAMETER ShowInternationalNumbersLinkTsp
Show international numbers link on the invitation email in Tsp.

.OUTPUTS
No output. Can use Passthru switch to pass the UserId as an output.

.LINK
https://marketplace.zoom.us/docs/api-reference/zoom-api/users/usersettingsupdate

.EXAMPLE
Update-ZoomUserSettings -UserId 'dvader@thesith.com' -JoinBeforeHost $True

.EXAMPLE
'r2d2@rebels.com','c3po@rebels.com' | Update-ZoomUserSettings -hostvideo $True

#>

function Update-ZoomUserSettings {    
    [CmdletBinding()]
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
            HelpMessage = 'Start meetings with host video on.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('host_video')]
        [bool]$HostVideo, 
            
        [Parameter(
            HelpMessage = 'Start meetings with participants video on.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('participants_video')]
        [bool]$ParticipantsVideo, 
    
        [Parameter(
            HelpMessage = 'Determine how participants can join the audio portion of the meeting<br>`both` - Telephony and VoIP.<br>`telephony` - Audio PSTN telephony only.<br>`voip` - VoIP only.<br>`thirdParty` - Third party audio conference.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('both', 'telephony', 'voip', 'thirdparty')]
        [Alias('audio_type')]
        [string]$AudioType, 

        [Parameter(
            HelpMessage = 'Join the meeting before host arrives.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('join_before_host')]
        [bool]$JoinBeforeHost, 
            
        [Parameter(
            HelpMessage = 'Require a password for personal meetings if attendees can join before host.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('force_pmi_jbh_password')]
        [bool]$ForcePmiJbhPassword, 
            
        [Parameter(
            HelpMessage = 'Generate and require password for participants joining by phone.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('pstn_password_protected')]
        [bool]$PstnPasswordProtected, 
            
        [Parameter(
            HelpMessage = 'Use Personal Meeting ID (PMI) when scheduling a meeting.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('use_pmi_for_scheduled_meetings')]
        [bool]$UsePmiForScheduledMeetings, 
            
        [Parameter(
            HelpMessage = 'Use Personal Meeting ID (PMI) when starting an instant meeting.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('use_pmi_for_instant_meetings')]
        [bool]$UsePmiForInstantMeetings, 

        [Parameter(
            HelpMessage = 'Require a passcode for instant meetings. If you use PMI for your isntant meetings, this option will be disabled. This setting is always enabled for free accounts and Pro accounts with a single host and cannot be mofidied for these accounts.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('require_password_for_scheduling_new_meetings')]
        [bool]$RequirePasswordForSchedulingNewMeetings, 

        [Parameter(
            HelpMessage = 'Require a passcode for meetings which have already been scheduled.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('require_password_for_scheduled_meetings')]
        [bool]$RequirePasswordForScheduledMeetings, 

        [Parameter(
            HelpMessage = 'Require a passcode for Personal Meeting ID (PMI). This setting is always enabled for free accounts and Pro accounts with a isngle host and cannot be modified for these accounts.',
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('jbh_only', 'all', 'none')]
        [Alias('require_password_for_pmi_meetings')]
        [string]$RequirePasswordForPMIMeetings, 

        [Parameter(
            HelpMessage = 'Require a passcode for instant meetings. If you use PMI for your instant meetings, this option will be disabled. This setting is always enabled for free accounts and Pro accounts with a single host and cannot be modified for these accounts.',
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('require_password_for_instant_meetings')]
        [bool]$RequirePasswordForInstantMeetings, 

        [Parameter(
            HelpMessage = 'PMI passcode.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('pmi_passcode', 'PMIpasscode')]
        [string]$PMIPassword, 

        [Parameter(
            HelpMessage = 'Require a passcode for Personal Meeting ID (PMI). This setting is always enabled for free accounts and Pro accounts with a single host and cannot be modified for these accounts.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('embed_password_in_join_link')]
        [bool]$EmbedPasswordInJoinLink, 

        # Meeting Password Requirement Object
        [Parameter(
            HelpMessage = 'Account wide meeting/webinar password settings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('meeting_password_requirement')]
        [object]$MeetingPasswordRequirement, 

        # inMeeting 
        [Parameter(
            HelpMessage = 'End-to-end encryption required for all meetings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('e2e_encryption')]
        [bool]$E2eEncryption, 
            
        [Parameter(
            HelpMessage = 'Enable chat during meeting for all participants.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [bool]$Chat,           

        [Parameter(
            HelpMessage = 'Enable 11 private chat between participants during meetings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('private_chat')]
        [bool]$PrivateChat,           

        [Parameter(
            HelpMessage = 'Auto save all in-meeting chats.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('auto_saving_chat')]
        [bool]$AutoSavingChat,       

        [Parameter(
            HelpMessage = 'Play sound when participants join or leave<br>`host` - When host joins or leaves.<br>`all` - When any participant joins or leaves.<br>`none` - No join or leave sound.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('host', 'all', 'none')]
        [Alias('entry_exit_chime')]
        [string]$EntryExitChime, 

        [Parameter(
            HelpMessage = 'Record and play their own voice.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('record_play_voice')]
        [bool]$RecordPlayVoice, 

        [Parameter(
            HelpMessage = 'Enable file transfer through in-meeting chat.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('file_transfer')]
        [bool]$FileTransfer, 

        [Parameter(
            HelpMessage = 'Enable option to send feedback to Zoom at the end of the meeting.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [bool]$Feedback, 

        [Parameter(
            HelpMessage = 'Allow the host to add co-hosts.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('co_host ')]
        [bool]$CoHost, 

        [Parameter(
            HelpMessage = 'Add polls to the meeting controls.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [bool]$Polling, 

        [Parameter(
            HelpMessage = 'Allow host to put attendee on hold.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('attendee_on_hold')]
        [bool]$AttendeeOnHold, 

        [Parameter(
            HelpMessage = 'Allow participants to use annotation tools.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [bool]$Annotation, 

        [Parameter(
            HelpMessage = 'Enable remote control during screensharing.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('remote_control')]
        [bool]$RemoteControl, 

        [Parameter(
            HelpMessage = 'Enable non-verbal feedback through screens.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('non_verbal_feedback ')]
        [bool]$NonVerbalFeedback, 

        [Parameter(
            HelpMessage = 'Allow host to split meeting participants into separate breakout rooms.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('breakout_room')]
        [bool]$BreakoutRoom, 

        [Parameter(
            HelpMessage = 'Allow host to provide 11 remote support to a participant.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('remote_support')]
        [bool]$RemoteSupport, 

        [Parameter(
            HelpMessage = 'Enable closed captions.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('closed_caption')]
        [bool]$ClosedCaption, 

        [Parameter(
            HelpMessage = 'Enable group HD video.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('group_hd')]
        [bool]$GroupHd, 

        [Parameter(
            HelpMessage = 'Enable virtual background.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('virtual_background')]
        [bool]$VirtualBackground, 

        [Parameter(
            HelpMessage = 'Allow another user to take control of the camera.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('far_end_camera_control')]
        [bool]$FarEndCameraControl, 

        [Parameter(
            HelpMessage = 'Share dual camera (deprecated).', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('share_dual_camera')]
        [bool]$ShareDualCamera, 

        [Parameter(
            HelpMessage = 'Allow host to see if a participant does not have Zoom in focus during screen sharing.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('attention_tracking')]
        [bool]$AttentionTracking, 

        [Parameter(
            HelpMessage = 'Enable Waiting room - if enabled, attendees can only join after host approves.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('waiting_room ')]
        [bool]$WaitingRoom, 

        [Parameter(
            HelpMessage = 'Allow live streaming.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('allow_live_streaming')]
        [bool]$AllowLiveStreaming, 

        [Parameter(
            HelpMessage = 'Allow livestreaming by host through Workplace by Facebook.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('workplace_by_facebook')]
        [bool]$WorkplaceByFacebook, 

        [Parameter(
            HelpMessage = 'Allow custom live streaming.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('custom_live_streaming')]
        [bool]$CustomLiveStreaming, 

        [Parameter(
            HelpMessage = 'Custom service instructions.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('custom_service_instructions')]
        [string]$CustomServiceInstructions, 

        # emailNotification
        [Parameter(
            HelpMessage = 'When attendees join meeting before host.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('jbh_reminder')]
        [bool]$JbhReminder, 

        [Parameter(
            HelpMessage = 'When a meeting is cancelled.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('cancel_meeting_reminder')]
        [bool]$CancelMeetingReminder, 

        [Parameter(
            HelpMessage = 'When an alternative host is set or removed from a meeting.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('alternative_host_reminder')]
        [bool]$AlternativeHostReminder, 
            
        [Parameter(
            HelpMessage = 'Notify the host there is a meeting is scheduled, rescheduled, or cancelled.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('schedule_for_reminder')]
        [bool]$ScheduleForReminder, 
        
        
        # recording
        [Parameter(
            HelpMessage = 'Local recording.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('local_recording')]
        [bool]$LocalRecording, 

        [Parameter(
            HelpMessage = 'Cloud recording.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('cloud_recording')]
        [bool]$CloudRecording, 

        [Parameter(
            HelpMessage = 'Record the active speaker view.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('record_speaker_view')]
        [bool]$RecordSpeakerView, 

        [Parameter(
            HelpMessage = 'Record the gallery view.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('record_gallery_view')]
        [bool]$RecordGalleryView, 

        [Parameter(
            HelpMessage = 'Record an audio only file.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('record_audio_file')]
        [bool]$RecordAudioFile, 

        [Parameter(
            HelpMessage = 'Save chat text from the meeting.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('save_chat_text')]
        [bool]$SaveChatText, 

        [Parameter(
            HelpMessage = 'Show timestamp on video.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('show_timestamp')]
        [bool]$ShowTimestamp, 

        [Parameter(
            HelpMessage = 'Audio transcript.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('recording_audio_transcript')]
        [bool]$recordingAudioTranscript, 

        [Parameter(
            HelpMessage = 'Automatic recording<br>`local` - Record on local.<br>`cloud` - Record on cloud.<br>`none` - Disabled.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateSet('local', 'cloud', 'none')]
        [Alias('auto_recording ')]
        [string]$AutoRecording, 

        [Parameter(
            HelpMessage = 'Host can pause/stop the auto recording in the cloud.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('host_pause_stop_recording')]
        [bool]$HostPauseStopRecording, 

        [Parameter(
            HelpMessage = 'Auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('auto_delete_cmr')]
        [bool]$AutoDeleteCmr, 
        
        [Parameter(
            HelpMessage = 'A specified number of days of auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateRange(0,60)]
        [Alias('auto_delete_cmr_days')]
        [int]$AutoDeleteCmrDays, 

        [Parameter(
            HelpMessage = 'A specified number of days of auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('recording_disclaimer')]
        [bool]$RecordingDisclaimer,

        [Parameter(
            HelpMessage = 'A specified number of days of auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('ask_participants_to_consent_disclaimer')]
        [bool]$AskParticipantsToConsentDisclaimer,

        [Parameter(
            HelpMessage = 'A specified number of days of auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('ask_host_to_confirm_disclaimer')]
        [bool]$AskHostToConfirmDisclaimer,

        [Parameter(
            HelpMessage = 'A specified number of days of auto delete cloud recordings.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('recording_password_requirement')]
        [object]$RecordingPasswordRequirement,


        # telephony
        [Parameter(
            HelpMessage = 'Third party audio conference.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('third_party_audio')]
        [bool]$ThirdPartyAudio, 

        [Parameter(
            HelpMessage = 'Third party audio conference info.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [ValidateLength(0, 2048)]
        [Alias('audio_conference_info ')]
        [string]$AudioConferenceInfo, 

        # feature
        [Parameter(
            HelpMessage = "User's meeting capacity.", 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('meeting_capacity')]
        [int]$MeetingCapacity, 

        [Parameter(
            HelpMessage = 'Large meeting feature.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('large_meeting')]
        [bool]$LargeMeeting, 

        [Parameter(
            HelpMessage = 'Large meeting capacity can be 500 or 1000, depending on the user has a large meeting capacity plan subscription or not.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('large_meeting_capacity')]
        [int]$LargeMeetingCapacity, 

        [Parameter(HelpMessage = 'Webinar feature.')]
        [bool]$Webinar, 

        [Parameter(
            HelpMessage = 'Webinar capacity can be 100, 500, 1000, 3000, 5000 or 10000, depending on if the user has a webinar capacity plan subscription or not.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('webinar_capacity')]
        [int]$WebinarCapacity, 

        [Parameter(
            HelpMessage = 'Zoom phone feature.', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('zoom_phone')]
        [bool]$ZoomPhone, 

        [Alias('zoom_revenue_accelerator')]
        [Alias('ZRA')]
        [bool]$RevenueAccelerator, 


        # tsp
        [Parameter(
            HelpMessage = 'Call Out', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('call_out')]
        [bool]$CallOut, 

        [Parameter(
            HelpMessage = 'Call Out Countries/Regions', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('call_out_countries')]
        [string[]]$CallOutCountries, 

        [Parameter(
            HelpMessage = 'Show international numbers link on the invitation email', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('feature_show_international_numbers_link')]
        [bool]$ShowInternationalNumbersLink,

        [Parameter(
            HelpMessage = 'Show international numbers link on the invitation email for TSP', 
            ValueFromPipelineByPropertyName = $True
        )]
        [Alias('feature_show_international_numbers_link_tsp')]
        [bool]$ShowInternationalNumbersLinkTsp,

        [switch]$PassThru
    )

    process {
        foreach ($user in $UserId) {
            $request = [System.UriBuilder]"https://api.$ZoomURI/v2/users/$user/settings"

            $scheduleMeeting = @{
                'host_video'                                  = 'HostVideo'
                'participants_video'                          = 'ParticipantsVideo'
                'audio_type'                                  = 'AudioType'
                'join_before_host'                            = 'JoinBeforeHost'
                'force_pmi_jbh_password'                      = 'ForcePmiJbhPassword'
                'pstn_password_protected'                     = 'PstnPasswordProtected'
                'use_pmi_for_scheduled_meetings'              = 'UsePmiForScheduledMeetings'
                'use_pmi_for_instant_meetings'                = 'UsePmiForInstantMeetings'
                'require_password_for_scheduling_newmeetings' = 'RequirePasswordForSchedulingNewMeetings'
                'require_password_for_scheduled_meetings'     = 'RequirePasswordForScheduledMeetings'
                'require_password_for_instant_meetings'       = 'RequirePasswordForInstantMeetings'
                'require_password_for_pmi_meetings'           = 'RequirePasswordForPmiMeetings'
                'embed_password_in_join_link'                 = 'EmbedPasswordInJoinLink'
            }

            $inMeeting = @{    
                'e2e_encryption'              = 'E2eEncryption'
                'chat'                        = 'Chat' 
                'private_chat'                = 'PrivateChat' 
                'auto_saving_chat'            = 'AutoSavingChat' 
                'entry_exit_chim'             = 'EntryExitChim' 
                'record_play_voice'           = 'RecordPlayVoice'
                'file_transfer'               = 'FileTransfer' 
                'feedback'                    = 'Feedback' 
                'co_host'                     = 'CoHost' 
                'polling'                     = 'Polling' 
                'attendee_on_hold'            = 'AttendeeOnHold' 
                'annotation'                  = 'Annotation' 
                'remote_control'              = 'RemoteControl' 
                'non_verbal_feedback'         = 'NonVerbalFeedback' 
                'breakout_room'               = 'BreakoutRoom' 
                'remote_support'              = 'RemoteSupport' 
                'closed_caption'              = 'ClosedCaption' 
                'group_hd'                    = 'GroupHd' 
                'virtual_background'          = 'VirtualBackground' 
                'far_end_camera_control '     = 'FarEndCameraControl' 
                'share_dual_camera'           = 'ShareDualCamera' 
                'attention_tracking'          = 'AttentionTracking' 
                'waiting_room'                = 'WaitingRoom' 
                'allow_live_streaming'        = 'AllowLiveStreaming'
                'workplace_by_facebook'       = 'WorkplaceByFacebook'
                'custom_live_streaming'       = 'CustomLiveStreaming'
                'custom_service_instructions' = 'CustomServiceInstructions'
            }

            $emailNotification = @{    
                'jbh_reminder'              = 'bhReminder' 
                'cancel_meeting_reminder'   = 'ancelMeetingReminder'
                'alternative_host_reminder' = 'lternativeHostReminder'
                'schedule_for_reminder'     = 'cheduleForReminder'
            }
                
            $recording = @{    
                'local_recording'                        = 'LocalRecording'
                'cloud_recording'                        = 'CloudRecording'
                'record_speaker_view'                    = 'RecordSpeakerView'
                'record_gallery_view'                    = 'RecordGalleryView'
                'record_audio_file'                      = 'RecordAudioFile'
                'save_chat_text'                         = 'SaveChatText'
                'show_timestamp'                         = 'ShowTimestamp'
                'recording_audio_transcript'             = 'RecordingAudioTranscript'
                'auto_recording'                         = 'AutoRecording'
                'host_pause_stop_recording '             = 'HostPauseStopRecording'
                'auto_delete_cmr'                        = 'AutoDeleteCmr'
                'auto_delete_cmr_days'                   = 'AutoDeleteCmrDay'
                'recording_disclaimer'                   = 'RecordingDisclaimer'
                'ask_participants_to_consent_disclaimer' = 'AskParticipantsToConsentDisclaimer'
                'ask_host_to_confirm_disclaimer'         = 'AskHostToCOnfirmDisclaimer'
                'recording_password_requirement'         = 'RecordingPasswordRequirement'
            }

            $telephony = @{    
                'third_party_audio '              = 'ThirdPartyAudio'
                'audio_conference_info'           = 'AudioConferenceInfo'
                'show_international_numbers_link' = 'ShowInternationalNumbersLink'
            }

            $feature = @{    
                'meeting_capacity'       = 'MeetingCapacity'
                'large_meeting'          = 'LargeMeeting'
                'large_meeting_capacity' = 'LargeMeetingCapacity'
                'webinar'                = 'Webinar'
                'webinar_capacity'       = 'WebinarCapacity'
                'zoom_phone'             = 'ZoomPhone'
                'zoom_revenue_accelerator'             = 'RevenueAccelerator'

            }

            $tsp = @{
                'call_out'                            = 'CallOut'
                'call_out_countries'                  = 'CallOutCountries'
                'show_international_numbers_link_tsp' = 'ShowInternationalNumbersLinkTsp'
            }

            function Remove-NonPSBoundParameters {
                param (
                    $Obj,
                    $Parameters = $PSBoundParameters
                )

                process {
                    $newObj = @{}
            
                    foreach ($key in $Obj.keys) {
                        if ($Parameters.ContainsKey($Obj.$key)){
                            $newobj.Add($key, (get-variable $Obj.$key).value)
                        }
                    }
            
                    return $newObj
                }
            }
            
            $scheduleMeeting = Remove-NonPSBoundParameters($scheduleMeeting)
            $inMeeting = Remove-NonPSBoundParameters($inMeeting)
            $emailNotification = Remove-NonPSBoundParameters($emailNotification)
            $recording = Remove-NonPSBoundParameters($recording)
            $telephony = Remove-NonPSBoundParameters($telephony)
            $feature = Remove-NonPSBoundParameters($feature)
            $tsp = Remove-NonPSBoundParameters($tsp)

            $allObjects = @{
                'schedule_meeting'     = $scheduleMeeting
                'in_meeting'           = $inMeeting
                'email_notification'   = $emailNotification
                'recording'            = $recording
                'telephony'            = $telephony
                'feature'              = $feature
                'tsp'                  = $tsp
            }

            $requestBody = @{}
        
            foreach ($Key in $allObjects.Keys) {
                if ($allObjects.$Key.Count -gt 0) {
                    $requestBody.Add($Key, $allObjects.$Key)
                }
            }

            $requestBody = $requestBody | ConvertTo-Json

            if ($pscmdlet.ShouldProcess) {
                $response = Invoke-ZoomRestMethod -Uri $request.Uri -Body $requestBody -Method PATCH

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
