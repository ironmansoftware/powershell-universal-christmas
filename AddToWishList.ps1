param($Name, $Item)

$SecretSanta = Invoke-PSUScript 'GetUsers.ps1' -Parameters @{
    Name = $Name
} -Wait

[array]$array = if ($SecretSanta.WishList -eq "") { @() } else { $SecretSanta.WishList -split "," }
$array += $Item
$SecretSanta.WishList = $array -join ','

Write-Information $SecretSanta.WishList

Set-PSUCache -Key "Users_$Name" -Value $SecretSanta -Persist