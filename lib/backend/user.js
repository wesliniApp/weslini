const express=require('express');
var db=require('./db.js');
const router=express.Router();
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);


router.route('/registerr').post((req, res) => {
   
    const { nom } = req.body;
    const { prenom } = req.body;
    const { numero_telephone } = req.body;
    const { email } = req.body;
    const { date } = req.body;
    const { sexe } = req.body;
    const { password } = req.body;
    const { marque_vehicule } = req.body;
    const { annee } = req.body;
    const { couleur } = req.body;
    const { motorisation } = req.body;
    const { plaque } = req.body;
    const { ville } = req.body;
    const { wilaya } = req.body;
    const { daira } = req.body;
    const { commune } = req.body;
    const { permisverso } = req.body;
    const { permisrecto } = req.body;
    const { identite } = req.body;
    const { grise } = req.body;
    const { assurance } = req.body;

    console.log('Received nom:', nom);
    console.log('Received prenom:', prenom);
    console.log('Received numero:', numero_telephone);
    console.log('Received email:', email);
    console.log('Received date:', date);
    console.log('Received sexe:', sexe);
    console.log('Received password:', password);
    console.log('Received marque:', marque_vehicule);
    console.log('Received annee:', annee);
    console.log('Received couleur:', couleur);
    console.log('Received motorisation:', motorisation);
    console.log('Received plaque:', plaque);
    console.log('Received ville:', ville);
    console.log('Received wilaya:', wilaya);
    console.log('Received daira:', daira);
    console.log('Received commune:', commune);
    console.log('Received permisverso:', permisverso);
    console.log('Received permisrecto:', permisrecto);
    console.log('Received identite:', identite);
    console.log('Received grise:', grise);
    console.log('Received assurance:', assurance);

    if (sexe === "Femme") {

        const sql = `
        SELECT U.numero_telephone
        FROM Utilisateurs U
        INNER JOIN Chauffeurs C ON U.utilisateur_id = C.id_utilisateur
        WHERE U.numero_telephone = ?; `;

        db.query(sql, [numero_telephone], (err, data, fields) => {
            if (err) {
                console.error('Database error:', err);
                res.status(500).json({ success: false, message: err.message });
            } else {
                if (data.length === 0) {
                    console.log('vous pouvez sinsecrir');
                    const sql = "INSERT INTO utilisateurs(nom, prenom, numero_telephone, email, date_de_naissance, sexe, password) VALUES(?, ?, ?, ?, ?, ?, ?)";

                    db.query(sql, [nom, prenom, numero_telephone, email, date, sexe, password], (err, userData, fields) => {
                        if (err) {
                            console.error('Database error:', err);
                            res.status(500).send(JSON.stringify({ success: false, message: err.message }));
                        } else {
                            const utilisateur_id = userData.insertId;
                            const chauffeurQuery = "INSERT INTO chauffeurs (id_utilisateur, marque_vehicule, annee_vehicule, couleur_vehicule, motorisation_du_vehicule, plaque_immatriculation, ville, wilaya, daira, commune) VALUES (?,?,?,?,?,?,?,?,?,?)";
                    
                            // Appeler la base de données pour insérer le chauffeur
                            db.query(chauffeurQuery, [utilisateur_id, marque_vehicule, annee, couleur, motorisation, plaque, ville, wilaya, daira, commune], function (error, chauffeurData, fields) {
                                if (error) {
                                    // In case of an error during the second query
                                    console.error('Database error:', error);
                                    res.status(500).send(JSON.stringify({ success: false, message: error.message }));
                                } else {
                                    res.send(JSON.stringify({ success: true, message: 'register user and chauffeur' }));
                
                                    const chauffeur_id = chauffeurData.insertId;    
                                    var carteQuery = "INSERT INTO Cartes (id_chauffeur, Photo_permis_recto, Photo_permis_verso, Photo_identite, Carte_grise, Carte_assurance) VALUES (?,?,?,?,?,?)";
                    
                    
                                    // Vous devrez également récupérer l'ID du chauffeur nouvellement inséré (chauffeur_id) à partir de chauffeurData
                                    
                                    db.query(carteQuery, [chauffeur_id, permisrecto, permisverso, identite, grise, assurance], function (error, carteData, fields) {
                                        if (error) {
                                            console.error("Erreur lors de l'insertion des données de la carte : " + error);
                                        } else {
                                            if (req.files) {
                                                const permisRectoFile = req.files.permisrecto;
                                                const permisVersoFile = req.files.permisverso;
                                                const identiteFile = req.files.identite;
                                                const carteGriseFile = req.files.grise;
                                                const assuranceFile = req.files.assurance;
                        
                                                // Specify the file paths where you want to store the files
                                                const permisRectoPath = 'C:/Users/hp/Desktop/w/weslini/assets/chauffeurfiles/permis_recto/' + permisRectoFile.name;
                                                const permisVersoPath = 'C:/Users/hp/Desktop/w/weslini/assets/chauffeurfiles/permis_verso/' + permisVersoFile.name;
                                                const identitePath = 'C:/Users/hp/Desktop/w/weslini/assets/chauffeurfiles/identite/' + identiteFile.name;
                                                const carteGrisePath = 'C:/Users/hp/Desktop/w/weslini/assets/chauffeurfiles/carte_grise/' + carteGriseFile.name;
                                                const assurancePath = 'C:/Users/hp/Desktop/w/weslini/assets/chauffeurfiles/assurance/' + assuranceFile.name;
                        
                                                // Save the files to the specified paths
                                                permisRectoFile.mv(permisRectoPath, (err) => {
                                                    if (err) {
                                                        console.error(err);
                                                        return res.status(500).send(err);
                                                    }else{
                                                        console.log('Permis Recto Path:', permisRectoPath);
                                                    }
                                                });
                        
                                                permisVersoFile.mv(permisVersoPath, (err) => {
                                                    if (err) {
                                                        return res.status(500).send(err);
                                                    }
                                                });
                        
                                                identiteFile.mv(identitePath, (err) => {
                                                    if (err) {
                                                        return res.status(500).send(err);
                                                    }
                                                });
                        
                                                carteGriseFile.mv(carteGrisePath, (err) => {
                                                    if (err) {
                                                        return res.status(500).send(err);
                                                    }
                                                });
                        
                                                assuranceFile.mv(assurancePath, (err) => {
                                                    if (err) {
                                                        return res.status(500).send(err);
                                                    }
                                                });
                                                console.log('Permis Recto Path:', permisRectoPath);
                                                // Now, you can use the file paths (permisRectoPath, permisVersoPath, etc.) in your database queries
                                            }
                                            
                                            console.log("Données de la carte insérées avec succès.");
                                        }
                                    });
                    
                                }
                            });
                        }
                    });
                } else {
                    console.log('vous ne pouvez pas s insecrir car vous avez deja une compte');
                    res.json({ success: false, message: 'vous ne pouvez pas s insecrir car vous avez deja une compte' });
                }
            }
        });
    }else{
        console.log('vous ne pouvez pas s insecrir car vous avez deja une compte');
        res.json({ success: false, message: 'vous ne pouvez pas s insecrir car vous avez deja une compte' });
    }

});

let utilisateurId = null;


router.route('/login').post((req, res) => {
  const { numero_telephone } = req.body;
  const { password } = req.body;

  console.log('Received numero de telephone:', numero_telephone);
  console.log('Received password:', password);


  const sql = `
  SELECT
    utilisateur_id,
    nom,
    prenom,
    email,
    CASE
      WHEN utilisateur_id IN (SELECT id_utilisateur FROM passagers) AND utilisateur_id IN (SELECT id_utilisateur FROM chauffeurs) THEN 'passageretchaufeur'
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
        utilisateurId = data[0].utilisateur_id;
        console.log('User logged in:', utilisateurId);
/*
<<<<<<< HEAD*/
      // Include additional user information in the response
            res.json({
                success: true,
                message: 'Logged in',
                data: {
                type: data[0].type,
                nom: data[0].nom,
                prenom: data[0].prenom,
                email: data[0].email

                }
            });
        }
    }
});
});

router.route('/logout').post((req, res) => {
    console.log('decon');
    try {
      // Effectuez les opérations nécessaires pour déconnecter l'utilisateur
      // Par exemple, vous pouvez définir à null la variable utilisateur
      utilisateur = null;
  
      res.status(200).json({ success: true, message: 'Déconnexion réussie' });
    } catch (error) {
      console.error('Erreur lors de la déconnexion :', error);
      res.status(500).json({ success: false, message: 'Erreur lors de la déconnexion' });
    }
});

router.route('/profile').post((req, res) => {
  
    const { numero_telephone, password, email,nom,prenom} = req.body;
  
    console.log('Received numero_telephone:', numero_telephone);
    console.log('Received password:', password);
    console.log('Received email:', email);
    console.log('Received nom:', nom);
    console.log('Received prenom:', prenom);
    
    if (!utilisateurId) {
      return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }
  
    // Créez une requête SQL pour mettre à jour le profil dans la table 'utilisateurs'
    let updateSqlUtilisateurs = "UPDATE utilisateurs SET";
    const updateValuesUtilisateurs = [];

    if (numero_telephone) {
        updateSqlUtilisateurs += " numero_telephone = ?,";
        updateValuesUtilisateurs.push(numero_telephone);
    }

    if (email) {
        updateSqlUtilisateurs += " email = ?,";
        updateValuesUtilisateurs.push(email);
    }

    if (password) {
        // Assurez-vous que le mot de passe répond à vos critères de sécurité
        updateSqlUtilisateurs += " password = ?,";
        updateValuesUtilisateurs.push(password);
    }
    if (nom) {
      // Assurez-vous que le mot de passe répond à vos critères de sécurité
      updateSqlUtilisateurs += " nom = ?,";
      updateValuesUtilisateurs.push(nom);
    }
    if (prenom) {
        // Assurez-vous que le mot de passe répond à vos critères de sécurité
        updateSqlUtilisateurs += " prenom = ?,";
        updateValuesUtilisateurs.push(prenom);
    }

    if (updateValuesUtilisateurs.length > 0) {
        // Supprimez la virgule finale de la requête SQL
        updateSqlUtilisateurs = updateSqlUtilisateurs.slice(0, -1);

        // Ajoutez la clause WHERE pour identifier l'utilisateur
        updateSqlUtilisateurs += " WHERE utilisateur_id = ?";

        // Ajoutez l'ID de l'utilisateur à la liste des valeurs à mettre à jour
        updateValuesUtilisateurs.push(utilisateurId);

        db.query(updateSqlUtilisateurs, updateValuesUtilisateurs, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                res.status(500).json({ success: false, message: err.message });
            }
            else{
              console.log("updated");
              res.status(200).json({ success:true, message: 'profile updated' });
 
             
            }
        });
    }
  
});
router.route('/testNum').post((req, res) => {
    const { numero_telephone } = req.body;


    console.log('Received numero de telephone:', numero_telephone);


    const sql = `
            SELECT U.numero_telephone
            FROM Utilisateurs U
            INNER JOIN Chauffeurs C ON U.utilisateur_id = C.id_utilisateur
            WHERE U.numero_telephone = ?; `;
            
            
    db.query(sql, [numero_telephone], (err, data, fields) => {
        if (err) {
            console.error('Database error:', err);
            res.status(500).json({ success: false, message: err.message });
        } else {
            if (data.length === 0) {
                console.log('vous pouvez sinsecrir');
                res.status(401).json({ success: true, message: 'No matching user found' });
            } else {
                console.log('vous ne pouvez pas sinsecrir');
                res.json({ success: false, message: 'Logged in' });
            }
        }
    });
});

router.route('/testPlaque').post((req, res) => {
    const { plaque } = req.body;


    console.log('Rplaque:', plaque);


    const sql = "SELECT * FROM chauffeurs WHERE plaque_immatriculation = ?";

    db.query(sql, [plaque], (err, data, fields) => {
        if (err) {
            console.error('Database error:', err);
            res.status(500).json({ success: false, message: err.message });
        } else {
            if (data.length === 0) {
                console.log('vous pouvez sinsecrir');
                res.status(401).json({ success: true, message: 'No matching user found' });
            } else {
                console.log('vous ne pouvez pas sinsecrir');
                res.json({ success: false, message: 'Logged in' });
            }
        }
    });
});



router.route('/PassagerShow').get((req, res) => {

    
  if (!utilisateurId) {
      return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
  }

  const sqlChauffeurId = "SELECT email,nom,prenom,numero_telephone FROM utilisateurs WHERE utilisateur_id = ?";

  db.query(sqlChauffeurId, [utilisateurId], (err, results) => {
      if (err) {
          console.error('Database error:', err);
          return res.status(500).json({ success: false, message: err.message });
      } else if (results.length === 0) {
          return res.status(404).json({ success: false, message: 'Chauffeur non trouvé pour cet utilisateur' });
      }

      const { email,nom,prenom,numero_telephone } = results[0];
      res.status(200).json({ success: true, email,nom,prenom,numero_telephone });
  });
});

router.route('/persoUpdate').post((req, res) => {
    const { numero_telephone, password, email, ville, wilaya, daira, commune } = req.body;
  
    if (!utilisateurId) {
      return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }
  
    // Créez une requête SQL pour mettre à jour le profil dans la table 'utilisateurs'
    let updateSqlUtilisateurs = "UPDATE utilisateurs SET";
    const updateValuesUtilisateurs = [];
  
    if (numero_telephone) {
      updateSqlUtilisateurs += " numero_telephone = ?,";
      updateValuesUtilisateurs.push(numero_telephone);
    }
  
    if (email) {
      updateSqlUtilisateurs += " email = ?,";
      updateValuesUtilisateurs.push(email);
    }
  
    if (password) {
      // Assurez-vous que le mot de passe répond à vos critères de sécurité
      updateSqlUtilisateurs += " password = ?,";
      updateValuesUtilisateurs.push(password);
    }
  
    if (updateValuesUtilisateurs.length > 0) {
      // Supprimez la virgule finale de la requête SQL
      updateSqlUtilisateurs = updateSqlUtilisateurs.slice(0, -1);
  
      // Ajoutez la clause WHERE pour identifier l'utilisateur
      updateSqlUtilisateurs += " WHERE utilisateur_id = ?";
  
      // Ajoutez l'ID de l'utilisateur à la liste des valeurs à mettre à jour
      updateValuesUtilisateurs.push(utilisateurId);
  
      db.query(updateSqlUtilisateurs, updateValuesUtilisateurs, (err, result) => {
        if (err) {
          console.error('Database error:', err);
          res.status(500).json({ success: false, message: err.message });
        } else {
          // Mettez l'attribut validation à 0
          
        }
      });
    }

    // Si vous avez également une table 'chauffeurs' et que vous souhaitez mettre à jour des données dans cette table
    // Créez une requête SQL pour mettre à jour le profil dans la table 'chauffeurs'
    let updateSqlChauffeurs = "UPDATE chauffeurs SET";
    const updateValuesChauffeurs = [];

    if (ville) {
        updateSqlChauffeurs += " ville = ?,";
        updateValuesChauffeurs.push(ville);
    }

    if (wilaya) {
        updateSqlChauffeurs += " wilaya = ?,";
        updateValuesChauffeurs.push(wilaya);
    }

    if (daira) {
        updateSqlChauffeurs += " daira = ?,";
        updateValuesChauffeurs.push(daira);
    }

    if (commune) {
        updateSqlChauffeurs += " commune = ?,";
        updateValuesChauffeurs.push(commune);
    }

    if (updateValuesChauffeurs.length > 0) {
        // Supprimez la virgule finale de la requête SQL
        updateSqlChauffeurs = updateSqlChauffeurs.slice(0, -1);

        // Ajoutez la clause WHERE pour identifier l'utilisateur
        updateSqlChauffeurs += ", validation = 1 WHERE id_utilisateur = ?";

        // Ajoutez l'ID de l'utilisateur à la liste des valeurs à mettre à jour
        updateValuesChauffeurs.push(utilisateurId);

        db.query(updateSqlChauffeurs, updateValuesChauffeurs, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                res.status(500).json({ success: false, message: err.message });
            } else {
                if (result.affectedRows > 0) {
                    res.json({ success: true, message: 'Profil chauffeur mis à jour avec succès' });
                    
                } else {
                    res.status(404).json({ success: false, message: 'Aucun chauffeur trouvé avec cet ID' });
                }
            }
        });
    }
});

router.route('/persoShow').get((req, res) => {
    if (!utilisateurId) {
        return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }

    const sqlUtilisateurId = "SELECT email, numero_telephone FROM utilisateurs WHERE utilisateur_id = ?";
    const sqlChauffeurId = "SELECT ville, wilaya, daira, commune FROM chauffeurs WHERE id_utilisateur = ?";

    // Use Promise.all to wait for both queries to complete
    Promise.all([
        new Promise((resolve, reject) => {
            db.query(sqlUtilisateurId, [utilisateurId], (err, results) => {
                if (err) {
                    console.error('Database error:', err);
                    reject(err);
                } else if (results.length === 0) {
                    resolve({ email: null, numero_telephone: null });
                } else {
                    resolve(results[0]);
                }
            });
        }),
        new Promise((resolve, reject) => {
            db.query(sqlChauffeurId, [utilisateurId], (err, results) => {
                if (err) {
                    console.error('Database error:', err);
                    reject(err);
                } else if (results.length === 0) {
                    resolve({ ville: null, wilaya: null, daira: null, commune: null });
                } else {
                    resolve(results[0]);
                }
            });
        }),
    ])
    .then(([utilisateurData, chauffeurData]) => {
        // Combine data and send a single response
        const responseData = {
            success: true,
            email: utilisateurData.email,
            numero_telephone: utilisateurData.numero_telephone,
            ville: chauffeurData.ville,
            wilaya: chauffeurData.wilaya,
            daira: chauffeurData.daira,
            commune: chauffeurData.commune,
        };
        res.status(200).json(responseData);
    })
    .catch((error) => {
        res.status(500).json({ success: false, message: error.message });
    });
});

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
  
router.route('/vehiculeUpdate').post((req, res) => {
    const { marque, annee, couleur, motorisation, plaque } = req.body;
  
    console.log('Received numero_telephone:', marque);
    console.log('Received password:', annee);
    console.log('Received email:', couleur);
    console.log('Received password:', motorisation);
    console.log('Received email:', plaque);
    
    if (!utilisateurId) {
      return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }

    let updateSqlChauffeurs = "UPDATE chauffeurs SET";
    const updateValuesChauffeurs = [];

    if (marque) {
        updateSqlChauffeurs += " marque_vehicule = ?,";
        updateValuesChauffeurs.push(marque);
    }

    if (annee) {
        updateSqlChauffeurs += " annee_vehicule = ?,";
        updateValuesChauffeurs.push(annee);
    }

    if (couleur) {
        updateSqlChauffeurs += " couleur_vehicule = ?,";
        updateValuesChauffeurs.push(couleur);
    }

    if (motorisation) {
        updateSqlChauffeurs += " motorisation_du_vehicule = ?,";
        updateValuesChauffeurs.push(motorisation);
    }

    if (plaque) {
        updateSqlChauffeurs += " plaque_immatriculation	 = ?,";
        updateValuesChauffeurs.push(plaque);
    }

    if (updateValuesChauffeurs.length > 0) {
        // Supprimez la virgule finale de la requête SQL
        updateSqlChauffeurs = updateSqlChauffeurs.slice(0, -1);

        // Ajoutez la clause WHERE pour identifier l'utilisateur
        updateSqlChauffeurs += ", validation = 1 WHERE id_utilisateur = ?";

        // Ajoutez l'ID de l'utilisateur à la liste des valeurs à mettre à jour
        updateValuesChauffeurs.push(utilisateurId);

        db.query(updateSqlChauffeurs, updateValuesChauffeurs, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                res.status(500).json({ success: false, message: err.message });
            } else {
                if (result.affectedRows > 0) {
                    res.json({ success: true, message: 'Profil chauffeur mis à jour avec succès' });
                } else {
                    res.status(404).json({ success: false, message: 'Aucun chauffeur trouvé avec cet ID' });
                }
            }
        });
    }

  
});

router.route('/vehiculeShow').get((req, res) => {

    if (!utilisateurId) {
        return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }

    const sqlChauffeurId = "SELECT marque_vehicule, annee_vehicule, couleur_vehicule, motorisation_du_vehicule, plaque_immatriculation  FROM chauffeurs WHERE id_utilisateur = ?";

    db.query(sqlChauffeurId, [utilisateurId], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ success: false, message: err.message });
        } else if (results.length === 0) {
            return res.status(404).json({ success: false, message: 'Chauffeur non trouvé pour cet utilisateur' });
        }

        const { marque_vehicule, annee_vehicule, couleur_vehicule, motorisation_du_vehicule, plaque_immatriculation } = results[0];
        res.status(200).json({ success: true, marque_vehicule, annee_vehicule, couleur_vehicule, motorisation_du_vehicule, plaque_immatriculation });
    });
});

router.route('/carteUpdate').post((req, res) => {
    const { permisrecto, permisverso, identite, grise, assurance } = req.body;
  
    console.log('Received permisrecto:', permisrecto);
    console.log('Received permisverso:', permisverso);
    console.log('Received identite:', identite);
    console.log('Received grise:', grise);
    console.log('Received assurance:', assurance);
    
    if (!utilisateurId) {
      return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }

    // Requête SQL pour obtenir l'ID du chauffeur en fonction de l'ID de l'utilisateur
    const sqlChauffeurId = "SELECT chauffeur_id FROM chauffeurs WHERE id_utilisateur = ?";

    db.query(sqlChauffeurId, [utilisateurId], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ success: false, message: err.message });
        } else if (results.length === 0) {
            return res.status(404).json({ success: false, message: 'Chauffeur non trouvé pour cet utilisateur' });
        }

        const chauffeurId = results[0].chauffeur_id;

        let updateSqlChauffeurs = "UPDATE cartes SET";
        const updateValuesChauffeurs = [];

        if (permisrecto) {
            updateSqlChauffeurs += " Photo_permis_recto = ?,";
            updateValuesChauffeurs.push(permisrecto);
        }

        if (permisverso) {
            updateSqlChauffeurs += " Photo_permis_verso = ?,";
            updateValuesChauffeurs.push(permisverso);
        }
        	
        if (identite) {
            updateSqlChauffeurs += " Photo_identite = ?,";
            updateValuesChauffeurs.push(identite);
        }

        if (grise) {
            updateSqlChauffeurs += " Carte_grise = ?,";
            updateValuesChauffeurs.push(grise);
        }

        if (assurance) {
            updateSqlChauffeurs += " Carte_assurance = ?,";
            updateValuesChauffeurs.push(assurance);
        }

        if (updateValuesChauffeurs.length > 0) {
            // Supprimez la virgule finale de la requête SQL
            updateSqlChauffeurs = updateSqlChauffeurs.slice(0, -1);

            // Ajoutez la clause WHERE pour identifier le chauffeur
            updateSqlChauffeurs += ", validation = 1 WHERE id_chauffeur = ?";

            // Ajoutez l'ID du chauffeur à la liste des valeurs à mettre à jour
            updateValuesChauffeurs.push(chauffeurId);

            db.query(updateSqlChauffeurs, updateValuesChauffeurs, (err, result) => {
                if (err) {
                    console.error('Database error:', err);
                    res.status(500).json({ success: false, message: err.message });
                } else {
                    if (result.affectedRows > 0) {
                        res.json({ success: true, message: 'Profil chauffeur mis à jour avec succès' });
                    } else {
                        res.status(404).json({ success: false, message: 'Aucun chauffeur trouvé avec cet ID' });
                    }
                }
            });
        }
    });
});

router.route('/carteShow').get((req, res) => {

    if (!utilisateurId) {
        return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }

    const sqlCarteId = "SELECT chauffeur_id FROM chauffeurs WHERE id_utilisateur = ?";
    db.query(sqlCarteId, [utilisateurId], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ success: false, message: err.message });
        } else if (results.length === 0) {
            return res.status(404).json({ success: false, message: 'Chauffeur non trouvé pour cet utilisateur' });
        }

        const chauffeurId = results[0].chauffeur_id;
        
        const sqlChauffeurId = "SELECT Photo_permis_recto, Photo_permis_verso, Photo_identite, Carte_grise, Carte_assurance FROM cartes WHERE id_chauffeur = ?";

        db.query(sqlChauffeurId, [chauffeurId], (err, results) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ success: false, message: err.message });
            } else if (results.length === 0) {
                return res.status(404).json({ success: false, message: 'Carte non trouvée pour ce chauffeur' });
            }

            const { Photo_permis_recto, Photo_permis_verso, Photo_identite, Carte_grise, Carte_assurance } = results[0];
            res.status(200).json({ success: true, Photo_permis_recto, Photo_permis_verso, Photo_identite, Carte_grise, Carte_assurance });
            console.log(marque_vehicule);
        });
    });
});

router.route('/positions').get((req, res) => {
    console.log('Error fekkkkk');

    const query = "SELECT chauffeurs.chauffeur_id, utilisateurs.latitude, utilisateurs.longitude FROM chauffeurs JOIN utilisateurs ON chauffeurs.id_utilisateur = utilisateurs.utilisateur_id WHERE chauffeurs.etat_connexion = 1;";
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching utilisateurs:', err);
            res.status(500).json({ success: false, message: 'Internal Server Error' });
        } else {
            // Filter out objects with empty latitude or longitude
            const filteredResults = results.filter(result => result.latitude !== '' && result.longitude !== '');

            console.log('positions', filteredResults);
            res.json({ success: true, positions: filteredResults });
        }
    });
});

router.route('/update_etat_connexion').get((req, res) => {    
    console.log('Error fekkkkk', utilisateurId);

    if (!utilisateurId) {
        return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
    }
    try{
        const queryEtat = "SELECT etat_connexion FROM chauffeurs WHERE id_utilisateur = ?";
        db.query(queryEtat, [utilisateurId], (err, result) => {
            console.log('result', result);

            if (err) {
                console.error('Error etat_connexion:', err);
                return res.status(500).json({ message: 'Error etat_connexion' });
            } else {
                let newEtatConnexion;
                
                // Check if any rows were returned
                if (result.length > 0) {console.log('length');
                    // Assuming etat_connexion is a property in the result object
                    if (result[0].etat_connexion === 1) {
                        newEtatConnexion = 0;
                        console.log('newEtatConnexion0', newEtatConnexion);
                    } else {
                        newEtatConnexion = 1;
                        console.log('newEtatConnexion1', newEtatConnexion);
                    }

                    console.log('newEtatConnexion', newEtatConnexion);

                    const updateQuery = "UPDATE chauffeurs SET etat_connexion = ? WHERE id_utilisateur = ?";
                    console.log('updateQuery', updateQuery);

                    db.query(updateQuery, [newEtatConnexion, utilisateurId], (err, updateResult) => {
                        if (err) {
                            console.error('Error updating etat_connexion:', err);
                            return res.status(500).json({ message: 'Error updating etat_connexion' });
                        } else {
                            console.log('etat_connexion updated successfully');
                            return res.status(200).json({ message: 'etat_connexion updated successfully' });
                        }
                    });
                } else {
                    console.error('Error: chauffeur not found');
                    return res.status(404).json({ message: 'Chauffeur not found' });
                }
            }
        });
    }catch{
        
    }
});

async function getChauffeurId(utilisateurId) {
    const query = "SELECT chauffeur_id FROM chauffeurs WHERE id_utilisateur = ?";
    const result = await queryDatabase(query, [utilisateurId]);
    return result[0]?.chauffeur_id;
}

async function getHistorique(chauffeurId) {
    const query = "SELECT request_id, id_chauffeur, id_passager, duree, distance, DATE_FORMAT(created_at, '%d %M %Y') AS date, TIME(created_at) AS time, status, prix, wilayaDepart, wilayaDistination, localisationDepart, localisationDistination FROM ride_requests WHERE id_chauffeur = ?";
    const resultHistorique = await queryDatabase(query, [chauffeurId]);
    return resultHistorique;
}

async function getChauffeurDetails(chauffeurId) {
    const query = "SELECT * FROM Chauffeurs WHERE chauffeur_id = ?";
    const result = await queryDatabase(query, [chauffeurId]);
    return result;
}

async function getPassagerDetails(passagerId) {
    const query = "SELECT * FROM Passagers WHERE Passager_id = ?";
    const result = await queryDatabase(query, [passagerId]);
    return result[0]; // Assurez-vous qu'il y a un résultat avant d'accéder à la première ligne
}

async function queryDatabase(query, values) {
    return new Promise((resolve, reject) => {
        db.query(query, values, (err, result) => {
            if (err) {
                console.error('Erreur de requête:', err);
                reject(err);
            } else {
                console.log('Résultat de la requête:', result);
                resolve(result);
            }
        });
    });
}

async function getUtilisateurDetails(utilisateurId) {
    const query = "SELECT * FROM utilisateurs WHERE utilisateur_id = ?";
    const result = await queryDatabase(query, [utilisateurId]);
    return result[0]; // Assurez-vous qu'il y a un résultat avant d'accéder à la première ligne
}

// Utilisation dans votre route /historique
router.route('/historique').get(async (req, res) => {
    try {
        if (!utilisateurId) {
            return res.status(401).json({ success: false, message: 'Utilisateur non connecté' });
        }

        // Récupération du chauffeur_id
        const chauffeurId = await getChauffeurId(utilisateurId);

        // Récupération de l'historique
        const historiqueResult = await getHistorique(chauffeurId);

        // Compléter les détails du chauffeur et du passager pour chaque entrée dans l'historique
        for (const row of historiqueResult) {
            row.Chauffeur = await getChauffeurDetails(row.id_chauffeur);
            row.Passager = await getPassagerDetails(row.id_passager);

            // Vous pouvez maintenant accéder aux informations du passager dans row.Passager
            console.log('Informations du passager:', row.Passager);
        }
        // Compléter les détails du chauffeur, du passager, et de l'utilisateur pour chaque entrée dans l'historique
        for (const row of historiqueResult) {
        row.Chauffeur = await getChauffeurDetails(row.id_chauffeur);
        row.Passager = await getPassagerDetails(row.id_passager);
        row.UtilisateurPassager = await getUtilisateurDetails(row.Passager['id_utilisateur']);

        // Vous pouvez maintenant accéder aux informations de l'utilisateur du passager dans row.UtilisateurPassager
        console.log('Informations de l\'utilisateur du passager:', row.UtilisateurPassager);
        }

        return res.status(200).json({ message: 'Récupération de l\'historique', data: historiqueResult });
    } catch (error) {
        console.error('Erreur inattendue:', error);
        return res.status(500).json({ message: 'Erreur inattendue' });
    }
});


////////////alert
// Send ride request
const WebSocket = require('ws');
// Créez un serveur HTTP pour gérer les connexions WebSocket
const wss = new WebSocket.Server({ noServer: true });

wss.on('connection', (ws) => {
    console.log('WebSocket connection established');

    ws.on('message', async (message) => {
        try {
          const data = JSON.parse(message);
      
          const passengerId = data.passengerId;
          if (passengerId === 2 && data.type === 'alert') {
            const driverId = 9;
            const status = 'pending';
      
            const query = 'INSERT INTO ride_requests (id_passager, id_chauffeur, status) VALUES (?, ?, ?)';
            const values = [passengerId, driverId, status];
      
            db.query(query, values, (err, result) => {
              if (err) {
                console.error('Erreur lors de l\'enregistrement de l\'alerte dans la base de données:', err);
              } else {
                console.log('Alerte enregistrée dans la base de données');
                
                const response = {
                  driverId,
                  message: 'Alerte reçue du passager!',
                };
                
                // Send the response to the passenger
                ws.send(JSON.stringify(response), (error) => {
                    if (error) {
                        console.log('Error sending response:', error);
                    } else {
                        console.log('Response sent successfully');
                    }
                });
              }
            });
          }
        } catch (error) {
          console.error('Erreur lors de la manipulation du message :', error);
        }
      });
      ws.on('error', (error) => {
        console.error('WebSocket connection error:', error);
    });
});

// Associez le serveur HTTP au serveur WebSocket
server.on('upgrade', (request, socket, head) => {
  wss.handleUpgrade(request, socket, head, (ws) => {
    wss.emit('connection', ws, request);
  });
});




router.route('/sendRequest').post((req, res) => {
    console.log('11', utilisateurId);
    const { passengerId, driverId } = req.body;
    console.log('passengerId, driverId', passengerId, driverId);

    // Assuming you have a table named 'passager' and you want to get 'passager_id' based on 'id_utilisateur'
    const sqlPassagerId = `SELECT passager_id FROM passagers WHERE id_utilisateur = ?`;
    db.query(sqlPassagerId, [utilisateurId], (err, data) => {
        console.log('utilisateurId', utilisateurId);

        if (err) {
            console.error('Database error:', err);
            res.status(500).json({ success: false, message: err.message });
        } else {
            const passagerId = data[0].passager_id; // Assuming the result has the expected structure
            console.log('passagerId', passagerId);

            const sql = `INSERT INTO ride_requests (id_passager, id_chauffeur, prix, depart, distination) VALUES (?, ?, ?, ?, ?)`;
            db.query(sql, [passagerId, driverId, '1080da', 'depart', 'distination'], (err, data) => {
                console.log('passengerId, driverId1111', passengerId, driverId);

                if (err) {
                    console.error('Database error:', err);
                    res.status(500).json({ success: false, message: err.message });
                } else {
                    console.log('passengerId, driverId3333', passengerId, driverId);
                    res.json({ success: true, message: 'Ride request sent successfully' });
                }
            });
        }
    });
});


 
  // Accept/reject ride request
  router.route('/respondToRequest').post((req, res) => {
    console.log('22');

    const { requestId, status } = req.body;
  
    const sql = `UPDATE ride_requests SET status = ? WHERE request_id = ?`;
    db.query(sql, [status, requestId], (err, data) => {
      if (err) {
        console.error('Database error:', err);
        res.status(500).json({ success: false, message: err.message });
      } else {
        res.json({ success: true, message: 'Request status updated successfully' });
      }
    });
  });
/*
io.on('connection', (socket) => {
    console.log('3333333:', socket.id);
    
      
    // Listen for ride requests
    socket.on('rideRequest', (requestData) => {
      console.log('New ride request:', requestData);
  
      // Emit the event to all connected drivers
      io.emit('newRideRequest', requestData);
  
      // Log the socket ID of the client that sent the ride request
      console.log('Ride request sent to driver', requestData, socket.id);
    });
  });
*/
// ... (restante du code)

server.listen(3001, '192.168.1.37', () => {
    console.log('WebSocket server listening on ws://192.168.1.35:3001');
  });

  
module.exports = router;