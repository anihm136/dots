if !get(g:, 'loaded_lexima', v:false)
	finish
endif

call lexima#add_rule({'char': '<', 'input_after': '>', 'filetype': ['html', 'htmldjango', 'jinja.html', 'php']})
call lexima#add_rule({'char': '>', 'at': '\%#>', 'leave': 1, 'filetype': ['html', 'htmldjango', 'jinja.html', 'php']})
call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'delete': 1, 'filetype': ['html', 'htmldjango', 'jinja.html', 'php']})

call lexima#add_rule({'char': '{%', 'input_after': '%}', 'filetype': ['htmldjango', 'jinja.html']})
call lexima#add_rule({'char': '%}', 'at': '\%#%}', 'leave': 2, 'filetype': ['htmldjango', 'jinja.html']})
call lexima#add_rule({'char': '<BS>', 'at': '{%\%#%}', 'delete': 2, 'input': '<BS><BS>', ' filetype': ['htmldjango', 'jinja.html']})

call lexima#add_rule({'char': '{#', 'input_after': '#}', 'filetype': ['htmldjango', 'jinja.html']})
call lexima#add_rule({'char': '#}', 'at': '\%##}', 'leave': 2, 'filetype': ['htmldjango', 'jinja.html']})
call lexima#add_rule({'char': '<BS>', 'at': '{#\%##}', 'delete': 2, 'input': '<BS><BS>', ' filetype': ['htmldjango', 'jinja.html']})

call lexima#add_rule({'char': '<?', 'input_after': '?>', 'filetype': ['php']})
call lexima#add_rule({'char': '?>', 'at': '\%#?>', 'leave': 1, 'filetype': ['php']})
call lexima#add_rule({'char': '<BS>', 'at': '<?\%#?>', 'delete': 2, 'input': '<BS><BS>', 'filetype': ['php']})
