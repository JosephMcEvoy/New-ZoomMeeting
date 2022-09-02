<#

.DESCRIPTION
This script takes an ADGroup, then compares the email addresses in the group against Zoom. Then it adds/removes users in order 
to "sync" the ADGroup with Zoom.
Any users in the AD Group who are not in Zoom are CREATED in Zoom if the -Add switch is specified.
Any users in Zoom who are not in the AD Group are REMOVED from Zoom if the -Remove switch as specified.

.PARAMETER AdGroup
The name of the AdGroup that Zoom syncs with.

.PARAMETER UserExceptions
Users to ignore from Zoom and/or Active Directory.

.PARAMETER TransferAccount
Specifies the account to transfer meetings to. This is automatically added to UserExceptions.

.PARAMETER Add
Any users in the AD Group who are not in Zoom are CREATED in Zoom if the -Add switch is specified.

.PARAMETER Remove
Any users in Zoom who are not in the AD Group are REMOVED from Zoom if the -Remove switch as specified.

.EXAMPLE
$UserExceptions = @(
    'DVader@deathstar.com', #Don't mess with Vader's account under any circumstances.
    'AVAdmin@deathstar.com' #Or the AV admin
)

$AdGroups = 'ZoomUsers'
$TransferAccount = 'AVAdmin@deathstar.com'

Sync-ZoomUsersWithAdGroup -AdGroups $AdGroups -UserExceptions $UserExceptions -TransferAccount $TransferAccount -Confirm -Verbose

#>

#requires -modules activedirectory, pszoom

function Sync-ZoomUsersWithAdGroup() {
    param(
        [CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact='High')]

        [Parameter(Mandatory = $True)]
        [ValidateScript({
                if (get-adgroup -identity $_) {
                    return $True
                } else {
                    return $False
                }
        })]
        [Alias("AdGroup")]
        [string[]]$AdGroups,
        
        [string[]]$UserExceptions = @(),

        [string]$TransferAccount,

        [switch]$Add = $False,

        [switch]$Remove = $False
    )
    begin {
        if ($TransferAccount) {
            $UserExceptions += $TransferAccount, "" #Adds transfer account to exceptions
        }
    }

    process {
            foreach ($AdGroup in $AdGroups) {
                #Compare the $ADGroup with the full list of Zoom users.
                Write-Verbose "Finding AD Group $AdGroup members."

                $AdGroupMembers = (Get-ADGroup $AdGroup -Properties Member | Select-Object -ExpandProperty Member | Get-ADUser -Property EmailAddress | Select-Object EmailAddress)

                $AdGroupMembers = $AdGroupMembers | Foreach-Object { 
                    return [PSCustomObject]@{
                        EmailAddress = "$($_.EmailAddress)"
                    }
                } | Where-Object EmailAddress -NotIn $UserExceptions

                Write-Verbose "Found $($AdGroupMembers.EmailAdress.count) users in $AdGroup (exceptions excluded)."
                Write-Verbose 'Finding active and inactive Zoom users.'

                $ZoomUsers = (Get-ZoomUsers -status active -allpages) + (Get-Zoomusers -status inactive -allpages)

                $ZoomUsers = $ZoomUsers | ForEach-Object {
                    return [PSCustomObject]@{
                        EmailAddress = "$($_.email)"
                    }
                } | Where-Object EmailAddress -NotIn $UserExceptions
                
                Write-Verbose "Found $($ZoomUsers.EmailAddress.count) Zoom users (exceptions excluded)."

                $AdZoomDiff = Compare-Object -ReferenceObject $AdGroupMembers -DifferenceObject $ZoomUsers -Property EmailAddress |  Where-Object EmailAddress -ne ""

                Write-Verbose "Compared $AdGroup against Zoom users."

                if ($AdZoomDiff.count -eq 0) {
                    Write-Verbose 'Zoom and ADGroup are in sync. No changes made.'
                    exit 0
                }

                Write-Verbose "Found the following users are not in sync: `n $($AdZoomDiff | ForEach-Object {"$($_.EmailAddress, $_.SideIndicator)`n"})"

                $AdDiff = $AdZoomDiff | Where-Object -Property SideIndicator -eq '<=' | Select-Object -Property 'EmailAddress'

                #Add users to Zoom that are in the $AdGroup and not in $UserExceptions.
                if ($Add) {
                    Write-Verbose "Adding missing users that are in $AdGroup to Zoom. Skipping users in UserExceptions."

                    if ($PScmdlet.ShouldProcess("$AdDiff", 'Add')) {
                        $AdDiff | ForEach-Object {
                            Write-Verbose "Adding user $_.EmailAddress to Zoom."
                            try {
                                New-CompanyZoomUser -AdAccount $_.EmailAddress.split('@')[0] @params
                            } catch {
                                Write-Error -Message "Unable to add user $($_.EmailAddress). $($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
                            }
                        }
                    }
                }
                
                #This can be potentially dangerous. You should be testing before deploying this.
                #Remove Zoom users who are in Zoom but are not in the $AdGroup and not in $UserExceptions.
                if ($Remove) {
                    Write-Verbose "Removing users from Zoom that are not in $AdGroup. Skipping users in UserExceptions."

                    $ZoomDiff = $AdZoomDiff | Where-Object -Property SideIndicator -eq '=>' | Select-Object -Property 'EmailAddress'

                    if ($PScmdlet.ShouldProcess("$($ZoomDiff.EmailAddress)", 'Remove')) {
                        $ZoomDiff | ForEach-Object {
                            Write-Verbose "Removing user $_.EmailAddress from Zoom."
                            try {
                                Remove-ZoomUser -UserId $_.EmailAddress -TransferEmail $TransferEmail -TransferMeeting $True -TransferWebinar $True -TransferRecording $True @params
                            } catch {
                                Write-Error -Message "Unable to remove user $($_.EmailAddress). $($_.Exception.Message)" -ErrorId $_.Exception.Code -Category InvalidOperation
                            }
                        }
                    }
                }

                Write-Output $AdDiff
        }
    }

    end {}
    
}