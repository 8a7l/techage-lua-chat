num,msg=$get_msg()

if num then

	cmd,arg=string.split2(msg," ",false,1)

	if cmd=="/register" then

		if arg then
			name=$send_cmnd(arg,"name")

			if name and A.get(name) then
				T.set(num,arg)
				save_t()
				broadcast("[system]: "..name.." add New terminal "..num)
			else
				$put_term(num,"No permission")
			end
		end

	elseif cmd=="/unregister" then

		d=T.get(num)

		if d then
			name=get_name()

			if name and A.get(name) then
				target=arg or num
				td=T.get(target)

				if td then
					broadcast("[system]: "..name..
						" Removed Terminal "..target)

					T.del(target)
					save_t()

					if target==num then
						$put_term(num,"Unregistered")
					end
				else
					$put_term(num,"Terminal not registered")
				end
			else
				$put_term(num,"No permission")
			end
		else
			$put_term(num,"Terminal not registered")
		end

	elseif cmd=="/list" then

		$put_term(num,"--- terminals ---")

		for t,d in T.next() do
			$put_term(num,t.." -> "..d..
				(M.get(t) and " [MUTED]" or ""))
		end

	elseif cmd=="/mute" then

		name=get_admin()

		if name then
			target=arg

			if target and T.get(target) then
				M.set(target,true)
				save_m()
				broadcast("[system]: "..name..
					" muted Terminal "..target)
			else
				$put_term(num,"Terminal not registered")
			end
		end

	elseif cmd=="/unmute" then

		name=get_admin()

		if name then
			target=arg

			if target and T.get(target) then
				M.del(target)
				save_m()
				broadcast("[system]: "..name..
					" unmuted Terminal "..target)
			else
				$put_term(num,"Terminal not registered")
			end
		end

	elseif cmd=="/admin_add" then

		name=get_admin()

		if name then
			if arg and arg~="" then

				if not A.get(arg) then
					A.set(arg,true)
					save_a()
					broadcast("[system]: "..name..
						" added admin "..arg)
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

	elseif cmd=="/admin_del" then

		name=get_admin()

		if name then
			if arg and arg~="" then

				if A.get(arg) then
					A.del(arg)
					save_a()
					broadcast("[system]: "..name..
						" removed admin "..arg)
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

	elseif cmd=="/admin_list" then

		if get_admin() then
			$put_term(num,"--- administrators ---")

			for admin,value in A.next() do
				$put_term(num,admin)
			end
		else
			$put_term(num,"No permission")
		end

	elseif cmd=="/help" then

		$put_term(num,"/register /unregister /list /help")

		if get_admin() then
			$put_term(num,
				"ADMIN: /mute /unmute /admin_add /admin_del /admin_list")
		end

	else

		d=T.get(num)

		if d then

			if M.get(num) then

				$put_term(num,"[system]: You are muted")

				$print("[CHAT] MUTED terminal="..num..
					" msg="..msg)

			else

				name=get_name()

				if name then

					$print("[CHAT] terminal="..num..
						" player="..name..
						" msg="..msg)

					broadcast(name..": "..msg)

				else
					$put_term(num,"Player not detected")
				end
			end

		else
			$put_term(num,"Terminal not registered")
		end
	end
end
