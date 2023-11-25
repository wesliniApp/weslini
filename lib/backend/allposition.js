const express = require('express');
const mysql = require('mysql');

const app = express();
const port = 3000;

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'weslini',
});

app.use(express.json());

app.post('/store-location', (req, res) => {
  const { latitude, longitude } = req.body;
  const query = `INSERT INTO utilisateurs (latitude, longitude) VALUES (${latitude}, ${longitude})`;
  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).send('Error storing location');
    } else {
      res.send('Location stored successfully');
    }
  });
});

app.get('/get-locations', (req, res) => {
  const query = 'SELECT latitude FROM utilisateurs';
  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).send('Error fetching locations');
    } else {
      res.send(results);
      console.log(results);
    }
  });
});

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
