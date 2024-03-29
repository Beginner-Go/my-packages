module("luci.controller.weburl", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/weburl") then
		return
	end

	entry({"admin", "control"}, firstchild(), "Control", 50).dependent = false
	entry({"admin", "control", "weburl"}, cbi("weburl"), _("网址过滤"), 12).dependent = true
	entry({"admin", "control", "weburl", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = luci.sys.call("iptables -L FORWARD |grep WEBURL >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
