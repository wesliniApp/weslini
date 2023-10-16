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


module.exports = router;