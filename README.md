ExtremeJFACourse
================

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
    #sudo apt-get install ruby
    #sudo gem install compass

    ## Listeners (not necessary if using WebStorm)
    #sass --watch --scss --compass ./public/sass/ ./public/css/
    #coffee -w -o ./server/ ./server/ &
    #coffee -w -o ./public/app/ ./public/app/ &
    #coffee -w -o ./public/app.coffee ./public/app.coffee &
    #jade server &
    #jade public &
    #nodemon server
