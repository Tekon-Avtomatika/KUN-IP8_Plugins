# Demo3
Пример плагина, отображаемое имя которого в окне плагины - отличается от имени файла плагина

Где:
- plugin3 - папка плагина
  - service.lua - основной файл плагина
  - config.lua - подготовка данных для страницы настройки плагина
  - name.txt - файл, содержащий имя плагина, которое будет отображаться в окне плагины
- plugin3.tar.gz - упакованный плагин 

После добавления в конфигурацию КУН-IP8(4), плагин будет отображен во вкладке плагины с именем *Сервисный плагин Н293*.

![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/Demo3/plugin3_1.PNG)

Следует отметить, что сам плагин в системе будет идентифицироваться, как  *plugin3*

После включения, плагин добавляет строку  "Plugin3 service START" в лог КУН-IP.

Поскольку в плагине не реализован цикл обработки, то КУН-IP будет постоянно перезапускать плагин.

В логе КУН-IP будет отображаться 

```
...
Sep 20 10:45:36 cun-ng sh[415]: Plugin3 service START
Sep 20 10:45:36 cun-ng systemd[1]: luaext@-etc-luaext.d-plugin3-service.lua.service: Succeeded.
Sep 20 10:45:37 cun-ng systemd[1]: luaext@-etc-luaext.d-plugin3-service.lua.service: Scheduled restart job, restart counter is at 1.
Sep 20 10:45:37 cun-ng systemd[1]: Stopped CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua.
Sep 20 10:45:37 cun-ng systemd[1]: Starting CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua...
Sep 20 10:45:37 cun-ng systemd[1]: Started CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua.
Sep 20 10:45:37 cun-ng sh[427]: Plugin3 service START
Sep 20 10:45:37 cun-ng systemd[1]: luaext@-etc-luaext.d-plugin3-service.lua.service: Succeeded.
Sep 20 10:45:38 cun-ng systemd[1]: luaext@-etc-luaext.d-plugin3-service.lua.service: Scheduled restart job, restart counter is at 2.
Sep 20 10:45:38 cun-ng systemd[1]: Stopped CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua.
Sep 20 10:45:38 cun-ng systemd[1]: Starting CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua...
Sep 20 10:45:38 cun-ng systemd[1]: Started CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin3/service.lua.
Sep 20 10:45:38 cun-ng sh[431]: Plugin3 service START
...
```