# ZSH

### Installation

Update and install dependencies
``` bash
sudo apt update
sudo apt install -y zsh git curl
```
### Install ohmyzsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If the installer doesn’t switch your shell automatically:
```bash
chsh -s "$(command -v zsh)"
# If you get a permission/auth error:
# sudo chsh -s "$(command -v zsh)" $USER
```

Open your config and tweak theme/plugins:

```bash
nano ~/.zshrc
```

Save and apply:
```bash
source ~/.zshrc
```

### Install plugins
```bash
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax highlighting (load this last in the plugins list)
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source ~/.zshrc
```

### Install powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

in In ~/.zshrc:

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```
