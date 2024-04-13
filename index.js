const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries.js')
const fs = require('fs')
const https = require('https')

const port = 8089

app.use(express.json())
app.use(
bodyParser.urlencoded({
extended: true,
})
)

// GET Request to root URL (/)
app.get('/', (request, response) => {
response.json({Bienvenido: "Creando API con node.js, express y postgresql"})
})

//create tbciudadano
app.post('/law_tech/ciudadano', db.createciudadano)
app.post('/law_tech/abogado', db.createabogado)
app.post('/law_tech/admin', db.createadmin)
app.post('/law_tech/cita', db.createcita)
app.post('/law_tech/comentario', db.createcomentario)

const httpsOptions = {
                key: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/privkey.pem"),
                cert: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/fullchain.pem"),
           }
            
https.createServer(httpsOptions, app).listen(port, () => {
                console.log(`Server listening in port ${port}`)
            });
