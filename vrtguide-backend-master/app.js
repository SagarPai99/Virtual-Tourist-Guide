const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const redisStore = require('./config/redis')(session);
const response = require("./utils/response");

const app = express();
const server = require('http').Server(app);

var routes = require('./routes');

app.use(session({
	secret: process.env.SESSION_SECRET_KEY,
	resave: false,
	saveUninitialized: false,
	store: redisStore,
	cookie: { maxAge : 365 * 24 * 60 * 60 * 1000 }
}));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname,'public')));
app.use(response);

app.use('/', routes);

const port = process.env.PORT || 3000;

server.listen(port, err => {
	console.log(err || ('Listening on port ' + port));
});
