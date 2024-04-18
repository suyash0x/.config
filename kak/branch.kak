define-command branch %{
    edit -scratch *branch*
    execute-keys -draft -buffer '*branch*' '%d'
    map buffer normal <ret> ': checkout-branch<ret>'
    eval %sh{
		printf "%s\n" "execute-keys -draft -buffer '*branch*' '! git branch'<ret>"
    }    
}

define-command checkout-branch %{
    execute-keys <a-h><a-l>"ay
    eval %sh{
    	cleaned_selection=$(printf "$kak_reg_a" | sed "s/&/&&/g")
        echo git checkout "$cleaned_selection"
    }
    execute-keys :db<ret>
}
