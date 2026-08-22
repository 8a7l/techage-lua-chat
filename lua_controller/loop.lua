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
					$put_term(t,
						"[system]: "..name..
						" add New terminal "..num)
				end
			else
				$put_term(num,"Registered: "..num)
			end
		end

	elseif cmd == "/unregister" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and name ~= "" then
				for t,x in T.next() do
					$put_term(t,
						"[system]: "..name..
						" Removed Terminal "..num)
				end
			end

			T.del(num)
			$server_write(SERVER,"terminals",T)

			$put_term(num,"Unregistered")
		else
			$put_term(num,"Terminal not registered")
		end

	elseif cmd == "/list" then

		$put_term(num,"--- terminals ---")

		for t,d in T.next() do
			if M.get(t) then
				$put_term(num,t.." -> "..d.." [MUTED]")
			else
				$put_term(num,t.." -> "..d)
			end
		end

	elseif cmd == "/mute" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and A.get(name) then

				target = arg

				if target and T.get(target) then

					M.set(target,true)
					$server_write(STATE_SERVER,"muted",M)

					for t,x in T.next() do
						$put_term(t,
							"[system]: "..name..
							" muted Terminal "..target)
					end

				else
					$put_term(num,"Terminal not registered")
				end

			else
				$put_term(num,"No permission")
			end
		end

	elseif cmd == "/unmute" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and A.get(name) then

				target = arg

				if target and T.get(target) then

					M.del(target)
					$server_write(STATE_SERVER,"muted",M)

					for t,x in T.next() do
						$put_term(t,
							"[system]: "..name..
							" unmuted Terminal "..target)
					end

				else
					$put_term(num,"Terminal not registered")
				end

			else
				$put_term(num,"No permission")
			end
		end

	elseif cmd == "/admin_add" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and A.get(name) then

				if arg and arg ~= "" then

					if not A.get(arg) then
						A.set(arg,true)
						$server_write(ADMIN_SERVER,"admins",A)

						for t,x in T.next() do
							$put_term(t,
								"[system]: "..name..
								" added admin "..arg)
						end
					else
						$put_term(num,"Already an administrator")
					end

				else
					$put_term(num,
						"[system]: Usage: /admin_add Nick")
				end

			else
				$put_term(num,"No permission")
			end
		else
			$put_term(num,"Terminal not registered")
		end

	elseif cmd == "/admin_del" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and A.get(name) then

				if arg and arg ~= "" then

					if A.get(arg) then
						A.del(arg)
						$server_write(ADMIN_SERVER,"admins",A)

						for t,x in T.next() do
							$put_term(t,
								"[system]: "..name..
								" removed admin "..arg)
						end
					else
						$put_term(num,"Not an administrator")
					end

				else
					$put_term(num,
						"[system]: Usage: /admin_del Nick")
				end

			else
				$put_term(num,"No permission")
			end
		else
			$put_term(num,"Terminal not registered")
		end

	elseif cmd == "/admin_list" then

		d = T.get(num)

		if d then
			name = $send_cmnd(d,"name")

			if name and A.get(name) then

				$put_term(num,"--- administrators ---")

				for admin,value in A.next() do
					$put_term(num,admin)
				end

			else
				$put_term(num,"No permission")
			end
		else
			$put_term(num,"Terminal not registered")
		end

elseif cmd == "/help" then
	$put_term(num,"/register /unregister /list /help")
	d=T.get(num)
	if d then
		n=$send_cmnd(d,"name")
		if n and A.get(n) then
			$put_term(num,"ADMIN: /mute /unmute /admin_add /admin_del /admin_list")
		end
	end

	else

		d = T.get(num)

		if d then

			if M.get(num) then

				$put_term(num,"[system]: You are muted")

				$print("[CHAT] MUTED terminal="..num..
					" msg="..msg)

			else

				name = $send_cmnd(d,"name")

				if name and name ~= "" then

					$print("[CHAT] terminal="..num..
						" player="..name..
						" msg="..msg)

					for t,x in T.next() do
						$put_term(t,name..": "..msg)
					end

				else
					$put_term(num,"Player not detected")
				end
			end

		else
			$put_term(num,"Terminal not registered")
		end
	end
end
