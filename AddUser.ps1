param(
    $Name
)

Set-PSUCache -Key "Users_$Name" -Value ([PSCustomObject]@{
    Name = $Name
    Url = "http://localhost:5000/gift-list/secret-santa/$Name"
    Visited = $false
    AssignedUser = ""
    WishList = ""
}) -Persist