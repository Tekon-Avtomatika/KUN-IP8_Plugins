# Demo2
Пример плагина отображающего окно настроек и выводящего сообщение в лог КУН

Где:
- plugin2 - папка плагина
  - service.lua - основной файл плагина
  - config.lua - подготовка данных для страницы настройки плагина
- plugin2.tar.gz - упакованный плагин 

После добавления в конфигурацию КУН-IP8(4), плагин будет отображен во вкладке плагины с именем *plugin2*.

![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/Demo2/plugin2_1.PNG)

Вкладка настройки плагина отобразит данные из файла config.lua

![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/Demo2/plugin2_2.PNG)

После включения, плагин раз в 10 секунд добавляет строку в лог КУН-IP

```
Sep 20 10:46:55 cun-ng systemd[1]: Created slice system-luaext.slice.
Sep 20 10:46:55 cun-ng systemd[1]: Starting CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin2/service.lua...
Sep 20 10:46:55 cun-ng systemd[1]: Started CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin2/service.lua.
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service START
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service STEP
Sep 20 10:47:05 cun-ng sh[581]: Plugin2 service STEP
...
```