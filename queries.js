const Pool = require('mysql')
const { DATABASE, HOST_DB, PASSWORD_DB, USER_DB } = require('./config').envs;
const { Validators } = require('./config');

const pool = Pool.createConnection({
	host: HOST_DB,
	user: USER_DB,
	password: PASSWORD_DB,
	database: DATABASE,
	port: 3306,
})

const asyncQuery = async(sqlQuery) => {
	return new Promise((resolve, reject) => {
		pool.query (sqlQuery, (error, results) => {
			if (error) return reject(error);
			resolve(results);
		});
	})
}

const createciudadano = (request, response) => {
	const { idRol, Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Contrasena, Direccion } = request.body
	console.log(idRol)
	const idRol_int = parseInt(idRol)

	pool.query (`INSERT INTO tbciudadano (idRol, Nombre, ApellidoPaterno, ApellidoMaterno, Telefono, Correo, Contrasena, Direccion) VALUES (${idRol_int}, "${Nombre}", "${ApellidoPaterno}", "${ApellidoMaterno}", "${Telefono}", "${Correo}", "${Contrasena}", "${Direccion}")`, (error, results) => {
     if (error){
	throw error
     }
     response.status(201).json({msg: 'El ciudadano ha sido agregado a la base de datos correctamente'})
    })
}

const createabogado = (request, response) => {
	const {idRol, Nombre, ApellidoPaterno, ApellidoMaterno, Cedula, Especialidad, Telefono, Correo, Contrasena, Direccion, Descripcion} = request.body
	const idRol_int = parseInt(idRol)
	pool.query (`INSERT INTO tbabogado (idRol, Nombre, ApellidoPaterno, ApellidoMaterno, Cedula, Especialidad, Telefono, Correo, Contrasena, Direccion, Descripcion) VALUES (${idRol_int}, "${Nombre}","${ApellidoPaterno}","${ApellidoMaterno}", "${Cedula}", "${Especialidad}", "${Telefono}", "${Correo}", "${Contrasena}", "${Direccion}", "${Descripcion}")`, (error,results) => {
	if (error){
	   throw error
	}
	response.status(201).json({msg: 'El abogado ha sido agregado a la base de datos correctamente'})
	})
}


const createadmin = (request, response) => {
	const {Nombre, ApellidoPaterno, ApellidoMaterno, Clave, Correo, Contrasena, idRol} = request.body
	const idRol_int = parseInt(idRol)
	pool.query (`INSERT INTO tbadmin (Nombre, ApellidoPaterno, ApellidoMaterno, Clave, Correo, Contrasena, idRol) VALUES ("${Nombre}", "${ApellidoPaterno}", "${ApellidoMaterno}", "${Clave}", "${Correo}","${Contrasena}", ${idRol_int})`, (error, results) =>{
	if (error){
	   throw error
	}
	response.status(201).json({msg: 'El admin ha sido agregado a la base de datos correctamente'})
	})

}

const createcita = (request, response) => {
	const {FechaCreacion, FechaReservacion, HoraCita, Direccion, Descripcion, idCiudadano, idAbogado, idStatus} = request.body
	const idCiu_int = parseInt(idCiudadano)
	const idAbo_int = parseInt(idAbogado)
	const idSta_int = parseInt(idStatus)
	pool.query (`INSERT INTO tbcita (FechaCreacion, FechaReservacion, HoraCita, Direccion, Descripcion, idCiudadano, idAbogado, idStatus) VALUES ('${FechaCreacion}', '${FechaReservacion}', '${HoraCita}', '${Direccion}', '${Descripcion}', ${idCiu_int}, ${idAbo_int}, ${idSta_int})`, (error, results) => {
	if (error){
	   throw error
	}
	response.status(201).json({msg: 'La cita se creo correctamente'})
	})
}



const createcomentario = (request, response) => {
	const {idCiudadano, idAbogado, Comentario, idCalificacion } = request.body
	const idCiu_int = parseInt (idCiudadano)
	const idAbo_int = parseInt (idAbogado)
	const idCal_int = parseInt (idCAlificacion)
	pool.query (`INSERT INTO tbcomentario (idCiudadano, idAbogado, Comentario, idCalificacion) VALUES (${idCiu_int}, ${idAbo_int}, "${Comentario}", ${idCal_int})`, (error, results) => {
	if (error){
	    throw error
	}
	response.status(201).json({msg: 'El comentario se ha guardado con exito'})
	})
}

const login = async(request, response) => {
	const { Correo, Contrasena } = request.body;
	
	let results = await asyncQuery(`
		SELECT c.*, r.idRol, r.Descripcion as DescripcionRol
		FROM tbciudadano c
		JOIN tbrol r ON c.idRol = r.idRol
		WHERE c.Correo = '${Correo}'
	`);
	
	if (!results[0]) results = await asyncQuery(`
		SELECT a.*, r.idROl, r.Descripcion as DescripcionRol
		FROM tbabogado a
		JOIN tbrol r ON a.idRol = r.idRol
		WHERE a.Correo = '${Correo}'
	`);

	if(!results[0]) return response.status(404).json({msg: "Credenciales no validas"});
	if(results[0].Contrasena !== Contrasena) return response.status(404).json({msg: "Credenciales no validas"});
	response.status(201).json({msg: "Autenticación exitosa", results})
}

const getCitasByDates = async(req, res) => {
	const { fechaInicio, fechaFin } = req.query;

	try {
		const validators = new Validators({ fechaFin, fechaInicio });
		console.log(validators.data);
		validators.isDate("fechaInicio");
		validators.isDate("fechaFin");

		let primerIntervalo = validators.data.fechaInicio.split('T')[0];
		console.log(primerIntervalo);
		let segundoIntervalo = validators.data.fechaFin.split('T')[0];
		const results = await asyncQuery(`
			SELECT c.idCita, c.FechaReservacion, cl.Nombre, cl.ApellidoPaterno, cl.ApellidoMaterno
				FROM tbcita c
				JOIN tbciudadano cl ON c.idCiudadano = cl.idCiudadano
				WHERE c.FechaReservacion BETWEEN '${primerIntervalo}' AND '${segundoIntervalo}';
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const getCitaByDate = async(req, res) => {
	const { fecha, id } = req.params;

	try {
		const validators = new Validators({ id, fecha });
		validators.isRequired("id", "fecha");
		validators.isDate("fecha");
		validators.isNumber("id")

		const results = await asyncQuery(`
			SELECT c.idCita, c.FechaReservacion, cl.Nombre, cl.ApellidoPaterno, cl.ApellidoMaterno
			FROM tbcita c
			JOIN tbciudadano cl ON c.idCiudadano = cl.idCiudadano
			JOIN tbabogado a ON c.idAbogado = a.idAbogado
			WHERE DATE(c.FechaReservacion) = '${fecha}'
			AND a.idAbogado = ${id};
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const getCitaByIdAbogado = async(req, res) => {
	const { id } = req.params;

	try {
		const validators = new Validators({ id });
		validators.isNumber("id")

		const results = await asyncQuery(` 
			SELECT c.idCita, c.FechaReservacion, cl.Nombre, cl.ApellidoPaterno, cl.ApellidoMaterno
			FROM tbcita c
			JOIN tbciudadano cl ON c.idCiudadano = cl.idCiudadano
			JOIN tbabogado a ON c.idAbogado = a.idAbogado
			WHERE a.idAbogado = ${id} AND c.idStatus = 2;
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const aceptarCitas = async(req, res) => {
	const { id } = req.params;
	try {
		const validators = new Validators({ id });
		validators.isNumber("id")
		
		const results = await asyncQuery(` 
		UPDATE tbcita
		SET idStatus = 1
		WHERE idCita = ${validators.data.id};
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const rechazarCita = async(req, res) => {
	const { id } = req.params;
	try {
		const validators = new Validators({ id });
		validators.isNumber("id")

		const results = await asyncQuery(` 
		UPDATE tbcita
		SET idStatus = 3
		WHERE idCita = ${validators.data.id};
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const getAbogadoByEspecialidad = async(req, res) => {
	const { especialidad } = req.params;

	try {
		const validators = new Validators({ especialidad });
		validators.requiredKeys("especialidad");
		validators.isString("especialidad");

		const results = await asyncQuery(`
			SELECT idAbogado, Nombre, ApellidoPaterno, ApellidoMaterno, Cedula, Direccion 
			FROM tbabogado
			WHERE especialidad = '${especialidad}';
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const getCiudadano = async(req, res) => {
	const { id } = req.params;
	try {
		const validators = new Validators({ id });
		validators.isNumber("id")

		const results = await asyncQuery(` 
			SELECT * FROM tbciudadano WHERE idCiudadano = ${id};
		`);

		res.json({ results });
	} catch (error) {
		console.log(error);
		return res.status(404).json({ error: error })		
	}
}

const updateCiudadano = async (req, res) => {
    const { body } = req;
    const { id } = req.params;
    try {
        const results = await asyncQuery(`
            SELECT * FROM tbciudadano WHERE idCiudadano = ${id};
        `);

        const update = await asyncQuery(`
            UPDATE tbciudadano SET 
            Nombre = '${body.Nombre ? body.Nombre : results[0].Nombre}',
            ApellidoPaterno = '${body.ApellidoPaterno ? body.ApellidoPaterno : results[0].ApellidoPaterno}',
            ApellidoMaterno = '${body.ApellidoMaterno ? body.ApellidoMaterno : results[0].ApellidoMaterno}',
            Telefono = '${body.Telefono ? body.Telefono : results[0].Telefono}',
            Correo = '${body.Correo ? body.Correo : results[0].Correo}',
            Contrasena = '${body.Contrasena ? body.Contrasena : results[0].Contrasena}',
            Direccion = '${body.Direccion ? body.Direccion : results[0].Direccion}'
            WHERE idCiudadano = ${id};
        `);

        res.status(200).json({ message: "Ciudadano actualizado correctamente" });
    } catch (error) {
        console.log(error);
        return res.status(404).json({ error: error });
    }
};


module.exports = {
     createciudadano,
     createabogado,
     createadmin,
     createcita,
     createcomentario,
	 login,
	 getCitasByDates,
	 getCitaByDate,
	 getCitaByIdAbogado,
	 getAbogadoByEspecialidad,
	 aceptarCitas,
	 rechazarCita,
	 getCiudadano,
	 updateCiudadano
}


