m = Map("peditxai", "PeDitXai Settings", "Enter your DeepSeek API key below.")

s = m:section(TypedSection, "settings", "API Key Configuration")
s.anonymous = true

api_key = s:option(Value, "api_key", "API Key")
api_key.description = "Enter your DeepSeek API key here."

return m
