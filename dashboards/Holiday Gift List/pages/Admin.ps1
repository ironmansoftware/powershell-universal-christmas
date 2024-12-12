New-UDPage -Url "/admin" -Name "Admin" -Content {
    New-UDTabs -Tabs {
        New-UDTab -Text 'Users' -Content {
            New-UDButton -Text 'Randomize Secret Santas' -OnClick {
                Invoke-PSUScript -Name 'AssignSecretSantas.ps1' -Wait -Silent 
                Sync-UDElement -Id 'Users'
            } -Icon (New-UDIcon -Icon 'Shuffle') -ShowLoading

            New-UDDynamic -Id 'Users' -Content {
                $Users = Invoke-PSUScript -Name 'GetUsers.ps1' -Wait -Silent
                New-UDTable -Columns @(
                    New-UDTableColumn -Property 'Name' -Title 'Name'
                    New-UDTableColumn -Property 'URL' -Title 'URL' -OnRender {
                        New-UDLink -Url $EventData.Url -Text $EventData.Url
                    }
                    New-UDTableColumn -Property 'Visisted' -Title 'Visisted' -OnRender {
                        if ($EventData.Visisted) {
                            New-UDIcon -Icon 'CheckCircle' -Color 'green'
                        }
                        else {
                            New-UDIcon -Icon 'Times' -Color 'red'
                        }
                    }
                    New-UDTableColumn -Property 'AssignedUser' -Title 'Assigned User' 
                    New-UDTableColumn -Property 'Actions' -Title 'Actions' -OnRender {
                        New-UDButton -Icon (New-UDIcon -Icon 'Trash') -OnClick {
                            Invoke-PSUScript -Name 'RemoveUser.ps1' -Paramerers @{
                                UserName = $EventData.Name
                            }
                        }
                    }
                ) -Data $Users
            } -LoadingComponent {
                New-UDProgress -Circular
            }
        }
        New-UDTab -Text 'Add User' -Content {
            New-UDForm -Script 'AddUser.ps1'
        }
    }
} -Icon @{
    type = 'icon'
}