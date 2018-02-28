--/TODO\--
--Fix a bug when listener catches a word from whole sentence and triggers the event.




----------------------------------------

local ipairs = ipairs
local strmatch = string.match

local MyFilterAddon = CreateFrame'Frame'

local function myChatFilter(self, event, arg1, msg, author,...)
	if arg1:match("!time") then
		hour,minute = GetGameTime();
		SendChatMessage("The server time is " .. hour .. ":" .. minute .. " GMT on Icecrown realm.", "GUILD", "common", author);
	end
	if arg1:match("!date") then
		SendChatMessage("The date is " .. date("%d/%m/%y %H:%M:%S"), "GUILD", "common", author);
	end
 -- For test purposes --
	if arg1:match("!ping") then
		SendChatMessage("pong!", "GUILD", "common", author);
	end
    if arg1:match("!ding") then
		SendChatMessage("Dong!", "GUILD", "common", author);
	end
    if arg1:match("!test") then
		SendChatMessage("1.", "WHISPER", "common", author);
		SendChatMessage("2.", "WHISPER", "common", author);
		SendChatMessage("3.", "WHISPER", "common", author);
		SendChatMessage("4.", "WHISPER", "common", author);
		SendChatMessage("5", "WHISPER", "common", author);
	end
-- debug end --
	if arg1:match("!help") then
		SendChatMessage("All available commands (starts with !) : time, date, ping, sex .", "GUILD", "common", author);
	end
    if arg1:match("!sex") then
		SendChatMessage("Dont make me laugh.", "GUILD", "common", author);
	end
      
	if arg1:match("!raids") then
local _,month,_,year=CalendarGetDate()
CalendarSetAbsMonth(month,year) -- set to this month

for i=1,1 do
  CalendarSetMonth(0) -- go to next month
  local month,year,numDays = CalendarGetMonth(0)
  local monthName = select(month,CalendarGetMonthNames())
  print(monthName,"has",numDays,"days. Its events:")
  for day = 1,numDays do
    for event = 1,CalendarGetNumDayEvents(0,day) do
      local holiday = CalendarGetEventInfo(0,day,event)
      if holiday then
        print(monthName,day,year,holiday)
      end
    end
  end
end
end
end

function MyFilterAddon:PLAYER_LOGIN()
  ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", myChatFilter)
end
MyFilterAddon:RegisterEvent'PLAYER_LOGIN'

MyFilterAddon:SetScript('OnEvent', function(self, event, ...)
  return self[event](self, event )
end)