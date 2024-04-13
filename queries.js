const Pool = require('mysql')
const pool = Pool.createConnection({
	host:'127.0.0.1',
	user: 'mipap',
	password: 'mipape281003pol',
	database: 'law_tech',

	port: 3306,
})

//


//

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
	pool.query (`INSERT INTO tbcita (FechaCreacion, FechaReservacion, HoraCita, Direccion, Descripcion, idCiudadano, idAbogado, idStatus) VALUES ("${FechaCreacion}", "${FechaReservacion}", "${HoraCita}", "${Direccion}", "${Descripcion}", ${idCiu_int}, ${idAbo_int}, ${idSta_int})`, (error, results) => {
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



module.exports = {
     createciudadano,
     createabogado,
     createadmin,
     createcita,
     createcomentario
}



