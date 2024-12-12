$Theme = @{
    palette = @{
        primary = @{
            main = '#1f6037'
        }
    }
}

$Pages = @(
    Get-UDPage -Name 'User'
    Get-UDPage -Name 'Admin'
)

New-UDApp -Pages $Pages -Theme $Theme -Title 'Holiday Secret Santa' -Logo "/custom-images/logo.png"