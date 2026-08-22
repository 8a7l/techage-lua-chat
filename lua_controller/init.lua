$events(true)
$loopcycle(0)

SERVER = "21725"
ADMIN_SERVER = "21736"
STATE_SERVER = "21737"

-- Термінали
T = $server_read(SERVER,"terminals")
if not T then
	T = Store()
end

-- Адміністратори
A = $server_read(ADMIN_SERVER,"admins")
if not A then
	A = Store()
end

-- Перший адміністратор
if not A.get("YOU_NICHAME") then
	A.set("YOU_NICHAME",true)
	$server_write(ADMIN_SERVER,"admins",A)
end

-- Стан mute
M = $server_read(STATE_SERVER,"muted")
if not M then
	M = Store()
end
