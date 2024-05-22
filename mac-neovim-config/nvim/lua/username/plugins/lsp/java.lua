local home = os.getenv("HOME")
local jdtls = require("jdtls")

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- eclipse.jdtls stores project specific data withing a folder. If you are workign
-- with multiple different projects, each project must be a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker a sthe folder for project specific data.
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- local remap =  require("me.util").remap

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
	bufopts.desc = desc
	vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach funciton is used to set keymaps  after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
	-- With hotcodereplace = 'auto' the dubug addapter will try to apply code changes
	-- you make during a debug session immediately
	jdtls.setup_dap({ hotoderplace = "auto" })

	-- Regular Neovim LSP client keymappings
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	nnoremap("gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
	nnoremap("gd", vim.lsp.buf.definition, bufopts, "Go to definition")
	nnoremap("gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
	nnoremap("K", vim.lsp.buf.hover, bufopts, "Hover text")
	nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts, "Show signature")
	nnoremap("<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
	nnoremap("<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
	nnoremap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts, "List workspace folders")
	nnoremap("<leader>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
	nnoremap("<leader>rn", vim.lsp.buf.rename, bufopts, "Rename")
	nnoremap("<leader>ca", vim.lsp.buf.code_action, bufopts, "Code action")
	vim.keymap.set(
		"v",
		"<space>ca",
		"<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
		{ noremap = true, silent = true, buffer = bufnr, desc = "Code actions" }
	)
	nnoremap("<leader>F", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts, "Format file")

	-- Java extentions provided by jdtls
	nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
	nnoremap("<leader>tc", jdtls.test_class, bufopts, "Test class (DAP)")
	nnoremap("<leader>tm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
	nnoremap("<leader>ve", jdtls.extract_variable, bufopts, "Extract variable")
	nnoremap("<leader>ce", jdtls.extract_constant, bufopts, "Extract constant")
	vim.keymap.set(
		"v",
		"<space>em",
		[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		{ noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
	)
end

local bundles = {
	vim.fn.glob(
		home
			.. "/.local/share/eclipse/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
	),
}

-- Extend the bundles list with JAR files from the vscode-java-test server directory
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/eclipse/vscode-java-test/server/*jar"), "\n"))

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local config = {
	flags = {
		debounce_text_changes = 80,
	},
	capabilities = capabilities,
	on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
	init_options = {
		bundles = bundles,
	},
	root_dir = root_dir, -- Set the root directory to our found root_marker
	-- Here you can configure eclipse.jdt.ls specific settings
	-- There are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			format = {
				settings = {
					-- Use Google Java style guidelines for formatting
					-- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
					-- and place it in the ~/.local/share/eclipse directory
					url = "/.local/share/eclipse/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
			-- Specify any completion options
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			-- Specify any options for organizing imports
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			-- How code generation should act
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			-- If you are developing in projects with different Java versions, you need
			-- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
			-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
			-- And search for the `interface RuntimeOption`
			-- the `name` is NOT arbitrary, but must match one of the elements from the `enum ExecutionEnvironment` in the lnk above
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
					},
				},
			},
		},
	},
	-- cmd is the command that starts the language server. Whatever is placed
	-- here is what is passed to the command line to execute jdtls.
	-- Note what eclipse.jdt.ls must be started with a Java version of 17 or higher
	-- See: https://github.com/eclipse/eclipse/jdt.ls#running-rom-thecommand-line
	-- for the list of options
	cmd = {
		"/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		-- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse/
		"-javaagent:"
			.. home
			.. "/.local/share/eclipse/lombok.jar",

		-- The jar file is located where jdtls was installed. This will need to be updated
		-- to the location where you installed jdtls
		"-jar",
		vim.fn.glob(home .. "/.local/share/eclipse/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

		-- The configuration for jdtls is also placed where jdtls was installed.
		-- This will need to be updated depending on your environment
		"-configuration",
		vim.fn.glob(home .. "/.local/share/eclipse/jdtls/config_mac"),

		-- Use the workspace_folder defined above to store data for this project
		"-data",
		workspace_folder,
	},
}

local M = {}
function M.make_jdtls_config()
	return config
end
return M
