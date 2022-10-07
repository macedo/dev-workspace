if status --is-login
    set -gx PATH $PATH ~/.cargo/bin
end
starship init fish | source