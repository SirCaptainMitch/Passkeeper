function Get-EncryptedString() { 
  param ( 
      [string]$String,
      [string]$salt="SaltCrypto", 
      [string]$init="PassKeeper", 
      [switch]$arrayOutput, 
      [string]$Passphrase
  )

  # https://gallery.technet.microsoft.com/PowerShell-Script-410ef9df
  $r = New-Object System.Security.Cryptography.RijndaelManaged

  if (!$Passphrase) {  
    $Passphrase = Read-Host "Enter a Passphrase"
  }

  [byte[]]$pass = [Text.Encoding]::UTF8.GetBytes($Passphrase) 
  [byte[]]$salt = [Text.Encoding]::UTF8.GetBytes($salt) 

  $r.Key = (New-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 5).GetBytes(32) 
  $r.IV = (New-Object Security.Cryptography.SHA1Managed).ComputeHash( [Text.Encoding]::UTF8.GetBytes($init) )[0..15] 
  $c = $r.CreateEncryptor() 
  $ms = New-Object IO.MemoryStream 
  $cs = New-Object Security.Cryptography.CryptoStream $ms,$c,"Write" 
  $sw = New-Object IO.StreamWriter $cs 
  $sw.Write($String) 
  $sw.Close() 
  $cs.Close() 
  $ms.Close() 
  $r.Clear() 
  [byte[]]$result = $ms.ToArray()

  return [Convert]::ToBase64String($result)
} 