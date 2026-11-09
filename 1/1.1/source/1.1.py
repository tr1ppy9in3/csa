import os, platform;

print("Архитектура:", platform.machine())
print("Логических ядер:", os.cpu_count())
