$Users = Invoke-PSUScript -Name 'GetUsers.ps1' -Wait

$UsersLeft = $Users
foreach($SecretSanta in $Users)
{
    $AssignedUser = $UsersLeft | Where-Object Name -NE $SecretSanta.Name | Get-Random
    $UsersLeft = $UsersLeft | Where-Object Name -NE $AssignedUser.Name
    $SecretSanta.AssignedUser = $AssignedUser.Name
    Set-PSUCache -Key "Users_$($SecretSanta.Name)" -Value $SecretSanta -Persist
}