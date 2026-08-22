	function get_name()
		d=T.get(num)
		if d then
			n=$send_cmnd(d,"name")
			if n and n~="" then return n end
		end
	end

	function get_admin()
		n=get_name()
		if n and A.get(n) then return n end
	end

	function broadcast(s)
		for t,x in T.next() do
			$put_term(t,s)
		end
	end

	function save_t()
		$server_write(SERVER,"terminals",T)
	end

	function save_a()
		$server_write(ADMIN_SERVER,"admins",A)
	end

	function save_m()
		$server_write(STATE_SERVER,"muted",M)
	end
