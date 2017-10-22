const mysql = require('mysql');
const env = process.env.NODE_ENV || 'development';
const config = require('../config')[env];

module.exports.createConnection = function createConnection() {
    let connection = mysql.createConnection({
        host: config.database.host,
        user: config.database.user,
        password: config.database.pass,
        database: config.database.db
    });
    connection.connect(function(err){
        if(!err) {
            console.log("Database is connected ...");
        } else {
            console.log("Error connecting database ...");
        }
    });
    return connection;
};


module.exports.createConnectionMultipleStmts = function createConnectionMultipleStmts() {
    let connection = mysql.createConnection({
        host: config.database.host,
        user: config.database.user,
        password: config.database.pass,
        database: config.database.db,
        multipleStatements: true
    });
    connection.connect(function(err){
        if(!err) {
            console.log("Database is connected ...");
        } else {
            console.log("Error connecting database ...");
        }
    });
    return connection;
};