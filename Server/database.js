const mysql = require('mysql');
const env = process.env.NODE_ENV || 'development';

module.exports.createConnection = function createConnection() {
    let connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'bloom_server'
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