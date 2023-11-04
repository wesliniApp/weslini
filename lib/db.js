const express = require('express');
const mysql = require('mysql2'); // Use mysql2 library

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    port: '3306',
    database: 'weslini'
});

connection.connect(function (err) {
    if (err) throw err;
    console.log('db connected');
});

module.exports = connection;
