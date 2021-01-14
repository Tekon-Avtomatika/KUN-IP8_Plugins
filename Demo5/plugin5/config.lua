-- используем общий конфигурационный файл КУН для плагинов
local config_file = "/etc/cunhmd.conf"

-- настройки по умолчанию
local settings = {}
settings["plugin5_enable_dop"] = 0
settings["plugin5_discrete"] = 1
settings["plugin5_relay"]    = 1
  
if #arg > 0 then 
  -- пользователь нажал кнопку сохранить
  
  -- разбираем настройки 
	for i, val in ipairs(arg) do
		_, _, key, value = string.find(val, "([^=]+)=(.*)")
    settings[key] = tonumber(value) 
	end

  -- выполняем корректировку настроек
  -- проверяем, что дискретный вход в диапазоне 1..22, реле в 1..4
  settings["plugin5_discrete"]  = (((1 > settings["plugin5_discrete"]) or (settings["plugin5_discrete"] > 22)) and 1 or settings["plugin5_discrete"])
  settings["plugin5_relay"]     = (((1 > settings["plugin5_relay"]) or (settings["plugin5_relay"] > 4)) and 1 or settings["plugin5_relay"])
  
  -- сохраняем настройки
  cun.store_int(config_file, "plugin5_enable_dop", settings["plugin5_enable_dop"]) 
  cun.store_int(config_file, "plugin5_discrete", settings["plugin5_discrete"])
  cun.store_int(config_file, "plugin5_relay", settings["plugin5_relay"])

else
  -- пользователь открыл окно настроек 
  temp = cun.load_int(config_file, "plugin5_enable_dop")
  if temp ~= nil then
    settings["plugin5_enable_dop"]   = temp
  end
  
  temp = cun.load_int(config_file, "plugin5_discrete")
  if temp ~= nil then
    settings["plugin5_discrete"]   = temp
  end
  
  temp = cun.load_int(config_file, "plugin5_relay")
  if temp ~= nil then
    settings["plugin5_relay"]   = temp
  end
  
  -- генерируем HTML для окна настройки плагина
  print('<table border="0" cellpadding="0"><tbody>') 
  print(' <tr><td>')
  print('   <table border="0" cellpadding="0"><tbody>')
  print('    <tr><td>Активен: </td><td><input name="plugin5_enable_dop" type="checkbox" value="1" ' .. ((settings["plugin5_enable_dop"]==1)and' checked'or'') .. '></td></tr>')
  print('    <tr><td>Номер дискретного входа: </td><td><input name="plugin5_discrete" type="text" size="20" maxlength="15" value="' .. tostring(settings["plugin5_discrete"]) .. '"></td></tr>')
  print('     <tr><td>Номер канала управления: </td><td><input name="plugin5_relay" type="text" size="20" maxlength="15" value="' .. tostring(settings["plugin5_relay"]) .. '"></td></tr>')
  print('   </tbody></table>')
  print(' </td></tr>')
  print(' <tr><td align="center" bgcolor=LightYellow style="padding: 10px; border: 1px solid #cccccc"><font color="#800000"><b>После изменения настроек необходимо перезапустить плагин<b></font></td></tr>')
  print('</tbody></table>')

end

