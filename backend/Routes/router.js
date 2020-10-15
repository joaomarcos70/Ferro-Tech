const express = require("express");
const routes = express.Router();

//import das controllers 
const login = require('../Controllers/Login');

// Rota Session
routes.post('/login',login.store);

module.exports = routes;

