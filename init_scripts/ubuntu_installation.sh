#!/bin/bash

sudo apt-get install npm nodejs-legacy git  &&
sudo apt-get install python-software-properties &&
sudo add-apt-repository ppa:chris-lea/node.js &&
sudo apt-get update &&
sudo apt-get install nodejs nodejs-legacy npm mongodb

mkdir ~/Projects
git clone https://github.com/jczarniecki1/ExtremeJFACourse.git
cd ~/Projects/ExtremeJFACourse
sudo npm install &&
sudo npm install -g bower &&
sudo npm install -g nodemon &&
sudo npm install -g coffee-script &&
sudo npm install -g coffeelint

#sudo apt-get install htop
#pgrep mongod
#sudo kill mongod
#mkdir .mongodb
#mkdir .mongodb/data
#mongod --dbpath ~/.mongodb/data &

## Sass
#sudo apt-get install ruby ruby1.9.1-dev
#sudo gem install compass
#sudo gem install --version '~> 0.9' rb-inotify

# ScssLint
#sudo gem install scss-lint
#scss-lint ./public/sass/**/*.scss

## Listeners (not necessary if using WebStorm)
#sass --watch --scss --compass ./public/sass/ ./public/css/
#coffee -w -o ./server/ ./server/ &
#coffee -w -o ./public/app/ ./public/app/ &
#coffee -w -o ./public/app.coffee ./public/app.coffee &
#jade server &
#jade public &
#nodemon server

#sudo killall node

## Heroku 
#sudo apt-get install rake
#sudo wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
#heroku login
#heroku git:remote --app arcane-reaches-7524
#sudo apt-get install openssh-client
#ssh-keygen -t rsa
#heroku keys:add

## Documentation
#sudo apt-get install python-setuptools
#sudo easy_install pip
#sudo pip install pygments
#sudo npm install groc
