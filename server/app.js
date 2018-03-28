const helmet = require("helmet")
const express = require('express');
const expressValidator = require("express-validator")
const path = require('path');
const bodyParser = require('body-parser');
const morgan  = require('morgan');
const cors = require('cors');

// Setting up mongoose
const mongoose = require('mongoose');
const config  = require ('./config/database');
mongoose.connect(config.database);

//const index = require('./routes/index');
//const posts = require('./routes/posts');
//const users = require('./routes/users');

const app = express();

// Log request to console
app.use(morgan('dev'));
app.use(expressValidator());

//connecting helmet
app.use(helmet())

/* View Engine
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);*/

// Set Static Folder
app.use(express.static(path.join(__dirname, 'public')));

// Body parser MW
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

// passport init
/*app.use(passport.initialize());
app.use(passport.session());

require('./config/passport')(passport);*/

// init cors
app.use(cors());

// Routes
/*app.use('/', index);
app.use('/products', posts);
app.use('/users', users);

app.use('/*', index);*/

// Localhost setup
const PORT = 3000;
app.set('port', (process.env.PORT || PORT));

app.listen(PORT, function(){
    console.log('server started at port: ' + app.get('port'));
});