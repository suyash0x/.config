declare-option str find_command fd
declare-option str-list find_cmd ''


define-command find -params .. %{
    evaluate-commands %{
            edit -scratch *find*
            execute-keys -draft -buffer '*find*' '%d'
            map buffer normal '<ret>' ': open-file<ret>'
	        set-option global find_cmd ''
	        set-option -add global find_cmd %opt{find_command} %arg{@}
	        eval %sh{
    	    	printf "%s\n" "execute-keys -draft ! %&$kak_opt_find_cmd&<ret>"
	        }
}}


define-command open-file  %{ evaluate-commands -save-regs 'a' %{
            execute-keys <a-h><a-l>"ay
            evaluate-commands %sh{
            	candidate=$(printf "$kak_reg_a" | sed "s/&/&&/g")
               	printf "%s\n" "edit -existing %&$candidate&" 
            }    
}}

