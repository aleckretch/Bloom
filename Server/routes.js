module.exports = function(app) {
    var controller = require('./controller');
    app.post('/user_check_in/', controller.user_check_in)
}