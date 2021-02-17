local indent = require'snippets.utils'.match_indentation

local go = {
	v = [[ ${1} := ${2} ]],
	vr = [[ var ${1:t} ${0:string} ]],
	var = [[ var ${1} ${2} = ${3} ]],
	vars = indent[[
var (
  ${1} ${2} = ${3}
  vars$0
)
]],
	ap = [[ append(${1:slice}, ${0:value}) ]],
	case = indent[[
case ${1:value}:
  ${=helpers.insert_saved_visual()}$0

  ]],
	-- snippet co "constants with iota"
	--   const (
	--     ${1:NAME1} = iota
	--     ${0:NAME2}
	--   )
	dfr = indent[[
defer func() {
  if err := recover(); err != nil {
    ${=helpers.insert_saved_visual()}$0
  }
}()
  ]],
	im = indent[[
import (
  "${1:package}"${0}
)
  ]],
	interface = indent[[
interface ${1:name} {
  ${2}
}
]],
	['if'] = indent[[
if ${1} {
  ${=helpers.insert_saved_visual()}$0
}
]],
	ife = indent[[
if ${1} {
  ${=helpers.insert_saved_visual()}$2
} else {
  $0
}
  ]],
	el = indent[[
else {
  $0
}
  ]],
	ir = indent[[
if err != nil {
  return err
}
${0}
  ]],
	['for'] = indent[[
for ${1}{
  ${=helpers.insert_saved_visual()}$0
}
  ]],
	fori = indent[[
for ${1:i} := 0; $1 < ${2:count}; ${3:${1}++} {
  ${=helpers.insert_saved_visual()}$0
}
  ]],
	forr = indent[[
for ${1:e} := range ${2:collection} {
  ${=helpers.insert_saved_visual()}$0
}
  ]],
	fun = indent[[
func ${1:funcName}(${2}) ${3:error} {
  ${4}
}
${0}
  ]],
	fum = indent[[
func (${1:receiver} ${2:type}) ${3:funcName}(${4}) ${5:error} {
  ${6}
}
${0}
  ]],
	mk = [[ make(${1:[]string}, ${0:0}) ]],
	map = [[ map[${1:string}]${0:int} ]],
	main = indent[[
func main() {
  ${1}
}
${0}
  ]],
	pf = [[ fmt.Printf("%${1:s}\n", ${2:var}) ]],
	pl = [[ fmt.Println("${1:s}") ]],
	sl = indent[[
select {
case ${1:v1} := <-${2:chan1}
  $0
default:
}
  ]],
	sw = indent[[
switch ${1:var} {
case ${2:value1}:
  $0
default:
  
}
  ]],
	gf = indent[[
go func(${1} ${2:type}) {
  $0
}()
  ]],
	ifok = indent[[
if ${1:value}, ok := ${2:map}[${3:key}]; ok == true {
  ${4}
}
  ]],
}

local m = {}

m.get_snippets = function()
	return go
end

return m
