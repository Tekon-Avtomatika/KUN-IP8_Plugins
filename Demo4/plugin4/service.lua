-- подключаем файл настроек
dofile ('settings.lua')
-- подключаем библиотеку для sleep
local unistd  = require("posix.unistd")
-- основной цикл обработки
while not cun.should_stop() do
  -- получаем состояние дискретных входов
  local inputs = cun.inputs_get()
  -- получаем состояние реле
  local relays = cun.relays_get()

  if inputs~=nil and relays~=nil then
    -- проверка, что вход замкнут
	if inputs[discrete_id] < 1000 then
      -- инвертировать состояние реле	
      cun.relay_set(relay_id, (relays[relay_id]==1) and 0 or 1)
    else
	  -- разомкнуть реле
      cun.relay_set(relay_id, 0)
    end
  end

  unistd.sleep(1)
end