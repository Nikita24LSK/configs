local ls = require("luasnip")

-- JS snippets
ls.add_snippets("javascript", {

  ls.s("jstring", {
    ls.t("JSON.stringify("),
    ls.i(1, "value"),
    ls.t(", null, 2)"),
  }),

  -- ARFA Hooks snippets
  ls.s("print_arfa", {
    ls.t({"print(", "  `"}),
    ls.i(1, "content"),
    ls.t("\\n` "),
    ls.i(2, ""),
    ls.t({"", ");"}),
  }),

  ls.s("backtrace_native_arfa", {
    ls.t("print_native_backtrace(this.thread, "),
    ls.i(1, "0"),
    ls.t(");"),
  }),

  ls.s("header_native_arfa", {
    ls.t({"print(", "  `${this.header}\\n` "}),
    ls.i(1, ""),
    ls.t({"", ");"}),
  }),

  ls.s("hexdump_arfa", {
    ls.t("dump("), ls.i(1, "ptr"), ls.t(", "),
    ls.i(2, "length"), ls.t(", \""),
    ls.i(3, ""), ls.t("\");"),
  }),

  ls.s("bindump_arfa", {
    ls.t("dump_bin("), ls.i(1, "ptr"), ls.t(", "),
    ls.i(2, "length"), ls.t(", \""),
    ls.i(3, "filepath"), ls.t("\");"),
  }),

  ls.s("new_struct_native_arfa", {
    ls.t("new_struct("), ls.i(1, "struct_ptr"), ls.t(", structs."),
    ls.i(2, "struct_descriptor"), ls.t(", \""), ls.i(3, "name"),
    ls.t("\");"),
  }),

  ls.s("struct_native_arfa", {
    ls.t("export let "),
    ls.i(1, "name"),
    ls.t({" = {", "  name: \""}),
    ls.i(2, "printable_name"),
    ls.t({"\",", "  size: "}),
    ls.i(3, "size"),
    ls.t({",", "", "  "}),
    ls.i(4, "// Struct content"),
    ls.t({"", "};", ""}),
  }),

  ls.s("field_struct_native_arfa", {
    ls.i(1, "name"),
    ls.t({": {", "  offset: "}),
    ls.i(2, "offset"),
    ls.t({",", "  type: \""}),
    ls.i(3, "type"),
    ls.t({"\"", "},", ""}),
  }),

  ls.s("func_struct_native_arfa", {
    ls.t("_"),
    ls.i(1, "name"),
    ls.t({"() {", "  "}),
    ls.i(2, "// Func code"),
    ls.t({"", "},", ""}),
  }),

  ls.s("module_native_arfa", {
    ls.t("\""),
    ls.i(1, "name"),
    ls.t({"\": {", "", "  "}),
    ls.i(2, "// Hooks"),
    ls.t({"", "},", ""}),
  }),

  ls.s("full_addr_native_arfa", {
    ls.t("0x"),
    ls.c(1, {
      ls.f(function()
        local clipboard = vim.fn.getreg("+")
        local addr_pattern = "^[%da-fA-F]+$"
        if string.match(clipboard, addr_pattern) then
          return clipboard
        else
          return nil
        end
      end, {}),
      ls.i(nil, ""),
    }),
    ls.t({": {", "  tag: \""}), ls.i(2, "tag"), ls.t("\","),
    ls.t({"", "  enter() {", "    "}),
    ls.i(3, "// onEnter code"),
    ls.t({"", "  },"}),
    ls.t({"", "  leave() {", "    "}),
    ls.i(4, "// onLeave code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(5, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("full_name_native_arfa", {
    ls.t("\""),
    ls.i(1, "name"),
    ls.t({"\": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  enter() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onEnter code"),
    ls.t({"", "  },", "  leave() {"}),
    ls.t({"", "    "}),
    ls.i(4, "// onLeave code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(5, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("enter_addr_native_arfa", {
    ls.t("0x"),
    ls.c(1, {
      ls.f(function()
        local clipboard = vim.fn.getreg("+")
        local addr_pattern = "^[%da-fA-F]+$"
        if string.match(clipboard, addr_pattern) then
          return clipboard
        else
          return nil
        end
      end, {}),
      ls.i(nil, ""),
    }),
    ls.t({": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  enter() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onEnter code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(4, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("enter_name_native_arfa", {
    ls.t("\""),
    ls.i(1, "func_name"),
    ls.t({"\": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  enter() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onEnter code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(4, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("leave_addr_native_arfa", {
    ls.t("0x"),
    ls.c(1, {
      ls.f(function()
        local clipboard = vim.fn.getreg("+")
        local addr_pattern = "^[%da-fA-F]+$"
        if string.match(clipboard, addr_pattern) then
          return clipboard
        else
          return nil
        end
      end, {}),
      ls.i(nil, ""),
    }),
    ls.t({": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  leave() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onLeave code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(4, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("leave_name_native_arfa", {
    ls.t("\""),
    ls.i(1, "func_name"),
    ls.t({"\": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  leave() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onLeave code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(4, ""),
    ls.t({"}", "},", ""}),
  }),

  ls.s("line_native_arfa", {
    ls.t("0x"),
    ls.c(1, {
      ls.f(function()
        local clipboard = vim.fn.getreg("+")
        local addr_pattern = "^[%da-fA-F]+$"
        if string.match(clipboard, addr_pattern) then
          return clipboard
        else
          return nil
        end
      end),
      ls.i(nil, ""),
    }),
    ls.t({": {", "  tag: \""}),
    ls.i(2, "tag"),
    ls.t({"\",", "  line() {"}),
    ls.t({"", "    "}),
    ls.i(3, "// onLine code"),
    ls.t({"", "  },", "  watch: {"}),
    ls.i(4, ""),
    ls.t({"}", "},", ""}),
  }),

})
