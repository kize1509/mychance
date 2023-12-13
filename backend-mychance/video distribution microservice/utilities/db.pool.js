const mysql = require("mysql2");

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "zoranrepic10",
  database: "mvp_mychance",
  connectionLimit: 20,
});

pool.getConnection((err, connection) => {
  if (err) throw err;
  console.log("Database connected successfully");
});

module.exports = { pool };
