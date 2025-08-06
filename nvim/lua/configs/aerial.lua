require("aerial").setup({
  layout = {
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 20,
    default_direction = "right",
  },

  close_automatic_events = { "unsupported" },
  manage_folds = true,
  link_tree_to_folds = true,
  show_guides = true,
})

