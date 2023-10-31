const express=require('express');
const router=express.Router();
var db=require('./db.js');

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
                console.log('User logged in:', data[0].nom);
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

module.exports = router;