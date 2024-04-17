const fs = require('fs');
const https = require('https');

const express = require('express');
const bodyParser = require('body-parser');
const db = require('./queries.js')
const { PORT, IS_HTTPS } = require("./config.js").envs;

const app = express();

app.use(express.json());
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
);


//create tbciudadano
app.post('/law_tech/ciudadano', db.createciudadano);
app.post('/law_tech/ciudadano/update/:id', db.updateCiudadano);
app.get('/law_tech/ciudadano/:id', db.getCiudadano);

app.post('/law_tech/abogado', db.createabogado);
app.get('/law_tech/abogado/:especialidad', db.getAbogadoByEspecialidad);
app.get('/law_tech/abogado/search/:id', db.getAbogado);
app.post('/law_tech/abogado/update/:id', db.updateAbogado);

app.post('/law_tech/admin', db.createadmin);

app.post('/law_tech/cita', db.createcita);
app.get('/law_tech/cita/:fecha/:id', db.getCitaByDate);
app.get('/law_tech/cita/:id', db.getCitaByIdAbogado);

app.post('/law_tech/cita/aceptar/:id', db.aceptarCitas);
app.post('/law_tech/cita/rechazar/:id', db.rechazarCita);

app.get('/law_tech/citaByDates', db.getCitasByDates);

app.post('/law_tech/comentario', db.createcomentario);
app.post("/law_tech/auth/login", db.login);

app.get('/', (request, response) => {
    response.json({ Bienvenido: "Creando API con node.js, express y postgresql" });
});

app.get('*', (request, response) => {
    response.status(404).json({ msg: "404 | No encontrado" });
});


if(!IS_HTTPS) {
    app.listen(PORT, () => console.log(`Server listening in port ${PORT}`));
} else {
    const httpsOptions = {
        key: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/privkey.pem"),
        cert: fs.readFileSync("/etc/letsencrypt/live/tux-server.ddns.net/fullchain.pem"),
    };
                
    https.createServer(httpsOptions, app).listen(PORT, () => {
        console.log(`Server listening in port ${PORT}`)
    });
}


