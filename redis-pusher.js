var redis = require('redis');
var publisher = redis.createClient();

const http = require('http');
const server = http.createServer((req, res) => {
  if (req.method === 'POST') {
    let body = '';
    req.on('data', chunk => {
      body += chunk.toString(); // convert Buffer to string
    });
    req.on('end', () => {
	    var obj = JSON.parse(body);
	    var channel = obj.notificationChannel;
        
	    publisher.publish(channel, body, function(){
 		    //process.exit(0);
	    });
	    //console.log(body);
	    //var obj = JSON.parse(body);
      res.end('ok, data received on channel = '+ channel);
    });
  }

});

server.listen(4000);
//publisher.publish("push:notifications:dev_", "{\"message\":\"Hello world from dev\"}", function(){
 //process.exit(0);
//});
