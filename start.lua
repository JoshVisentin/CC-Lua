local hostID = os.getComputerID()
print(hostID)
rednet.open("top")

local id, text, distance = rednet.receive()

local function CustomText(text, scale)
	scale = scale or 3

	monitor = peripheral.wrap("back")
	monitor.clear()
	monitor.setCursorPos(0, 0)
	monitor.setTextScale(scale)
	monitor.setTextColor(colors.white)

	local monitorWidth, monitorHeight = monitor.getSize()
	
	local wrappedLines = {}
	local currentLine = ""

	for word in string.gmatch(text, "[^ ]+") do -- Match words (sequences of non-space characters)
		if (#currentLine + #word + 1) <= (monitorWidth) then -- Check if word fits with a space
			currentLine = currentLine .. " " .. word
		else
			table.insert(wrappedLines, currentLine) -- Add current line if full
			currentLine = word
		end
	end

	if currentLine ~= "" then -- Add the last line (if any)
		table.insert(wrappedLines, currentLine)
	end
	
	local cursorY = math.floor((monitorHeight - #wrappedLines)/2)
	
	for i, line in ipairs(wrappedLines) do
		cursorY = cursorY + 1
		local cursorOffset = math.floor((monitorWidth - #line)/2) + 1
		monitor.setCursorPos(cursorOffset, cursorY)
		monitor.write(line)
	end
end

CustomText(text)
os.shutdown()
