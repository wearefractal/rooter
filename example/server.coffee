connect = require "connect"
app = connect()
app.use connect.static __dirname
app.listen 8080
console.log "Server started"