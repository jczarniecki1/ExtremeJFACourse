// Initialization
npm init
npm install --save express@3.4.4 jade // npm install --save express jade
git init
git add -A
git commit "Initial commit"

npm install coffee-script
npm install express
npm install bower
bower init
bower install jquery --save
bower install toastr --save
bower install angular angular-resource angular-route --save

npm install nodemon

bower install bootstrap

// configure sass

npm install mongoose --save

// Install MongoDB in C:\MongoDB\ and create 'data' folder inside
// Run from another console

C:\MongoDB\bin\mongod.exe --dbpath C:\MongoDB\data

// Sign up to Heroku.com and install HerokuToolbelt
// Sign up to MongoLab.com and create a database
// Connect to the new database and create a message

// >mongo ds047468.mongolab.com:47468/jfa-course -u admin -p teach-me
// >use jfa-course
// >db.messages.insert({message: 'Hello from MongoLab'})

// >set NODE_ENV=production (if you want to simulate production env)

// Log in to Heroku
// >SET PATH=%PATH%;C:\Git\bin (first login will require access to ssl-keygen.exe in C:\Git\bin)
// >heroku login

// >heroku create
// >git remote -v
// >heroku config:set NODE_ENV=production

// git push heroku master
// >heroku ps:scale web=1
// >heroku open

// Trouble shooting
// >heroku logs
// >heroku restart

// Adding SSH keys
// if no ssh key exists just run C:\Git\ssh-keygen.exe
// >heroku keys:add

npm install passport passport-local --save

// Testing with karma and mocha
npm install --save-dev karma mocha karma-mocha karma-chai-plugins
bower install --save angular-mocks#1.2.0

// add missing karma.cmd
karma init