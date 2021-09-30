var app = require('express')();
var fs = require('fs');


const redis = require('redis');

var options = {
    key: fs.readFileSync('/etc/apache2/ssl/v/privatekey.key'),
    cert: fs.readFileSync('/etc/apache2/ssl/v/certificate.crt'),
    ca: fs.readFileSync('/etc/apache2/ssl/v/intermediate.crt')
};


var app = require('https').createServer(options)
  , io = require('socket.io').listen(app);

app.listen(3000);


function handler (req, res) {
  fs.readFile(__dirname + '/index.html',
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.html');
    }

    res.writeHead(200);
    res.end(data);
  });
}

io.on('connection', function (socket) {
    socket.emit('news', { hello: 'redis.js' });
    socket.on('my other event', function (data) {
      console.log(data);
    });

    socket.on('disconnect', function (userId) {
        var message = socket.id + ' Disconnected';
        console.log(message);
    });

    socket.on('join', function (userId) {
      //const channel = 'push:notifications:' + userId;
      const channel = userId;
      var message = 'test message';
      console.log(channel + ': '+ message);
      //socket.emit('notification', channel, message)
      socket.redisClient = redis.createClient();
      socket.redisClient.subscribe(channel);

      socket.redisClient.on('message', (channel, message) => {
        console.log(channel + ': ' + message)
        socket.emit('notification', channel, message)
      });
  });

});
