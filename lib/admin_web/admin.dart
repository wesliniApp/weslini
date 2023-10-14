import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  int userId;
  final String nom;
  final String prenom;
  final String numeroTelephone;
  final String email;
  final DateTime dateDeNaissance;
  final String sexe;

  User({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.numeroTelephone,
    required this.email,
    required this.dateDeNaissance,
    required this.sexe,
  });
}

class Chauffeur {
  int chauffeurId;
  final String nom;
  final String prenom;
  final String numeroTelephone;
  final String email;
  final DateTime dateDeNaissance;
  final String sexe;
  int validation;

  final String marqueVehicule;
  final int anneeVehicule;
  final String couleurVehicule;
  final String motorisationDuVehicule;
  final int plaqueImmatriculation;

  Chauffeur({
    required this.chauffeurId,
    required this.nom,
    required this.prenom,
    required this.numeroTelephone,
    required this.email,
    required this.dateDeNaissance,
    required this.sexe,
    required this.validation,
    required this.marqueVehicule,
    required this.anneeVehicule,
    required this.couleurVehicule,
    required this.motorisationDuVehicule,
    required this.plaqueImmatriculation,
  });
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  List<Chauffeur> Chauffeurs = []; // List of users from the backend
  bool showListView = false;
  bool isChauffeurSelected = false; // Variable to show/hide the user list
  TextEditingController passengerSearchController = TextEditingController();
  TextEditingController chauffeurSearchController = TextEditingController();

  List<User> filteredUsers = [];
  List<Chauffeur> filteredChauffeurs =
      []; // List of users to be displayed after filtering

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/getUsers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        users = data.map((json) {
          return User(
            userId: json['utilisateur_id'],
            nom: json['nom'],
            prenom: json['prenom'],
            numeroTelephone: json['numero_telephone'],
            email: json['email'],
            dateDeNaissance: DateTime.parse(json['date_de_naissance']),
            sexe: json['sexe'],
          );
        }).toList();

        filteredUsers =
            users; // Initialise filteredUsers avec tous les utilisateurs
        showListView =
            true; // Affiche la liste des passagers après le chargement des données
        isChauffeurSelected = false; // Désélectionne la vue des chauffeurs

        // Show the user list after loading data
      });
    }
  }

  Future<void> fetchChauffeurs() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/getChauffeurs'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        Chauffeurs = data.map((json) {
          return Chauffeur(
            chauffeurId: json['chauffeur_id'],
            nom: json['nom'],
            prenom: json['prenom'],
            numeroTelephone: json['numero_telephone'],
            email: json['email'],
            dateDeNaissance: DateTime.parse(json['date_de_naissance']),
            sexe: json['sexe'],
            validation: json['validation'],
            marqueVehicule: json['marque_vehicule'],
            anneeVehicule: json['annee_vehicule'],
            couleurVehicule: json['couleur_vehicule'],
            motorisationDuVehicule: json['motorisation_du_vehicule'],
            plaqueImmatriculation: json['plaque_immatriculation'],
          );
        }).toList();

        filteredChauffeurs =
            Chauffeurs; // Initialise filteredChauffeurs avec tous les chauffeurs
        isChauffeurSelected =
            true; // Affiche la liste des chauffeurs après le chargement des données
        showListView = false; // Show the user list after loading data
      });
    }
  }

  Future<void> updateValidation(int userId, int newState) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/updateUserState'),
      body: {'userId': userId.toString(), 'newState': newState.toString()},
    );

    if (response.statusCode == 200) {
      // Mettez à jour l'état local de l'utilisateur
      final updatedChauffeur =
          Chauffeurs.firstWhere((chauffeur) => chauffeur.chauffeurId == userId);
      updatedChauffeur.validation = newState;

      // Mettez à jour l'interface utilisateur
      setState(() {});
    } else {
      // Gérer les erreurs de la requête
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xFFEC6294),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 38,
                        color: Colors.white,
                      ),
                      Text(
                        'admin',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'admin@weslini.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!showListView) {
                      fetchData();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Passager',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!isChauffeurSelected) {
                      fetchChauffeurs();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Chauffeur',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showListView)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Text(
                      'Passager', // Text label above the search bar
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFEC6294),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 20.0, 90.0, 20.0),
                    child: TextField(
                      controller: isChauffeurSelected
                          ? chauffeurSearchController
                          : passengerSearchController,
                      onChanged: (value) {
                        // Filter the users based on the search input
                        setState(() {
                          filteredUsers = users
                              .where((user) =>
                                  user.nom
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  user.email
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Recherche',
                        labelStyle: TextStyle(
                            color: Color(0xFFEC6294)), // Change label color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFEC6294)), // Change border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Change border color
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors
                                .grey), // Ajoute une bordure à la DataTable
                        borderRadius: BorderRadius.circular(
                            8.0), // Ajoute des coins arrondis
                      ),
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Nom')),
                          DataColumn(label: Text('Prénom')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Téléphone')),
                          DataColumn(label: Text('Date de Naissance')),
                          DataColumn(label: Text('Sexe')),
                        ],
                        rows: filteredUsers
                            .map((user) => DataRow(cells: [
                                  DataCell(Text(user.nom)),
                                  DataCell(Text(user.prenom)),
                                  DataCell(Text(user.email)),
                                  DataCell(Text(user.numeroTelephone)),
                                  DataCell(
                                      Text(user.dateDeNaissance.toString())),
                                  DataCell(Text(user.sexe)),
                                ]))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (isChauffeurSelected)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Text(
                      'Chauffeur', // Text label above the search bar
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFEC6294),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90.0, 20.0, 90.0, 20.0),
                    child: TextField(
                      controller: isChauffeurSelected
                          ? chauffeurSearchController
                          : passengerSearchController,
                      onChanged: (value) {
                        setState(() {
                          filteredChauffeurs = Chauffeurs.where((chauffeur) =>
                              chauffeur.nom
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              chauffeur.email
                                  .toLowerCase()
                                  .contains(value.toLowerCase())).toList();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Recherche',
                        labelStyle: TextStyle(
                            color: Color(0xFFEC6294)), // Change label color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFEC6294)), // Change border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Change border color
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors
                                .grey), // Ajoute une bordure à la DataTable
                        borderRadius: BorderRadius.circular(
                            8.0), // Ajoute des coins arrondis
                      ),
                      child: DataTable(
                        columnSpacing: 15.0, // Espace entre les colonnes
                        dataRowHeight: 50.0, // Hauteur des lignes de données
                        columns: [
                          DataColumn(label: Text('Nom')),
                          DataColumn(label: Text('Prénom')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Téléphone')),
                          DataColumn(label: Text('Date de Naissance')),
                          DataColumn(label: Text('Sexe')),
                          DataColumn(label: Text('Information véhicule')),
                          DataColumn(label: Text('Validation')),
                        ],
                        rows: filteredChauffeurs
                            .map((Chauffeur) => DataRow(cells: [
                                  DataCell(Text(Chauffeur.nom)),
                                  DataCell(Text(Chauffeur.prenom)),
                                  DataCell(Text(Chauffeur.email)),
                                  DataCell(Text(Chauffeur.numeroTelephone)),
                                  DataCell(Text(Chauffeur.dateDeNaissance
                                      .toString()
                                      .substring(0, 10))),
                                  DataCell(Text(Chauffeur.sexe)),
                                  DataCell(Text(
                                      '${Chauffeur.marqueVehicule} - ${Chauffeur.anneeVehicule} - ${Chauffeur.couleurVehicule}- ${Chauffeur.plaqueImmatriculation}- ${Chauffeur.motorisationDuVehicule}')),
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        // Inverser l'état de validation (1 devient 0, 0 devient 1)
                                        final updatedValidation =
                                            Chauffeur.validation == 1 ? 0 : 1;

                                        // Envoyer une requête PUT pour mettre à jour l'état
                                        updateValidation(Chauffeur.chauffeurId,
                                            updatedValidation);
                                      },
                                      child: Text(Chauffeur.validation == 1
                                          ? 'Oui'
                                          : 'Non'),
                                    ),
                                  )
                                ]))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
