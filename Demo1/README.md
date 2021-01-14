# Demo1
Пример минимального плагина.

Где:
- plugin1 - папка плагина
  - service.lua  - файл плагина (пустой)
- plugin1.tar.gz - упакованный плагин 

Данный плагин может быть добавлен в конфигурацию КУН-IP8(4) и будет отображен во вкладке плагины с именем *plugin1*.

Плагин не выполняет никаких действий (поскольку файл service.lua - пустой)

Факт запуска плагина отображается в лог КУН-IP доступном по адресу http://IP-адрес/cgi-bin/log.cgi

```
Sep 20 10:44:09 cun-ng systemd[1]: Starting CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin1/service.lua...
```