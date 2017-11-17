copy_dotfiles:
  # add aliases for dotfiles
  for file in $(shell find $(CURDIR) -depth 1 -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".*.swp") do
    f=$$(basename $$file)
    ln -sfn $$file $(HOME)/$$f
  done

install_dependencies:
# COPY PASTE on REMOTE LINUX MACHINES
  # check if on linux
  if [[ $(uname -s) == Linux* ]]; then
    # if ~/bin doesn't exist, create it
    [ -d ~/bin ] || mkdir ~/bin

    # symlink pbcopy and paste to the ~/bin directory
    ln -sfn ~/dotfiles/{pbcopy,pbpaste} ~/bin

    echo 'pbcopy and pbpaste linked to ~/bin directory. See readme for instructions to configure your mac.';
  fi

# VIM-PLUG installation
  if [[ $(uname -s) == Linux* ]]; then
    # if you have nvim, use the nvim installation command
    [ -x nvim ] && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi



# TODO:
# * finish vim-plug installation
# * install tpm
# * source the dotfiles after copying them over
