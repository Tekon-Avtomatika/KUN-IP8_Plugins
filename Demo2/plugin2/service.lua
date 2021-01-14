-- подключение библиотеки для функции sleep
local unistd  = require("posix.unistd") 
print('Plugin2 service START') 
-- главный цикл работы плагина
while not cun.should_stop() do
 print('Plugin2 service STEP') 
 unistd.sleep(10)    
end