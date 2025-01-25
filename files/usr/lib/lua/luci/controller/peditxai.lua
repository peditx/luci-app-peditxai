module("luci.controller.peditxai", package.seeall)

function index()
    entry({"admin", "services", "peditxai"}, firstchild(), "PeDitXai", 60).dependent = false
    entry({"admin", "services", "peditxai", "settings"}, cbi("peditxai/settings"), _("Settings"), 10)
    entry({"admin", "services", "peditxai", "chat"}, template("peditxai/chat"), _("Chat"), 20)
end
