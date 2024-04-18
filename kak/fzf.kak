define-command fzf %{ evaluate-commands %{
            edit -scratch *fzf*
            map buffer normal '<ret>' ': fzf-operate edit<ret>'
            execute-keys -draft -buffer '*fzf*' '%d'
            fzf-prompt
}}

define-command fzf-prompt %{
            prompt "fzf: " -on-change %{
            	execute-keys -draft '%d'
                execute-keys -draft "! rg --files | fzf -f %val{text}<ret>"
            } nop
}

define-command fzf-operate -params 1 %{ evaluate-commands -save-regs 'a' %{
            execute-keys <a-h><a-l>"ay
            evaluate-commands %sh{
            	candidate=$(printf "$kak_reg_a" | sed "s/&/&&/g")
                case $1 in
                	(edit) printf "%s\n" "edit -existing %&$candidate&" ;;
                	(*) printf "%s\n" "fail %{Wrong command}" ;;
                esac
            }    
}}

