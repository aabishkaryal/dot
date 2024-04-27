local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  print('bufferline not found')
  return
end

bufferline.setup {
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = 'bdelete! %d',
    right_mouse_command = 'bdelete! %d',
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    separator_style = 'slant',
    modified_icon = '●',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    },
    color_icons = true,
    enforce_regular_tabs = true,
    always_show_bufferline = false,
    auto_toggle_bufferline = true,
    show_buffer_close_icons = false,
    show_duplicate_prefix = true,
  },
  highlights = {
    fill = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    background = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    buffer_visible = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    close_button = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    close_button_visible = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    tab_selected = {
      fg = {
        attribute = 'fg',
        highlight = 'Normal'
      },
      bg = {
        attribute = 'bg',
        highlight = 'Normal'
      }
    },
    tab = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    tab_close = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLineSel'
      },
      bg = {
        attribute = 'bg',
        highlight = 'Normal'
      }
    },
    duplicate_selected = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLineSel'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLineSel'
      },
      italic = true
    },
    duplicate_visible = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      },
      italic = true
    },
    duplicate = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      },
      italic = true
    },
    modified = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    modified_selected = {
      fg = {
        attribute = 'fg',
        highlight = 'Normal'
      },
      bg = {
        attribute = 'bg',
        highlight = 'Normal'
      }
    },
    modified_visible = {
      fg = {
        attribute = 'fg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    separator = {
      fg = {
        attribute = 'bg',
        highlight = 'TabLine'
      },
      bg = {
        attribute = 'bg',
        highlight = 'TabLine'
      }
    },
    separator_selected = {
      fg = {
        attribute = 'bg',
        highlight = 'Normal'
      },
      bg = {
        attribute = 'bg',
        highlight = 'Normal'
      }
    },
    indicator_selected = {
      fg = {
        attribute = 'fg',
        highlight = 'LspDiagnosticsDefaultHint'
      },
      bg = {
        attribute = 'bg',
        highlight = 'Normal'
      }
    }
  }
}

-- bufferline.setup {
--   options = {
--     close_command = 'Bdelete! %d',           -- can be a string | function, see "Mouse actions"
--     right_mouse_command = 'Bdelete! %d',     -- can be a string | function, see "Mouse actions"
--     offsets = {
--       {
--         filetype = 'NvimTree',
--         text = '',
--         padding = 1
--       }
--     },
--     separator_style = 'thin'     -- | "thick" | "thin" | { 'any', 'any' },
--   },

--   highlights = {
--     fill = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     background = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     buffer_visible = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     close_button = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     close_button_visible = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     tab_selected = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'Normal'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       }
--     },
--     tab = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     tab_close = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLineSel'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       }
--     },
--     duplicate_selected = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLineSel'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLineSel'
--       },
--       italic = true
--     },
--     duplicate_visible = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       },
--       italic = true
--     },
--     duplicate = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       },
--       italic = true
--     },
--     modified = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     modified_selected = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'Normal'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       }
--     },
--     modified_visible = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     separator = {
--       fg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'TabLine'
--       }
--     },
--     separator_selected = {
--       fg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       }
--     },
--     indicator_selected = {
--       fg = {
--         attribute = 'fg',
--         highlight = 'LspDiagnosticsDefaultHint'
--       },
--       bg = {
--         attribute = 'bg',
--         highlight = 'Normal'
--       }
--     }
--   }
-- }
