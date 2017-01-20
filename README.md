# vim config

1.git config

	sudo git config --system alias.ci commit
	sudo git config --system alias.co checkout
	sudo git config --system alias.br branch
	sudo git config --system color.ui true
	sudo git config --system alias.st status
	sudo git config --system core.editor vim
	sudo git config --global credential.helper store

	git config --global alias.ci commit
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.st status
	git config --global color.ui true
	git config --global core.autocrlf false
	git config --global gui.encoding utf-8
	git config --global core.quotepath off

2.vim config

1)cp -a vimconfig ~/.vim

2)ln -s .vim/vimrc .vimrc

3)sudo apt install exuberant-ctags


3.zshell

1)sudo apt-get install zsh git wget

2)wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

3)chsh -s /bin/zsh

4)sudo reboot

oh-my-zsh有大量精美主题托管在项目中，

可以在此预览 https://github.com/robbyrussell/oh-my-zsh/wiki/themes，其中最拉风的一款agnoster。

配置过程记录如下。

在 ~/.zshrc 把主题设置为 agnoster

在 ~/.zshrc 设定 DEFAULT_USER 变量可以使得即使登陆在本机
(即非SSH到远程)时也能显示“user@hostname”


4.DrawIt install

1)vim DrawIt.vba.gz

2):so %

3):q

	\di：开启DrawIt
	\ds：关闭DrawIt
	\b    矩形框
	\e    椭圆
	r <space>  删除
5.XSHELL theme

Solarized Dark.xcs
