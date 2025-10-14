-- File type icons for better visual experience
-- Provides icons for different file types in file explorers and completion menus
return {
  'nvim-tree/nvim-web-devicons',
  opts = {
    override_by_extension = {
      ["tsx"] = {
        icon = "󰛦",
        color = "#519aba",
        cterm_color = "74",
        name = "Tsx",
      },
      ["jsx"] = {
        icon = "󰛦",
        color = "#519aba", 
        cterm_color = "74",
        name = "Jsx",
      },
    },
  },
}