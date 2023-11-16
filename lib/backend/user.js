const express=require('express');
const router=express.Router();
var db=require('./db.js');



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


    const sql = "SELECT * FROM utilisateurs WHERE numero_telephone = ? AND password = ?";

    db.query(sql, [numero_telephone,password], (err, data, fields) => {
        if (err) {
            console.error('Database error:', err);
            res.status(500).json({ success: false, message: err.message });
        } else {
            if (data.length === 0) {
                console.log('No matching user found');
                res.status(401).json({ success: false, message: 'No matching user found' });
            } else {
                utilisateurId = data[0].utilisateur_id; // Stockez la valeur dans la variable
                console.log('User logged in:', utilisateurId);
                res.json({ success: true, message: 'Logged in', data: data });
            }
        }
    });
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


module.exports = router;