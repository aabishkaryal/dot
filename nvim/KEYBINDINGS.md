# Neovim Keybindings Reference

This file provides a comprehensive overview of all keybindings organized by functionality. Press `<leader>k` from anywhere in Neovim to open this file.

## Leader Key
- **Leader**: `<Space>`

---

## 🔍 Find/Files (`<leader>f`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Search files with Telescope |
| `<leader>fg` | Find Grep | Live grep search in project |
| `<leader>fb` | Find Buffers | Search open buffers |

---

## 🔎 Search (`<leader>s`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sd` | Search Diagnostics | View diagnostics with Telescope |
| `<leader>sk` | Search Keymaps | Browse keymaps with Telescope |
| `<leader>st` | Search TODO | Find TODO comments with Telescope |
| `<leader>sT` | Search TODO/FIX | Find TODO/FIX/FIXME comments |

---

## 🌳 File Explorer
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle Explorer | Toggle NvimTree |
| `<leader>o` | Focus Explorer | Focus NvimTree |

---

## 🎯 Harpoon (`<leader>h`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ha` | Add File | Add current file to harpoon |
| `<leader>hh` | Harpoon Menu | Toggle harpoon quick menu |
| `<leader>1` | Jump File 1 | Jump to harpoon file 1 |
| `<leader>2` | Jump File 2 | Jump to harpoon file 2 |
| `<leader>3` | Jump File 3 | Jump to harpoon file 3 |
| `<leader>4` | Jump File 4 | Jump to harpoon file 4 |

---

## 🐛 Debug (`<leader>d`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Toggle Breakpoint | Toggle breakpoint |
| `<leader>dc` | Continue | Continue debugging |
| `<leader>di` | Step Into | Step into function |
| `<leader>do` | Step Over | Step over line |
| `<leader>dO` | Step Out | Step out of function |
| `<leader>dr` | Toggle REPL | Toggle debug REPL |
| `<leader>dl` | Run Last | Run last debug session |
| `<leader>du` | Toggle UI | Toggle DAP UI |
| `<leader>dt` | Terminate | Terminate debug session |

### Go Debug (Go files only)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>dgt` | Debug Test | Debug current Go test |
| `<leader>dgl` | Debug Last Test | Debug last Go test |

---

## 🔧 LSP (`<leader>l`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lf` | Format | Format code with conform |
| `<leader>li` | LSP Info | Show LSP information |
| `<leader>lm` | Mason | Open Mason installer |
| `<leader>la` | Code Action | Show code actions |
| `<leader>lr` | Rename | Rename symbol |
| `<leader>ls` | Signature Help | Show signature help |
| `<leader>lq` | Quickfix | Set diagnostics to quickfix |
| `<leader>lj` | Next Diagnostic | Go to next diagnostic |
| `<leader>lk` | Prev Diagnostic | Go to prev diagnostic |

### LSP Navigation (Global)
| Key | Action | Description |
|-----|--------|-------------|
| `gD` | Declaration | Go to declaration |
| `gd` | Definition | Go to definition |
| `K` | Hover | Show hover information |
| `gI` | Implementation | Go to implementation |
| `gr` | References | Show references |
| `gl` | Line Diagnostics | Show line diagnostics |

---

## 🔧 Trouble/Diagnostics (`<leader>x`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>xx` | Diagnostics | Toggle diagnostics (Trouble) |
| `<leader>xX` | Buffer Diagnostics | Buffer diagnostics (Trouble) |
| `<leader>xL` | Location List | Toggle location list (Trouble) |
| `<leader>xQ` | Quickfix | Toggle quickfix (Trouble) |
| `<leader>xt` | TODO Trouble | Show TODOs in Trouble |
| `<leader>xT` | TODO/FIX Trouble | Show TODO/FIX/FIXME in Trouble |

### Trouble Symbols/LSP
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cs` | Symbols | Toggle symbols (Trouble) |
| `<leader>cl` | LSP References | LSP definitions/references |

---

## 🎛️ Toggle (`<leader>t`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tb` | Toggle Blame | Toggle git line blame |
| `<leader>td` | Toggle Deleted | Toggle git deleted lines |
| `]t` | Next TODO | Jump to next TODO comment |
| `[t` | Prev TODO | Jump to prev TODO comment |

---

## 🧹 Clear/Close (`<leader>c`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ch` | Clear Highlights | Clear search highlights |

---

## 🎨 Git (`<leader>g` / `<leader>h`)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>hs` | Stage Hunk | Stage git hunk |
| `<leader>hr` | Reset Hunk | Reset git hunk |
| `<leader>hS` | Stage Buffer | Stage entire buffer |
| `<leader>hu` | Undo Stage | Undo stage hunk |
| `<leader>hR` | Reset Buffer | Reset entire buffer |
| `<leader>hp` | Preview Hunk | Preview git hunk |
| `<leader>hb` | Blame Line | Show git blame for line |
| `<leader>hd` | Diff This | Diff current file |
| `<leader>hD` | Diff This ~ | Diff against HEAD~ |
| `]c` | Next Hunk | Go to next git hunk |
| `[c` | Prev Hunk | Go to prev git hunk |

### Git Text Objects
| Key | Action | Description |
|-----|--------|-------------|
| `ih` | Git Hunk | Select git hunk (text object) |

---

## ✏️ Comments
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>/` | Toggle Comment | Toggle line comment |
| `gc` | Comment Motion | Comment with motion |
| `gb` | Block Comment | Block comment with motion |

---

## 🪟 Window Management
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h>` | Left Window | Move to left window |
| `<C-j>` | Down Window | Move to down window |
| `<C-k>` | Up Window | Move to up window |
| `<C-l>` | Right Window | Move to right window |

### Window Resize
| Key | Action | Description |
|-----|--------|-------------|
| `<S-Up>` | Resize Up | Decrease height |
| `<S-Down>` | Resize Down | Increase height |
| `<S-Left>` | Resize Left | Decrease width |
| `<S-Right>` | Resize Right | Increase width |

---

## 📄 Buffer Management
| Key | Action | Description |
|-----|--------|-------------|
| `<S-l>` | Next Buffer | Go to next buffer |
| `<S-h>` | Prev Buffer | Go to previous buffer |
| `<S-q>` | Close Buffer | Close current buffer |

---

## 🧭 Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<C-d>` | Half Page Down | Scroll half page down (centered) |
| `<C-u>` | Half Page Up | Scroll half page up (centered) |

---

## 📝 Visual Mode
| Key | Action | Description |
|-----|--------|-------------|
| `<` | Outdent | Decrease indent (stay in visual) |
| `>` | Indent | Increase indent (stay in visual) |
| `p` | Paste | Paste without overwriting register |

---

## 🔍 Text Objects & Search
| Key | Action | Description |
|-----|--------|-------------|
| `<A-n>` | Next Reference | Next illuminated reference |
| `<A-p>` | Prev Reference | Prev illuminated reference |

---

## ❓ Help & Reference
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>k` | Keybindings | Open this keybindings file |

---

## Tips for Productivity

### 🎯 **Harpoon Workflow**
1. `<leader>ha` to add important files
2. `<leader>1-4` to quickly jump between them
3. `<leader>hh` to manage your harpoon list

### 🔍 **Search Workflow**
- Use `<leader>ff` for files, `<leader>fg` for content
- `<leader>st` to find TODOs across project
- `<leader>sd` to troubleshoot diagnostics

### 🐛 **Debug Workflow**
1. Set breakpoints with `<leader>db`
2. Start debugging with `<leader>dc`
3. Step through with `<leader>di/do/dO`
4. Toggle UI with `<leader>du`

### 🧹 **Code Quality**
- `<leader>lf` to format code
- `<leader>xx` to view all diagnostics
- `]t` / `[t` to navigate TODOs
- `<leader>la` for quick fixes

---

*This keybinding reference is automatically updated. Press `<leader>k` from anywhere to open it quickly.*