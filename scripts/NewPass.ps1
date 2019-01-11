param ( 
  $string
  ,$salt = 'murphy'
  ,$init = 'majorruby'
  ,$stringName
)

Import-Module C:\Source\Passkeeper\Passkeeper.psd1 -force #-verbose

Set-PassEncryptedPassword -StringName $stringName -String $String -Salt $salt -Init $init

Get-PassEncryptedPassword -StringName $stringName

