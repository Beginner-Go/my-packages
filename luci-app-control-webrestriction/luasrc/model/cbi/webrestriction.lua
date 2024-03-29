local o = require "luci.sys"
local a, e, t

a = Map("webrestriction")
a.title = translate("访问限制")
a.description = translate("使用黑名单或者白名单模式控制列表中的客户端是否能够连接到互联网。")

a:section(SimpleSection).template  = "webrestriction/webrestriction_status"

e = a:section(TypedSection, "basic")
e.anonymous = true

t = e:option(Flag, "enable", translate("开启"))
t.rmempty = false

t = e:option(ListValue, "limit_type", translate("限制模式"))
t.default = "blacklist"
t:value("whitelist", translate("白名单"))
t:value("blacklist", translate("黑名单"))
t.rmempty = false

e = a:section(TypedSection, "macbind")
e.title = translate("名单设置")
e.description = translate("如果是黑名单模式，列表中的客户端将被禁止连接到互联网；白名单模式表示仅有列表中的客户端可以连接到互联网。")
e.template = "cbi/tblsection"
e.anonymous = true
e.addremove = true

t = e:option(Flag, "enable", translate("开启控制"))
t.rmempty = false

t = e:option(Value, "macaddr", translate("MAC地址"))
t.rmempty = true

o.net.mac_hints(function(e, a) t:value(e, "%s (%s)" % {e, a}) end)

return a
