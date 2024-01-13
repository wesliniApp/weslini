const mysql = require('mysql2');

// Create a connection to the database
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'weslini',
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }

  console.log('Connected to MySQL database');
  // Create ride_requests table
  const createride_requestsTableQuery = `
  CREATE TABLE IF NOT EXISTS ride_requests (
      request_id INT AUTO_INCREMENT PRIMARY KEY,
      id_passager INT,
      id_chauffeur INT,
      status ENUM('pending', 'accepted', 'rejected', 'finished') DEFAULT 'pending',
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      prix VARCHAR(255) NOT NULL,
      depart VARCHAR(255) NOT NULL,
      distination VARCHAR(255) NOT NULL,
      FOREIGN KEY (id_passager) REFERENCES passagers(passager_id),
      FOREIGN KEY (id_chauffeur) REFERENCES chauffeurs(chauffeur_id)
    );
  `;

  connection.query(createride_requestsTableQuery, (err, results) => {
    if (err) {
      console.error('Error creating ride_requests table:', err);
    } else {
      console.log('ride_requests table created successfully');
    }
  // Close the connection
  });

   // Create ride_requests table
   const createCourseTableQuery = `
   CREATE TABLE IF NOT EXISTS course (
       course_id INT AUTO_INCREMENT PRIMARY KEY,
       identifiant VARCHAR(255) NOT NULL,
       id_request INT,
       FOREIGN KEY (id_request) REFERENCES ride_requests(request_id)
     );
   `;
 
   connection.query(createCourseTableQuery, (err, results) => {
     if (err) {
       console.error('Error creating ride_requests table:', err);
     } else {
       console.log('ride_requests table created successfully');
     }
   // Close the connection
   });
  
});
