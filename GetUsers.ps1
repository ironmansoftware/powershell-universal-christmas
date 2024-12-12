param($Name)

if ($Name)
{
    Get-PSUCache -Key "Users_$Name"
}
else 
{
    Get-PSUCache -List | Where-Object Key -Match 'Users_' | ForEach-Object {
        Get-PSUCache -Key $_.Key
    }
}

