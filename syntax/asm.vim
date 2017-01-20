" Vim syntax file
" .asm for NP4 
syn case ignore

" storage types
"syn match asmType "\.TREG"
"syn match asmType "\.long"
"syn match asmType "\.ascii"
"syn match asmType "\.asciz"
"syn match asmType "\.byte"
"syn match asmType "\.double"
"syn match asmType "\.float"
"syn match asmType "\.hword"
"syn match asmType "\.int"
"syn match asmType "\.octa"
"syn match asmType "\.quad"
"syn match asmType "\.short"
"syn match asmType "\.single"
"syn match asmType "\.space"
"syn match asmType "\.string"
"syn match asmType "\.word"


syn match asmIdentifier		"[a-z_][a-z0-9_]*"
" syn match asmLabel		"[a-z_A-Z][A-Za-z0-9_]*:"he=e-1
syn match asmLabel		"[a-z_A-Z][A-Za-z0-9_]*:"me=e-1

" Various #'s as defined by GAS ref manual sec 3.6.2.1
" Technically, the first decNumber def is actually octal,
" since the value of 0-7 octal is the same as 0-7 decimal,
" I prefer to map it as decimal:
syn match decNumber		"0\+[1-7]\=[\t\n$,; ]"
syn match decNumber		"[1-9]\d*"
syn match octNumber		"0[0-7][0-7]\+"
syn match hexNumber		"0[xX][0-9a-fA-F]\+"
syn match binNumber		"0[bB][0-1]*"

syn keyword asmTodo		contained TODO

" GAS supports various comment markers as described here:
" http://sourceware.org/binutils/docs-2.19/as/Comments.html
" I have commented out the ARM comment marker "@" by default as I think more
" people are using "@" with the .type directive. See
" http://sourceware.org/binutils/docs-2.19/as/Type.html
syn region asmComment		start="/\*" end="\*/" contains=asmTodo
"syn match asmComment		"[#;!|].*" contains=asmTodo
syn region asmCommentcxx start="//" end="$"
" syn match asmComment		"@.*" contains=asmTodo

"syn match asmInclude		"\.include"
"syn match asmCond		"\.if"
"syn match asmCond		"\.else"
"syn match asmCond		"\.endif"
"syn match asmMacro		"\.macro"
"syn match asmMacro		"\.endm"

syn match asmInclude    "#include[ <>".a-zA-Z0-9_]"
syn match asmCond		"if"
syn match asmCond		"else"
syn match asmCond		"endif"
syn match asmMacro		"MACRO"
syn match asmMacro		"ENDMACRO"


"syn match data type
syn match asmType "TREG"
syn match asmType "TOREG"
syn match asmType "OREG"
syn match asmType "COND_REG"

"syn match asmDirective		"\.[a-z][a-z]\+"
syn match asmOpcode "MovBits \|Write \|Xor \|Add \|Lookup \|JNoMatch \|Jcond \|JMaskMatch \|JMaskNoMatch \|MovImm \|FAST_IP_LOOKUP \|JNoMatch\|HALT \|Halt;"
syn match asmOpcode "Mov \|And \|Jmp \|JNC \|JNZ \|Sub\|Jstack"
syn match asmOpcode "NO_NOP\|NOP_1\|NOP_2\|NOP"
syn match asmOpcode "JMul \|Get \|Decode_MPLS \|Decode_MAC \|PutKey \|EZwaitFlag \|Call \|JZ \|SHL \|Shl \|Mov3Bits \|Mov2Bits \|PutHdrBits \|Halt"
syn match asmOpcode "Copy \|Or \|PutHdr \|Fxor \|Shr \|LookCam \|JCam"
syn match asmOpcode "GetRes \|GetCtrlBits \|JMatch \|JCond;\|WriteCond \|Cmp \|addc \|Jc \|Decode_GRE \|Decode_general \|Decode_IPv4 \|Decode_IPv6 \|JNC"
syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_asm_syntax_inits")
  if version < 508
    let did_asm_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink asmSection	Special
  HiLink asmLabel	Label
  HiLink asmComment	Comment
  HiLink asmCommentcxx	Comment
  HiLink asmTodo	Todo
  HiLink asmDirective	Statement

  HiLink asmOpcode	 PreCondit
  HiLink asmInclude	Include
  HiLink asmCond	PreCondit
  HiLink asmMacro	Macro

  HiLink hexNumber	Number
  HiLink decNumber	Number
  HiLink octNumber	Number
  HiLink binNumber	Number

  HiLink asmIdentifier Identifier
  HiLink asmType	Type

  delcommand HiLink
endif

let b:current_syntax = "asm"

" vim: ts=8
