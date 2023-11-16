const express = require('express');
const bodyParser = require('body-parser');

const cors = require('cors');
const app = express();
const router=express.Router();

var connection=require('./db.js');


app.use(cors());
app.use(bodyParser.json());
router.get('/getChauffeurs', (req, res) => {
  const sql = 'SELECT * FROM utilisateurs JOIN chauffeurs ON chauffeurs.id_utilisateur = utilisateurs.utilisateur_id;';

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('Erreur lors de l\'exécution de la requête :', err);
      res.status(500).json({ error: 'Erreur lors de la récupération des données' });
      return;
    }

    const data = results;
    res.status(200).json(data);
  });
});
router.put('/updateUserState', (req, res) => {

  const userId = req.body.userId;
  const newState = req.body.newState;

  if (!userId || newState === undefined) { // Utilisez `===` pour vérifier si newState est défini
    res.status(400).json({ error: 'Les données sont incomplètes.' });
    return;
  }

  // Préparez et exécutez la requête SQL pour mettre à jour l'état de l'utilisateur
  const sql = 'UPDATE chauffeurs SET validation = ? WHERE chauffeur_id = ?';
  connection.query(sql, [newState, userId], (err, result) => {
    if (err) {
      console.error('Erreur lors de la mise à jour de l\'état de l\'utilisateur :', err);
      res.status(500).json({ error: 'Erreur lors de la mise à jour de l\'état de l\'utilisateur' });
      return;
    }

    if (result.affectedRows === 0) {
      res.status(404).json({ error: 'Utilisateur non trouvé' });
    } else {
      res.status(200).json({ message: 'L\'état de l\'utilisateur a été mis à jour avec succès.' });
    }
  });
});

module.exports = router;
