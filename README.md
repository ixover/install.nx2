# install.nx2
install nginx and nodejs

### How to install Nginx and NodeJs

**commands:**

```
 curl -O https://raw.githubusercontent.com/ixover/install.nx2/master/install-nx2.sh
 sudo chmod +x install-nx2.sh
 ./install-nx2.sh
```
**or:**
```
 curl -sL https://raw.githubusercontent.com/ixover/install.nx2/master/install-nx2.sh | sudo bash -
```

### How to add new domain in Nginx
to use domain.com for website and statics.domain.com for files

**command:**
```
 curl -O https://raw.githubusercontent.com/ixover/install.nx2/master/add-domain.sh
 sudo chmod +x add-domain.sh
 ./add-domain.sh
```
**or:**
```
 curl -sL https://raw.githubusercontent.com/ixover/install.nx2/master/add-domain.sh | sudo bash -
```
PS : Its only for nodejs apps
First you have to start you app with ``` pm2 ``` or ``` forever ```
After that use command above and add domain name + port when shell asks you
