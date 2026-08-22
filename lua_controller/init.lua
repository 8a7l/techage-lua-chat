$events(true)
$loopcycle(0)

SERVER = "21725"

T = $server_read(SERVER,"terminals")
if not T then
	T = Store()
end
