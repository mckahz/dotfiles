
set fish_greeting # Disable greeting
fish_vi_key_bindings

# Set prompt
tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time='24-hour format' --rainbow_prompt_separators=Round --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=No

function fish_mode_prompt
    switch $fish_bind_mode
        case default
        set_color --bold red
        echo 'N'
        case insert
        set_color --bold green
        echo 'I'
        case replace_one
        set_color --bold green
        echo 'R'
        case replace
        set_color --bold bryellow
        echo 'R'
        case visual
        set_color --bold brmagenta
        echo 'V'
        case operator f F t T
        set_color --bold cyan
        echo 'N'
        case '*'
        set_color --bold red
        echo '?'
    end
    set_color --reset
end
