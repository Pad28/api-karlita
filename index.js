const fs = require('fs');
const https = require('https');

const express = require('express');
const bodyParser = require('body-parser');
const db = require('./queries.js')

const { config } = require("dotenv");
const { get } = require("env-var");
config();

const app = express();
const isHttps = get("IS_HTTPS").required().asBool();
const port = get("PORT").required().asPortNumber();

app.use(express.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);

// GET Request to root URL (/)
app.get('/', (request, response) => {
    response.json({ Bienvenido: "Creando API con node.js, express y postgresql" });
});

app.get('*', (request, response) => {
    response.status(404).json({ msg: "404 | No encontrado" });
});

//create tbciudadano
app.post('/law_tech/ciudadano', db.createciudadano);
app.post('/law_tech/abogado', db.createabogado);
app.post('/law_tech/admin', db.createadmin);
app.post('/law_tech/cita', db.createcita);
app.post('/law_tech/comentario', db.createcomentario);

app.post("/law_tech/auth/login", db.login)

if(!isHttps) {
    app.listen(port, () => console.log(`Server listening in port ${port}`));
} else {
    const httpsOptions = {
        key: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/privkey.pem"),
        cert: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/fullchain.pem"),
    };
                
    https.createServer(httpsOptions, app).listen(port, () => {
        console.log(`Server listening in port ${port}`)
    });
}


