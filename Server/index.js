const express =  require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
const sqlConnection = require('./database');
const socketIo = require("socket.io");

//const cors = require('cors');
var allowedOrigins = "http://localhost:8081";
var corsOptions = { 
  origin: 'http://localhost:8081',
  optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
};
// app.use(function (req, res, next) {
//     res.header('Access-Control-Allow-Origin', allowedOrigins);
//     res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept-Type');
//     res.header('Access-Control-Allow-Credentials', 'true');
//     next();
// });
//var io = require('socket.io').listen(server);//(server, {origins: allowedOrigins});
//app.use(cors(corsOptions));
app.use(bodyParser.json());
app.post('/user_check_in', (req, res) => {
    console.log('youre in');
    console.log(req);
    var user_id = req.body.user_id;
    var table_id = req.body.table_id;
    var restaurant_id = req.body.restaurant_id;
    var email = req.body.email;
    var phone_number = req.body.phone_number;
    let connection = sqlConnection.createConnection();
    let check_query = 'SELECT * FROM user_table WHERE id='+user_id+';';
    connection.query(check_query, function(err, result) {
       if(err) {
        console.log(err);
	res.status(503);
	}
       if(result) {
          let select_query = 'SELECT name, price FROM food WHERE restaurant_id=' +restaurant_id +";";
          connection.query(select_query, function(err, result)  {
                if(err) {
                   console.log(err);
                   res.status(503);
                } else if(!result) {
                    res.json("No results");
                } else {
                    res.json(result);
                }

            });
       } else {
            let query = 'INSERT INTO user_table (id, table_id,email,phone_number) VALUES (' + user_id +',' + table_id +',"'+email +'",'+ phone_number +');'
    connection.query(query, function(err, result) {
        if(!err) {
            let select_query = 'SELECT name, price FROM food WHERE restaurant_id=' +restaurant_id +";";
            connection.query(select_query, function(err, result)  {
                if(err) {
                   console.log(err);
                   res.status(503);
                } else if(!result) {
                    res.json("No results");
                } else {
                    res.json(result);
                }

            });
        }
        else {
            console.log(err);
        }
    });
         }
    })

});

var server = require('http').createServer(app);
var io = socketIo(server);//(server, {origins: allowedOrigins});


app.post('/add_order', (req, res) => {
    //
    io.emit("ServerNotifyNewOrder", res);
    
});

app.post('/user_check_out',  (req,res) => {
    let user_id = req.body.user_id;
    let query = 'SELECT u_t.table_id, r_t.total_bill FROM user_table u_t, restaurant_table r_t WHERE u_t.id=' + user_id + ' AND u_t.table_id=r_t.id;';
    let connection = sqlConnection.createConnection();
    connection.query(query, function(err, result) {
        if(err) {
            console.log(err);
            res.status(503);
         } else if(!result) {
             res.json("No results");
         } else {
	    console.log(result);
            io.emit("ServerNotifyForPayment",result);
         }
        });
});


io.on("ServerConfirmPayment", function(data) {    
    let query = 'SELECT u_t.id, r_t.total_bill FROM user_table u_t, restaurant_table r_t WHERE u_t.table_id=' + data +' AND r_t.id=' + table_id+';';
    let connection = sqlConnection.createConnection();
    connection.query(query, function(err, result) {
        if(err) {
            console.log(err);
            res.status(503);
         } else if(!result) {
             res.json("No results");
         } else {
             //make API call to worldpay
             let user_id = result.id;
             let total_bill = result.total_bill;
             let developerId = 12345678
             let version = "1.0"
             let secureNetId = "8011038"
             let secureKey = "DvAdFBTiBODp"
 
         }
        });

});


io.on('connection',function(socket){  
    console.log("A user is connected");
});

server.listen(3333);
console.log('server up on 3333')


