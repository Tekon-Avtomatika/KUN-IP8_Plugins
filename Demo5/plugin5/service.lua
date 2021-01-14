-- используем общий конфигурационный файл КУН для плагинов
local config_file = "/etc/cunhmd.conf"

local settings = {}

-- читаем настройки из файла
local temp = cun.load_int(config_file, "plugin5_enable_dop")
if temp == nil then 
 temp = 1
end 
settings["plugin5_enable_dop"]   = temp

local temp = cun.load_int(config_file, "plugin5_discrete")
if temp == nil then 
 temp = 1
end 
settings["plugin5_discrete"]   = temp

temp = cun.load_int(config_file, "plugin5_relay")
if temp == nil then 
 temp = 1
end 
settings["plugin5_relay"]   = temp

-- main loop
while not cun.should_stop() do
  if settings["plugin5_enable_dop"] == 1 then 
   local inputs = cun.inputs_get()  
   if nil~=inputs then
       cun.relay_set(settings["plugin5_relay"], ((inputs[settings["plugin5_discrete"]] < 1000) and 1 or 0))
   end 
  end 
  require("socket").sleep(0.01)
end
