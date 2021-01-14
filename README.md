# Плагины КУН-IP8(4)
Рассматривается API создания плагинов для концентраторов КУН-IP8(4).

## Введение
Плагины позволяют расширить функционал концентратора КУН-IP8(4).

Плагин представляет собой скрипт, написанный на языке LUA.

Вы можете написать плагин самостоятельно или обратиться за помошью в тех.поддержку компании [Текон-Автоматика](htts://www.tekon.ru)

В настоящий момент в КУН интегрированы следующие сторонние библиотеки:
- lua-basexx
- lua-binaryheap
- lua-bit32
- lua-cjson
- lua-cqueues
- lua-curl
- lua-fifo
- luafilesystem
- lua-http
- luajson
- lualogging
- lua-lpeg-patterns
- luaossl
- lua-periphery
- luaposix
- luasec
- luasocket
- lua-valua

## Формат плагинов
Файлы плагинов представляют собой tar архив, который опционально может быть запакован одной из программ-упаковщиков:
- bzip2
- xz
- lzip
- lzma
- gzip
- compress

К внутренней структуре архива предъявляется несколько требований:
1. в корне архива находится одна директория, имя которой (по-умолчанию) является именем плагина; 
2. директория всегда содержит файл service.lua
3. директория может содержать файл config.lua (при наличии этого файла на странице плагинов в web-интерфейсе 
доступны дополнительные настройки данного плагина, которые и генерируются этим файлом);
4. все имена файлов и директорий чувствительны к регистру;
5. все имена файлов и директорий должны состоять только из символов кодовой таблицы US-ASCII, без использования пробела.

***Внимание!*** Имя плагина должно быть уникально.

## Встроенная библиотека КУН-IP
Данная библиотека расширяет возможности интерпретатора LUA и позволяет управлять выбранными аппаратными ресурсами КУН-IP. 

В настоящий момент реализованы следущие функции:
- ***cun.inputs_get()*** - возвращает таблицу с сопротивлениями (Ом) на всех "дискретных" входах КУН.
- ***cun.buttons_get()*** - возвращает таблицу с состояниями всех кнопок "вызова" КУН. 
  - 0 (неактивен)
  - 1 (активен).
- ***cun.ext_temp_get()*** - возвращает таблицу с результатами измерения температуры (градусы Цельсия) всеми подключенными внешними датчиками.
- ***cun.relays_get()*** - возвращает таблицу с состояниями всех имеющихся в КУН реле. 
  - 0 (отключено) 
  - 1 (включено).
- ***cun.relay_set(index, state)*** - переключает реле index в состояние state.
- ***cun.should_stop()*** - возвращает true (необходимо прервать выполнение скрипта) или false (можно продолжить работу).
- ***cun.serial_open(fname, baud[, charsize[, parity[, parodd[, stopbits]]]])*** - возвращает файловый дескриптор для использования с ф-ями из unistd.h (POSIX), 
доступными в библиотеке  luaposix, такими, как unistd.read(), unistd.write(), unistd.close(). 
В случае ошибки возвращает 3 значения в стеке в формате luaL_fileresult() (nil + текст ошибки + код ошибки).
- ***store_int(config_name, key, value)*** - сохраняет значение value параметра key типа int в файле конфигурации config_name.
- ***load_int(config_name, key)*** - возвращает значение параметра key типа int, сохраненное ранее в файле конфигурации config_name, или nil.
- ***store_str(config_name, key, value)*** - сохраняет значение value параметра key типа "строка" в файле конфигурации config_name.
- ***load_str(config_name, key)*** - возвращает значение параметра key типа "строка", сохраненное ранее в файле конфигурации config_name, или nil.

## Интерфейс service.lua
Файл service.lua является основным файлом описывающим поведение плагина.

Типовое код имеет следующий вид:
```
-- подключение библиотеки для функции sleep
local unistd  = require("posix.unistd") 
...
-- главный цикл работы плагина
while not cun.should_stop() do
 ...
 unistd.sleep(1)    
end 
```

Т.е. плагин после старта постоянно прокручивает один и тот же цикл.

В случае, если в коде service.lua цикл обработки отсутствует, КУН-IP будет постоянно запускать скрипт заново, после окончания его работы (что в некотором смысле "замусоривает" log КУН)

Лог КУН-IP доступен по адресу http://192.168.1.100/cgi-bin/log.cgi

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

## Интерфейс config.lua
Файл config.lua (если присутствует в скрипте) выполняется в двух случаях:
- генерации HTML-страницы для окна настроек плагина
- сохранении параметров

### Генерация HTML
В этом случае lua-скрипт запускается без параметров, т.е. выполняется условие #arg == 0. 

Необходимо вывести в стандартный вывод (с помощью print) HTML-код формы с заполненными значениями из файла конфигурации (не забываем про замену спецсимволов HTML на &amp;, &lt; и т.д). 

Тэги <form> и </form> генерируются автоматически, lua-скрипт генерируется только необходимые тэги <input> и форматирования, такие как <table> и т.п.

Имена всех тэгов <input> должны иметь префикс с именем плагина. 

Например, если плагин называется myplugin параметры HTML-формы могут называться myplugin_inputtext1 или myplugin_checkbox1. 

Это используется для фильтрации параметров из общей формы между плагинами.

### Сохранение параметров
В этом случае lua-скрипт получает все параметры, начинающиеся с префикса с именем плагина в массиве arg. 

Даже если скрипт не генерирует ни одного элемента ввода или если они не активированы (например checkbox), скрипт всегда получает пару REQUEST_METHOD=POST, чтобы отличить этот режим от генерации HTML.

Все параметры имеют формат key=value. 

Скрипт должен сохранить знчения параметров выбранным способом и завершить работу. 

Не ожидается никакого вывода скрипта в этом режиме, но если он есть, то это считается информацией об ошибке и выводится в системный журнал с уровнем DEBUG.

## Инструменты для создания плагинов
Для создания и редактирования плагинов удобно использовать текстовый редактор [Notepad++](https://notepad-plus-plus.org)

## Подготовка скрипта 
После создание папки скрипта необходимо выполнить ее упаковку в архив. 

В демонстрационных примерах используется сжатие в архив tar.gz с помощью Total Commander.  

## Загрузка плагина на КУН-IP
Cледует открыть WEB-интерфейс КУН-IP, перейти во вкладку Плагины и загрузить плагин. 
![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/plugin2_1.PNG)

По умолчанию загруженный плагин не активен. Для включения плагина следует установить флажок на имени плагина и нажать кнопку Сохранить/загрузить.
![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/plugin2_3.PNG)

По необходимости выполнить настройку плагина
![link!](https://github.com/Tekon-Avtomatika/KUN-IP8_Plugins/blob/main/plugin2_2.PNG)

## Вывод отладочной информации в лог КУН-IP
Для вывода отладочной информации используйте функцию print в файле service.lua плагина.

Лог КУН-IP доступен по адресу http://192.168.1.100/cgi-bin/log.cgi

Пример отображение информации о запуске плагина:

```
...
Sep 20 10:46:55 cun-ng systemd[1]: Created slice system-luaext.slice.
Sep 20 10:46:55 cun-ng systemd[1]: Started CUN Hardware Management Daemon Lua Extention /etc/luaext.d/plugin2/service.lua.
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service START
Sep 20 10:46:55 cun-ng sh[581]: Plugin2 service STEP
...
```

