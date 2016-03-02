# avit-mod

A modified version of oh-my-zsh's theme [avit](https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/avit.zsh-theme).

## Screenshots

Git branch & status & last committed time

![](https://raw.githubusercontent.com/zlsun/screenshots/master/avit-mod/1.png)

Virtualenv

![](https://raw.githubusercontent.com/zlsun/screenshots/master/avit-mod/2.png)

Background jobs & Exit code

![](https://raw.githubusercontent.com/zlsun/screenshots/master/avit-mod/3.png)


## Installation

### For [oh-my-zsh](http://ohmyz.sh/) users

First, download the [theme](https://raw.githubusercontent.com/zlsun/avit-mod/master/avit-mod.zsh-theme) into your oh-my-zsh custom theme directory.

```shell
mkdir -p ~/.oh-my-zsh/custom/themes
cd ~/.oh-my-zsh/custom/themes
wget https://raw.githubusercontent.com/zlsun/avit-mod/master/avit-mod.zsh-theme
```

Then, configure the theme in your **~/.zshrc** file:

```shell
ZSH_THEME="avit-mod"
```

### For [Antigen](https://github.com/zsh-users/antigen) users

Add the following line to your **~/.zshrc**.

```shell
antigen theme zlsun/avit-mod avit-mod
```

### For [zgen](https://github.com/tarjoilija/zgen) users

Add the following line to your **~/.zshrc**.

```shell
zgen load zlsun/avit-mod avit-mod
```

## License

[MIT License](LICENSE)

