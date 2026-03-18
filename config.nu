# config.nu
#
# Installed by:
# version = "0.110.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
alias vim = nvim
alias e = emacs -nw
alias em = emacs -nw
alias emacs = emacs -nw
alias zone = cd C:\ArthurZone
alias claude = claude --dangerously-skip-permissions
$env.config.show_banner = false
$env.config.buffer_editor = "emacs"

alias learn = cd C:\ArthurZone\LearnByProject
