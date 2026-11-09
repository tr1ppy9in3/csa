# Основная информация (Get-CimInstance Win32_Processor | Format-List Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed)
Name                      : 11th Gen Intel(R) Core(TM) i9-11900KF @ 3.50GHz
NumberOfCores             : 8
NumberOfLogicalProcessors : 16
MaxClockSpeed             : 3504

# Кэш процессора (Get-CimInstance Win32_CacheMemory | Select-Object Purpose, InstalledSize, Level, CacheType)

Purpose  InstalledSize Level CacheType
-------  ------------- ----- ---------
L1 Cache           384     3         4 (L1d)
L1 Cache           256     3         3 (L1i)
L2 Cache          4096     4         5
L3 Cache         16384     5         5

# Результат Python
Архитектура: AMD64
Логических ядер: 16
