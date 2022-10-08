if status --is-login
    # add cargo bin to path
    set -gx PATH $PATH ~/.cargo/bin
end

# init starship on fish
starship init fish | source

# install asdf
source ~/.asdf/asdf.fish
