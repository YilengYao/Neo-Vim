local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  { import = "plugins.copilot" },
  { import = "plugins.telescope" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = " ", -- Separator to use in chat
      debug = true,
      prompts = prompts,
      auto_follow_cursor = false,
      show_help = false,
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        show_diff = {
          normal = "gmd",
        },
        show_system_prompt = {
          normal = "gmp",
        },
        show_user_selection = {
          normal = "gms",
        },
      },
    },
    config = function(_, opts)
      local copilot_chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      copilot_chat.setup(opts)

      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      opts.prompts.Commit = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = select.gitdiff,
      }
      opts.prompts.CommitStaged = {
        prompt = "Write commit message for the change with commitizen convention",
        selection = function(source)
          return select.gitdiff(source, true)
        end,
      }

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        copilot_chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        copilot_chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        copilot_chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        copilot_chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        copilot_chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })

      -- Explain code "Space+cce+Enter"
      -- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>cce<cr>",
        "<cmd>CopilotChatExplain<cr>",
        { desc = "CopilotChat - Explain code", noremap = true, silent = true }
      )
      -- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>cce<cr>",
        ":CopilotChatExplain<cr>",
        { desc = "CopilotChat - Explain code", noremap = true, silent = true }
      )

      -- Generate tests "Space+cct+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>cct<cr>",
        "<cmd>CopilotChatTests<cr>",
        { desc = "CopilotChat - Generate tests", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>cct<cr>",
        ":CopilotChatTests<cr>",
        { desc = "CopilotChat - Generate tests", noremap = true, silent = true }
      )

      -- Review code "Space+ccr+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccr<cr>",
        "<cmd>CopilotChatReview<cr>",
        { desc = "CopilotChat - Review code", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccr<cr>",
        ":CopilotChatReview<cr>",
        { desc = "CopilotChat - Review code", noremap = true, silent = true }
      )

      -- Refactor code "Space+ccrf+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccrf<cr>",
        "<cmd>CopilotChatRefactor<cr>",
        { desc = "CopilotChat - Refactor code", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccrf<cr>",
        ":CopilotChatRefactor<cr>",
        { desc = "CopilotChat - Refactor code", noremap = true, silent = true }
      )

      -- Fix code "Space+ccf+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccf<cr>",
        "<cmd>CopilotChatFixCode<cr>",
        { desc = "CopilotChat - Fix code", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccf<cr>",
        ":CopilotChatFixCode<cr>",
        { desc = "CopilotChat - Fix code", noremap = true, silent = true }
      )

      -- Documentation "Space+ccd+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccd<cr>",
        "<cmd>CopilotChatDocumentation<cr>",
        { desc = "CopilotChat - Add documentation for code", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccd<cr>",
        ":CopilotChatDocumentation<cr>",
        { desc = "CopilotChat - Add documentation for code", noremap = true, silent = true }
      )

      -- Better namings "Space+ccsa+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccsa<cr>",
        "<cmd>CopilotChatSwaggerApiDocs<cr>",
        { desc = "CopilotChat - Add Swagger API documentation", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccsa<cr>",
        ":CopilotChatSwaggerApiDocs<cr>",
        { desc = "CopilotChat - Add Swagger API documentation", noremap = true, silent = true }
      )

      -- Better namings "Space+ccsjs+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccsjs<cr>",
        "<cmd>CopilotChatSwaggerJsDocs<cr>",
        { desc = "CopilotChat - Add Swagger API with Js Documentation", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccsjs<cr>",
        ":CopilotChatSwaggerJsDocs<cr>",
        { desc = "CopilotChat - Add Swagger API with Js Documentation", noremap = true, silent = true }
      )

      -- Summarize Text "Space+ccs+Enter"
      ----(normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccs<cr>",
        "<cmd>CopilotChatSummarize<cr>",
        { desc = "CopilotChat - Summarize text", noremap = true, silent = true }
      )
      ----(visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccs<cr>",
        ":CopilotChatSummarize<cr>",
        { desc = "CopilotChat - Summarize text", noremap = true, silent = true }
      )

      -- Correct Spelling "Space+ccsp+Enter"
      ----  (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccsp<cr>",
        "<cmd>CopilotChatSpelling<cr>",
        { desc = "CopilotChat - Correct spelling", noremap = true, silent = true }
      )
      ----  (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccsp<cr>",
        ":CopilotChatSpelling<cr>",
        { desc = "CopilotChat - Correct spelling", noremap = true, silent = true }
      )

      -- Improve Wording "Space+ccw+Enter"
      ----  (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccw<cr>",
        "<cmd>CopilotChatWording<cr>",
        { desc = "CopilotChat - Improve wording", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccw<cr>",
        ":CopilotChatWording<cr>",
        { desc = "CopilotChat - Improve wording", noremap = true, silent = true }
      )

      -- Make text concise "Space+ccc+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccc<cr>",
        "<cmd>CopilotChatConcise<cr>",
        { desc = "CopilotChat - Make text concise", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccc<cr>",
        ":CopilotChatConcise<cr>",
        { desc = "CopilotChat - Make text concise", noremap = true, silent = true }
      )

      -- Opening floating Window to Chat with Copilot "Space+ccv+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccv<cr>",
        ":CopilotChatVisual<cr>",
        { desc = "CopilotChat - Open in vertical split", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccv<cr>",
        ":CopilotChatVisual<cr>",
        { desc = "CopilotChat - Open in vertical split", noremap = true, silent = true }
      )

      -- Opening Window to Chat with Copilot "Space+ccx+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccx<cr>",
        ":CopilotChatInline<cr>",
        { desc = "CopilotChat - Run in-place code", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccx<cr>",
        ":CopilotChatInline<cr>",
        { desc = "CopilotChat - Run in-place code", noremap = true, silent = true }
      )

      -- Custom input for CopilotChat "Space+cci+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>cci<cr>",
        ":lua AskCopilot()<cr>",
        { desc = "CopilotChat - Ask input", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>cci<cr>",
        ":lua AskCopilotVisual()<cr>",
        { desc = "CopilotChat - Ask input (visual)", noremap = true, silent = true }
      )

      -- Debug Info "Space+ccdb+Enter"
      ---- (normal mode)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ccdb<cr>",
        "<cmd>CopilotChatDebugInfo<cr>",
        { desc = "CopilotChat - Debug Info", noremap = true, silent = true }
      )
      ---- (visual mode)
      vim.api.nvim_set_keymap(
        "x",
        "<leader>ccdb<cr>",
        ":CopilotChatDebugInfo<cr>",
        { desc = "CopilotChat - Debug Info", noremap = true, silent = true }
      )
    end,
  },
}
