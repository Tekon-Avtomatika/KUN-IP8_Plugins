# Demo2
Пример плагина отображающего окно настроек и выводящего сообщение в лог КУН

Где:
- plugin2 - папка плагина
  - service.lua - основной файл плагина
  - config.lua - файл конфигурации, отображаемый во в
- plugin2.tar.gz - упакованный плагин 

Данный плагин может быть добавлен в конфигурацию КУН-IP8(4) и будет отображен во вкладке плагины с именем *plugin2*.

![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/Demo2/plugin2_1.PNG)

Плагин выполняет раз в 10 секунд добавление строки в лог КУН-IP доступный по адресу http://192.168.1.100/cgi-bin/log.cgi

```
Sep 20 10:46:55 cun-ng systemd[1]: Created slice system-luaext.slice.
Sep 20 10:46:55 cun-ng systemd[1]: Starting CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin2/service.lua...
Sep 20 10:46:55 cun-ng systemd[1]: Started CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin2/service.lua.
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service START
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service STEP
Sep 20 10:47:05 cun-ng sh[581]: Plugin2 service STEP
...
```