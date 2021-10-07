call sign_define("LightBulbSign", {"text" : ""})
autocmd CursorHold * lua require'nvim-lightbulb'.update_lightbulb()
