local indent = require'snippets.utils'.match_indentation

local javascript = {
	proto = indent[[
${1:class_name}.prototype.${2:method_name} = function(${3}) {
	${=helpers.insert_saved_visual()}$0
};
]],
	fun = indent[[
function ${1:function_name}(${2}) {
	${=helpers.insert_saved_visual()}$0
}
,
asf = indent[[
async function ${1:function_name}(${2}) {
	${=helpers.insert_saved_visual()}$0
}
	]],
	anf = indent[[
function(${1}) {
	${=helpers.insert_saved_visual()}$0
}
,
vaf = indent[[
var ${1:function_name} = function(${2}) {
	${=helpers.insert_saved_visual()}$0
};
	]],
	vf = indent[[
var ${1:function_name} = function $1(${2}) {
	${=helpers.insert_saved_visual()}$0
};
	]],
	['(f'] = indent[[
(function(${1}) {
	${=helpers.insert_saved_visual()}$0
}(${2}));
]],
	['if'] = indent[[
if (${1:true}) {
	${=helpers.insert_saved_visual()}$0
}
]],
	ife = indent[[
if (${1:true}) {
	${2=helpers.insert_saved_visual()}
} else {
	$0
}
]],
	ter = [[ ${1:/* condition */} ? ${2:/* if true */} : ${0} ]],
	switch = indent[[
switch (${1:expression}) {
	case '${3:case}':
		${4}
		break;
	${0}
	default:
		${2}
}
]],
	case = indent[[
case '${1:case}':
	${=helpers.insert_saved_visual()}$0
	break;
]],
	try = indent[[
try {
	${=helpers.insert_saved_visual()}
} catch (${1:e}) {
	$0
}
]],
	tryf = indent[[
try {
	${=helpers.insert_saved_visual()}
} catch (${1:e}) {
	$0
} finally {
}
,
ret = [[ return ${0:result}; ]],
	['for'] = indent[[
for (var ${1:i} = 0, ${2:len} = ${3:Things.length}; $1 < $2; $1++) {
	${=helpers.insert_saved_visual()}$0
}
]],
	wh = indent[[
while (${1:/* condition */}) {
	${=helpers.insert_saved_visual()}$0
}
	]],
	['do'] = indent[[
do {
	${=helpers.insert_saved_visual()}$0
} while ($1);
For in loop
]],
	fori = indent[[
for (var ${1:prop} in ${2:object}) {
	${0:$2[$1]}
}
]],
	qs = [[ ${1:document}.querySelector('${0}') ]],
	qsa = [[ ${1:document}.querySelectorAll('${0}') ]],
	cl = [[ console.log(${0}); ]],
	cd = [[ console.debug(${0}); ]],
	ce = [[ console.error(${0}); ]],
	cw = [[ console.warn(${0}); ]],
	ci = [[ console.info(${0}); ]],
	ct = [[ console.trace(${0:label}); ]],
	ctime = indent[[
console.time("${1:label}");
${=helpers.insert_saved_visual()}$0
console.timeEnd("$1");
	]],
	ctimestamp = [[ console.timeStamp("$0"); ]],
	ca = [[ console.assert(${1:expression}, ${0}); ]],
	cclr = [[ console.clear(); ]],
	cdir = [[ console.dir(${0}); ]],
	ctbl = [[ console.table($0); ]],
	im = [[ import ${1} from '${2:$1}'; ]],
	imas = [[ import * as ${1} from '${2:$1}'; ]],
	imm = [[ import { ${1} } from '${2}'; ]],
	foro = indent[[
for (const ${1:prop} of ${2:object}) {
	${0}
}
]],
	forl = indent[[
for (let ${1:prop} of ${2:object}) {
	${0}
}
]],
}

local m = {}

m.get_snippets = function()
	return javascript
end

return m
