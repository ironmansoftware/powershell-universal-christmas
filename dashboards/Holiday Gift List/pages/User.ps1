New-UDPage -Url "/secret-santa/:name" -Name "User" -Content {
    New-UDTypography -Text "Happy Holidays, $($Name)!" -Variant h3

    New-UDTabs -Tabs {
        New-UDTab -Text 'Wish List' -Content {
            New-UDAlert -Text "Create a wish list for your secret santa to pick from!"

            New-UDForm -Children {
                New-UDTextbox -Id 'WishListItem' -Placeholder 'Item'
            } -OnSubmit {
                Show-UDToast $EventData.WishListItem
                Invoke-PSUScript -Name 'AddToWishList.ps1' -Wait -Parameters @{
                    Name = $Name 
                    Item = $EventData.WishListItem
                }
                Sync-UDElement -Id 'WishList'
            }

            New-UDDynamic -Id 'WishList' -Content {
                $SecretSanta = Invoke-PSUScript -Name 'GetUsers.ps1' -Parameters @{
                    Name = $Name
                } -Wait

                New-UDList -Children {
                    $SecretSanta.WishList -split ',' | ForEach-Object {
                        New-UDListItem -Label $_
                    }
                } 
            }
        }
        New-UDTab -Text 'Secret Santa' -Content {
            $SecretSanta = Invoke-PSUScript -Name 'GetUsers.ps1' -Parameters @{
                Name = $Name
            } -Wait

            $AssignedUser = Invoke-PSUScript -Name 'GetUsers.ps1' -Parameters @{
                Name = $SecretSanta.AssignedUser
            } -Wait
            New-UDAlert -Text "Your secret santa is $($AssignedUser.Name). Below is their wish list!"
            New-UDList -Children {
                $AssignedUser.WishList -split ',' | ForEach-Object {
                    New-UDListItem -Label $_
                }
            }
        }
    }
} -Title "Secret Santa" -Icon @{
    type = 'icon'
}