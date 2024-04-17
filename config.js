const { config } = require("dotenv");
const { get } = require("env-var");
config();

const envs  = {
    IS_HTTPS: get("IS_HTTPS").required().asBool(),
    PORT: get("PORT").required().asPortNumber(),
    HOST_DB: get("HOST_DB").required().asString(),
    USER_DB: get("USER_DB").required().asString(),
    PASSWORD_DB: get("PASSWORD_DB").required().asString(),
    DATABASE: get("DATABASE").required().asString(),
}

class Validators {
    constructor(data) {
        this.data = data;
    }

    isEmail(key) {
        const regular = /^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0–9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$/;
        if (!regular.test(this.data[key])) throw 'Correo no válido';
    }

    requiredKeys(...keys) {
        keys.forEach(k => {
            if (!this.data[k]) throw `${k} faltante`;
        });
    }

    isRequired(key) {
        if (!this.data[key]) throw `${key} faltante`;
    }

    isNumber(key) {
        this.isRequired(key);
        if (isNaN(this.data[key])) throw `${key} no es un número válido`;
        this.data[key] = parseInt(this.data[key]);
    }

    capitalizar(key) {
        this.isRequired(key);
        const str = this.data[key];
        const array = str.split(' ');
        array.forEach((s, i) => {
            if (s.length === 0) return;
            s = s.toLowerCase();
            const primerCaracter = s.charAt(0).toUpperCase();
            const restoCadena = s.slice(1);
            array[i] = primerCaracter + restoCadena;
        });
        this.data[key] = array.join(' ');
    }

    isBoolean(key) {
        if (typeof this.data[key] !== 'boolean') throw `${key} no es un booleano válido`;
    }

    toUpperCase(key) {
        this.isRequired(key);
        this.data[key] = this.data[key].toUpperCase();
    }

    isDate(key) {
        this.isRequired(key);
        const newDate = new Date(this.data[key]);
        console.log(newDate);
        if (newDate.toString() === 'Invalid Date') throw `${key} no es una fecha válida`;
        this.data[key] = newDate.toISOString();
    }

    checkPattern(key, pattern) {
        this.isRequired(key);
        if (!pattern.test(this.data[key])) throw `${key} no válido`;
    }
    
    isString(key) {
        this.isRequired(key);
        if(typeof this.data[key] !== "string") throw `${key} no es una cadena valida`;
        this.data[key] = this.data[key];
    }
}

module.exports = {
    envs,
    Validators,
};
