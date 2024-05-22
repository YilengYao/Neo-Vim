local username = os.getenv("USER") or os.getenv("USERNAME")
local config = require(string.format("%s.plugins.lsp.java", username)).make_jdtls_config()
require("jdtls").start_or_attach(config)
