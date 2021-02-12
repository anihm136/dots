local indent = require"snippets.utils".match_indentation

local htmldjango = {
	["%"] = [[ {% ${1} %} ]],
	["%%"] = indent[[
	{% ${1:tag_name} %}
	${0}
	{% end$1 %}
]],
	autoescape = indent[[
	{% autoescape ${1:off} %}
		${0}
	{% endautoescape %}
]],
	block = indent[[
	{% block ${1} %}
		${0}
	{% endblock %}
]],
	comment = indent[[
	{% comment %}
		${0}
	{% endcomment %}
]],
	cycle = [[ {% cycle ${1:val1} ${2:val2} ${3:as ${4}} %} ]],
	extends = [[ {% extends "${0:base.html}" %} ]],
	filter = indent[[
	{% filter ${1} %}
		${0}
	{% endfilter %}
]],
	firstof = [[ {% firstof ${1} %} ]],
	["for"] = indent[[
	{% for ${1} in ${2} %}
		${0}
	{% endfor %}
]],
	empty = indent[[
	{% empty %}
	${0}
]],
	["if"] = indent[[
	{% if ${1} %}
		${0}
	{% endif %}
]],
	el = indent[[
	{% else %}
		${1}
]],
	elif = indent[[
	{% elif ${1} %}
		${0}
]],
	ifchanged = [[ {% ifchanged %}${1}{% endifchanged %} ]],
	ifequal = indent[[
	{% ifequal ${1} ${2} %}
		${0}
	{% endifequal %}
]],
	ifnotequal = indent[[
	{% ifnotequal ${1} ${2} %}
		${0}
	{% endifnotequal %}
]],
	include = [[ {% include "${0}" %} ]],
	load = [[ {% load ${0} %} ]],
	now = [[ {% now "${0:jS F Y H:i}" %} ]],
	regroup = [[ {% regroup ${1} by ${2} as ${0} %} ]],
	spaceless = [[ {% spaceless %}${0}{% endspaceless %} ]],
	ssi = [[ {% ssi ${0} %} ]],
	trans = [[ {% trans "${0:string}" %} ]],
	url = [[ {% url ${1} as ${0} %} ]],
	widthratio = [[ {% widthratio ${1:this_value} ${2:max_value} ${0:100} %} ]],
	with = indent[[
	{% with ${1} as ${2} %}
		${0}
	{% endwith %}
]],
}
htmldjango =
	vim.tbl_extend(
		"keep",
		htmldjango,
		require("mysnippets.html").get_snippets()
	)

local m = {}

m.get_snippets = function()
	return htmldjango
end

return m