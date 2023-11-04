const express=require('express');
const router=express.Router();

var db=require('./db.js');

// Définissez une route pour vérifier l'existence d'un numéro de téléphone
// Définissez une route pour vérifier l'existence d'un numéro de téléphone
router.get('/verifier-numero', (req, res) => {
  // Get the 'numero_telephone' from the request query parameters
  var numero_telephone = req.query.numero_telephone;

  if (!numero_telephone) {
    return res.status(400).json({ error: 'Missing phone number' });
  }

  db.query(
    'SELECT * FROM utilisateurs WHERE numero_telephone = ?',
    [numero_telephone],
    (err, rows) => {
      if (err) {
        console.error('Erreur lors de la recherche du numéro de téléphone : ' + err.message);
        return res.status(500).json({ error: 'Erreur lors de la vérification du numéro de téléphone' });
      }

      if (rows.length > 0) {
        // Le numéro de téléphone existe déjà, renvoyer une erreur
        return res.status(400).json({ error: 'Vous avez déjà un compte' });
      }

      // Si le numéro de téléphone n'existe pas, vous pouvez envoyer une réponse appropriée
      res.status(200).json({ message: 'Vous n etes pas inscrit' });
    }
  );
});

// Define a route to change a user's password
router.put('/changePassword', (req, res) => {
  const newPassword = req.body.newPassword; // Assuming you pass the new password in the request body
  const phoneNumber = req.body.phoneNumber; // Assuming you pass the phone number in the request body

  const sql = 'UPDATE utilisateurs SET password = ? WHERE numero_telephone = ?';

  db.query(sql, [newPassword, phoneNumber], (err, result) => {
    if (err) {
      console.error('Error updating password:', err);
      res.status(500).json({ message: 'Error updating password' });
    } else {
      console.log('Password updated successfully');
      res.status(200).json({ message: 'Password updated successfully' });
    }
  });
});


router.route('/register').post((req,res)=>{
    //get params
    
    var utilisateur_id=req.body.utilisateur_id;
    var nom=req.body.nom;
    var prenom=req.body.prenom;
    var date_de_naissance=req.body.date_de_naissance;
    var email=req.body.email;
    var numero_telephone=req.body.numero_telephone;
    var sexe=req.body.sexe;

    //create query
    var sqlQuery="INSERT INTO utilisateurs(utilisateur_id,nom,prenom,date_de_naissance,email,numero_telephone,sexe) VALUES (?,?,?,?,?,?,?)";

    //call bdd to insert to add or include database
    //???? pass params here
    db.query(sqlQuery,[utilisateur_id,nom,prenom,date_de_naissance,email,numero_telephone,sexe],function(error,data,fields){
        if(error)
        {
            //if error send response here
            res.send(JSON.stringify({success:false,message:error}));
        }else{
            //if success response here
            res.send(JSON.stringify({success:true,message:'register'}))
        }
    })
});
router.route('/login').post((req, res) => {
  const { numero_telephone } = req.body;
  const { password } = req.body;

  const chauffeurs = db.query('SELECT * FROM chauffeurs');

  console.log('Received numero de telephone:', numero_telephone);
  console.log('Received password:', password);


  const sql = `
  SELECT
  CASE
    WHEN utilisateur_id IN (SELECT id_utilisateur FROM passagers) AND utilisateur_id IN (SELECT id_utilisateur FROM chauffeurs) THEN 'passager'
    WHEN utilisateur_id IN (SELECT id_utilisateur FROM chauffeurs) THEN 'chauffeur'
    WHEN utilisateur_id IN (SELECT id_utilisateur FROM passagers) THEN 'passager'
    ELSE 'utilisateur'
  END AS type
FROM utilisateurs
WHERE numero_telephone = ? AND password = ?

  `;

  db.query(sql, [numero_telephone, password], (err, data, fields) => {
      if (err) {
          console.error('Database error:', err);
          res.status(500).json({ success: false, message: err.message });
      } else {
          if (data.length === 0) {
              console.log('No matching user found');
              res.status(401).json({ success: false, message: 'No matching user found' });
          } else { 
              res.json({ success: true, message: 'Logged in', data:data[0].type});
              console.log(data[0].type);

          }
      }
  });
});


// Route pour inscrire un utilisateur passager
router.route('/utilisateurs').post((req,res)=>{
    const utilisateur = req.body;
    const { nom, prenom, numero_telephone, email, date_de_naissance, sexe, password } = utilisateur;
  
    // Vérifier le sexe de l'utilisateur
    if (sexe === "Homme") {
      // Si le sexe est "homme", renvoyer une réponse indiquant que l'inscription est interdite
      return res.status(400).json({ error: 'Inscription interdite pour les hommes' });
    }
  
    // Vérifier si le numéro de téléphone existe déjà
    db.query(
      'SELECT * FROM utilisateurs WHERE numero_telephone = ?',
      [numero_telephone],
      (err, rows) => {
        if (err) {
          console.error('Erreur lors de la recherche du numéro de téléphone : ' + err.message);
          res.status(500).json({ error: 'Erreur lors de la vérification du numéro de téléphone' });
          return;
        }
  
        if (rows.length > 0) {
          // Le numéro de téléphone existe déjà, renvoyer une erreur
          return res.status(400).json({ error: 'Vous avez déjà un compte' });
        }
  
        // Si le numéro de téléphone n'existe pas, insérer l'utilisateur dans la table "utilisateurs"
        db.query(
          'INSERT INTO utilisateurs (nom, prenom, numero_telephone, email, date_de_naissance, sexe, password) VALUES (?, ?, ?, ?, ?, ?, ?)',
          [nom, prenom, numero_telephone, email, date_de_naissance, sexe, password],
          (err, result) => {
            if (err) {
              console.error('Erreur lors de l\'insertion de l\'utilisateur : ' + err.message);
              res.status(500).json({ error: 'Erreur lors de l\'inscription de l\'utilisateur' });
              return;
            }
  
            const utilisateurID = result.insertId;
  
            // Insérer l'utilisateur dans la table "passagers"
            db.query(
              'INSERT INTO passagers (id_utilisateur, validation) VALUES (?, 1)',
              [utilisateurID],
              (err) => {
                if (err) {
                  console.error('Erreur lors de l\'insertion du passager : ' + err.message);
                  res.status(500).json({ error: 'Erreur lors de l\'inscription du passager' });
                  return;
                }
                res.json({ message: 'Utilisateur inscrit avec succès' });
              }
            );
          }
        );
      }
    );
  });
  
  
module.exports = router;