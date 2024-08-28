-- Basic setup for nvim-notify
require("notify").setup({
  -- Set the background color for notifications
  -- background_colour = "#000000",

  -- Minimum level of messages to show
  level = "info",   -- Options: "trace", "debug", "info", "warn", "error"

  -- Set the default timeout for notifications (in milliseconds)
  timeout = 1000,

  -- Set the stages of the animation (fade, slide, etc.)
  stages = "static",   -- Options: "fade", "fade_in_slide_out", "static"

  -- Define icons for different notification levels
  icons = {
    ERROR = "",
    WARN  = "",
    INFO  = "",
    DEBUG = "",
    TRACE = "✎",
  },

  -- Set the rendering style
  render = "wrapped-compact",   -- Options: "default", "minimal"

  -- Set the maximum width of notifications
  max_width = 75,

  -- Set the maximum height of notifications
  max_height = nil,   -- Can be nil, this sets the maximum height
})


vim.notify = require("notify")

require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    cmdline = { pattern = "^:", icon = "", lang = "vim" },
    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
    input = {}, -- Used by input()
  },
  messages = {
    enabled = true,
    view = "notify",
    opts = {
      wrap = true, -- enables line wrapping for long messages
      -- replace = true,
      merge = true
    },
  },
  confirm = {
    enabled = true,
    view = "confirm",
    opts = {
      wrap = true, -- enables line wrapping for long messages
      -- replace = true,
      merge = true
    },
  },
  lsp = {
    progress = {
      enabled = true,
      view = "notify",
    },
    hover = {
      enabled = true,
      view = nil,
    },
    signature = {
      enabled = true,
      view = nil,
    },
  },
  routes = {
    {
      filter = {
        event = "lsp",
        kind = "progress"
      },
      opts = { skip = true }
    },
  },
  popupmenu = {
    enabled = true,  -- ensure popups are enabled
    backend = "nui", -- use the nui backend for better handling
    opts = {
      wrap = true,   -- wrap text inside the popup
    },
  },
  presets = {
    bottom_search = false,
    command_palette = false,
    long_message_to_split = true, -- consider using a split for very long messages
  },
})
