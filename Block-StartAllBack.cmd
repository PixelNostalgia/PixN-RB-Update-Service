netsh advfirewall firewall add rule name="DarkMagicLoaderX64-OUT" dir=OUT action=block program="C:\Program Files\StartAllBack\DarkMagicLoaderX64.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="DarkMagicLoaderX86-OUT" dir=OUT action=block program="C:\Program Files\StartAllBack\DarkMagicLoaderX86.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="StartAllBackCfg-OUT" dir=OUT action=block program="C:\Program Files\StartAllBack\StartAllBackCfg.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="UpdateCheck-OUT" dir=OUT action=block program="C:\Program Files\StartAllBack\UpdateCheck.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="DarkMagicLoaderX64-IN" dir=IN action=block program="C:\Program Files\StartAllBack\DarkMagicLoaderX64.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="DarkMagicLoaderX86-IN" dir=IN action=block program="C:\Program Files\StartAllBack\DarkMagicLoaderX86.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="StartAllBackCfg-IN" dir=IN action=block program="C:\Program Files\StartAllBack\StartAllBackCfg.exe" enable=yes profile=domain,private,public
netsh advfirewall firewall add rule name="UpdateCheck-IN" dir=IN action=block program="C:\Program Files\StartAllBack\UpdateCheck.exe" enable=yes profile=domain,private,public

pause
