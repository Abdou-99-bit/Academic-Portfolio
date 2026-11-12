import dotenv from 'dotenv'
dotenv.config()

import pkg from 'sequelize';
const { Sequelize } = pkg;



const seq = new Sequelize(process.env.DBNAME, process.env.DBUSER, process.env.DBPASS, {
  host: process.env.HOST,
  port: process.env.DBPORT,
  dialect: 'mysql',
  logging: console.log
});

export { seq };
