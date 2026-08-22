num,msg = $get_msg()

if num then

	cmd,arg = string.split2(msg," ",false,1)

if cmd == "/register" then
	if arg then
		T.set(num,arg)
		$server_write(SERVER,"terminals",T)

		name = $send_cmnd(arg,"name")

		if name and name ~= "" then
			for t,d in T.next() do
				$put_term(t,"[system]: "..name.." add New terminal "..num)
			end
		else
			$put_term(num,"Registered: "..num)
		end
	end

elseif cmd == "/unregister" then
	d = T.get(num)

	if d then
		name = $send_cmnd(d,"name")

		T.del(num)
		$server_write(SERVER,"terminals",T)

		if name and name ~= "" then
			for t,x in T.next() do
				$put_term(t,"[system]: "..name.." Removed Terminal "..num)
			end
		end

		$put_term(num,"Unregistered")
	else
		$put_term(num,"Terminal not registered")
	end

	elseif cmd == "/list" then
		$put_term(num,"--- terminals ---")
		for t,d in T.next() do
			$put_term(num,t.." -> "..d)
		end

	else
		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and name ~= "" then
				for t,x in T.next() do
					$put_term(t,name..": "..msg)
				end
			else
				$put_term(num,"Player not detected")
			end
		else
			$put_term(num,"Terminal not registered")
		end
	end
end
