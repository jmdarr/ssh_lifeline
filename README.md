# ssh_lifeline

autossh-based reverse ssh tunnel.
because somtimes my reverse dns goes down and I want to phone home.
built on centos 6 cause I'm too lazy to rebuild my server and haven't
gotten around to upgrading my setups to containers.

## references

* [markdown cheatseet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
* [matiassingers curated list of awesome READMEs](https://github.com/matiassingers/awesome-readme)
* [ai/size-limit as an example of an awesome README](https://github.com/ai/size-limit/blob/master/README.md)
* [stackexchange: "how can I make a script in /etc/init.d start at boot"](https://unix.stackexchange.com/questions/20357/how-can-i-make-a-script-in-etc-init-d-start-at-boot)
* [ssh tunneling for fun and profit](https://www.everythingcli.org/ssh-tunnelling-for-fun-and-profit-autossh/)
* [howtoforge: reverse ssh tunneling](https://www.howtoforge.com/reverse-ssh-tunneling)
* [stackexchange: "reverse ssh tunnel in config"](https://unix.stackexchange.com/questions/162093/reverse-ssh-tunnel-in-config)

## usage

`autossh` is found in the [epel](https://fedoraproject.org/wiki/EPEL) package repository:

```sh
sudo rpm -q epel-release >/dev/null 2>&1 || sudo yum install -y epel-release
```

then, install `autossh`:

```sh
sudo yum install -y autossh
```

copy the `ssh_lifeline_init.d` file to your `/etc/init.d/` directory.

```sh
sudo cp ssh_lifeline_init.d /etc/init.d/ssh_lifeline
sudo chmod 755 /etc/init.d/ssh_lifeline
```

edit the sysvinit script with your ~~favorite editor~~vim:

```sh
sudo vim /etc/init.d/ssh_lifeline
```

read the script and try to understand it best you can, I've had a few beers.
once you think you've gotten it, 
if you have questions feel free to post an issue.
