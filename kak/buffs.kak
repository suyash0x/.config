declare-option -hidden str-list buffer_list ""

define-command buffs %{ evaluate-commands %{
        edit -scratch *buffs*
		execute-keys -draft -buffer '*buffs*' '%d'
    	set-option global buffer_list '' 	
        map buffer normal <ret> ': buffer-switch<ret>'
        map buffer normal <backspace> ': buffer-delete<ret>'
        evaluate-commands -no-hooks -buffer * %{
        	eval %sh{
            	printf 'set-option -add global buffer_list "%s"' "$kak_bufname"
            }
        }

        execute-keys -draft "! echo<space>%opt{buffer_list} | tr ' ' '\n'<ret>"
}}

define-command buffer-switch %{
     execute-keys <a-h><a-l>"ay
     eval %sh{
        cleaned_selection=$(printf "$kak_reg_a" | sed "s/&/&&/g")
        printf "%s\n" "edit -existing %&$cleaned_selection&"
     }
}



define-command buffer-delete %{
	 execute-keys <a-h><a-l>"ay
     eval %sh{
        cleaned_selection=$(printf "$kak_reg_a" | sed "s/&/&&/g")
        printf "%s\n" "delete-buffer %&$cleaned_selection&"
     }
     buffs
}
