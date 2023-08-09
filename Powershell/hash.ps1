$nonce=Get-Random
$byteArray=[System.Text.Encoding]::UTF8.GetBytes($nonce.ToString())
$stream=[System.IO.MemoryStream]::new($byteArray)
Get-FileHash -InputSream $stream -Algorithm md5 | ForEach-Object {$_.Hash.Substring(0,25)}