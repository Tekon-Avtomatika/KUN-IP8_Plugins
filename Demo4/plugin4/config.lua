--require 'settings'
dofile ('settings.lua')

print('<table border="0" cellpadding="0"><tbody>') 
print(' <tr><td>Плагин меняет состояние "' .. tostring(relay_id) ..'-го Pеле" 1 раз в секунду, если замкнут "Дискретный вход ' .. tostring(discrete_id) ..'".</td><td>')
print(' <tr><td>Если "Дискретный вход ' .. tostring(discrete_id) ..'" разомкнут, то "' .. tostring(relay_id) ..'-е Реле" размыкается.</td><td>')
print(' <tr><td>&nbsp;</td></tr>')
print('</tbody></table>')