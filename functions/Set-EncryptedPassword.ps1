function Set-EncryptedPassword() { 
  param(
     $StringName
    ,$String
    ,$Salt
    ,$Init
    ,$SqlInstance = 'localhost'
    ,$DatabaseName = 'Mitch'
  )

  $database = Connect-SqlDatabase -SqlInstance $SqlInstance -databasename $DatabaseName

  $sql = "INSERT dbo.Passcode (PasscodeName, Salt, Init, EncryptedString) VALUES ('{0}', '{1}', '{2}', '{3}')"

  $string = Get-PassEncryptedString -String $string -Salt $salt -Init $init

  $insert = $sql -f $StringName, $salt, $Init, $string

  $database.ExecuteNonQuery($insert)

}
