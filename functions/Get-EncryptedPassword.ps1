function Get-EncryptedPassword() { 
  param(
     $StringName
    ,$SqlInstance = 'localhost'
    ,$DatabaseName = 'Mitch'
  )

  $database = Connect-SqlDatabase -SqlInstance $SqlInstance -databasename $DatabaseName

  $sql = "SELECT PasscodeName, Salt, Init, EncryptedString 
          FROM dbo.Passcode 
          WHERE PasscodeName = '{0}'"

  $select = $sql -f $StringName

  $results = $database.ExecuteWithResults($select)

  $encryptedString = $($results.tables.rows).EncryptedString
  $salt = $($results.tables.rows).Salt 
  $init = $($results.tables.rows).Init

  $string = Get-PassDecryptedString -Encrypted $encryptedString -Salt $salt -Init $init

  $string  | clip 

}
