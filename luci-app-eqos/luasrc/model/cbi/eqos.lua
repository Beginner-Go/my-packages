m = Map("eqos")
m.title = translate("Network speed control service")
m.description = translate("Limit client speed")

m:section(SimpleSection).template  = "eqos/eqos_status"

s = m:section(TypedSection, "eqos")
s.anonymous = true

e = s:option(Flag, "enabled", translate("Enable"))
e.rmempty = false

dl = s:option(Value, "download", translate("Download speed (Mbit/s)"))
dl.description = translate("Total bandwidth")
dl.datatype = "and(uinteger,min(1))"

ul = s:option(Value, "upload", translate("Upload speed (Mbit/s)"))
ul.description = translate("Total bandwidth")
ul.datatype = "and(uinteger,min(1))"

s = m:section(TypedSection, "device", translate("Speed limit based on IP address"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true
s.sortable = true

ip = s:option(Value, "ip", translate("IP address"))

luci.ip.neighbors({family = 4, dev = "br-lan"}, function(n)
	if n.mac and n.dest then
		ip:value(n.dest:string(), "%s (%s)" %{ n.dest:string(), n.mac })
	end
end)

dl = s:option(Value, "download", translate("Download speed (Mbit/s)"))
dl.datatype = "and(uinteger,min(1))"

ul = s:option(Value, "upload", translate("Upload speed (Mbit/s)"))
ul.datatype = "and(uinteger,min(1))"

comment = s:option(Value, "comment", translate("Comment"))

return m
