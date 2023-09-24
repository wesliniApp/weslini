import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:weslini/chauffeur/inscription.dart';

class InscriptionChauffeur extends StatefulWidget {
  const InscriptionChauffeur({super.key});

  @override
  State<InscriptionChauffeur> createState() => _InscriptionChauffeurState();
}

class _InscriptionChauffeurState extends State<InscriptionChauffeur> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedOptionSexe;
    String? selectedOptionVille;
    String? selectedFileName; // Initialisez-le avec null
    // Vous pouvez initialiser la valeur sélectionnée

    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inscrivez-vous",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColorBlack,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "Informations de conducteur",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Nom', // C'est le placeholder
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                          hintText: 'Prenom', // C'est le placeholder
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                    hintText: 'Email', // C'est le placeholder
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                    hintText: 'Numero de telephone', // C'est le placeholder
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('quel est votre sexe'),
                value: selectedOptionSexe,
                onChanged: (String) {},
                items: <String>['femme', 'home']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('Votre ville'),
                value: selectedOptionVille,
                onChanged: (String) {},
                items: <String>['alger', 'boumerdes', 'chlef']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inscrivez-vous",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColorBlack,
              ),
            ),
          ),
          Center(
            child: Text(
              "Information de vehicule",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('Marque de vehicule'),
                value: selectedOptionVille,
                onChanged: (String) {},
                items: <String>['gonow', 'bmw', 'cherry']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('Année'),
                value: selectedOptionVille,
                onChanged: (String) {},
                items: <String>['2020', '2010', '2003']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('Couleur'),
                value: selectedOptionVille,
                onChanged: (String) {},
                items: <String>['grise', 'rouge', 'blanche']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: DropdownButton<String>(
                hint: Text('Motorisation'),
                value: selectedOptionVille,
                onChanged: (String) {},
                items: <String>['none', 'dsel', 'essence']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: primaryColor,
                ),
                decoration: InputDecoration(
                    hintText: 'Plaque d\'immatriculation',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink),
                    ) // C'est le placeholder
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              "Inssérez vos carte",
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset('assets/permis1.png'),
                                              Image.asset(
                                                  'assets/permis2.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo du permis de conduire*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          selectedFileName ?? 'Aucun fichier sélectionné',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              setState(() {
                                selectedFileName = file.name;
                              });
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/identite.png'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Photo d identité*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          selectedFileName ?? 'Aucun fichier sélectionné',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              setState(() {
                                selectedFileName = file.name;
                              });
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.help_outline), // Icône de question
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'help',
                                child: ListTile(
                                  title: Text('Comment importer un fichier'),
                                  onTap: () {
                                    // Afficher le popup avec l'image et les instructions ici
                                    Navigator.pop(
                                        context); // Fermer le menu contextuel
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Instructions d\'importation'),
                                          content: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/grise.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                              Text(
                                                  'Suivez ces instructions pour importer un fichier.'),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Fermer la boîte de dialogue
                                              },
                                              child: Text('Fermer'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ];
                          },
                          onSelected: (String value) {
                            // Gérez d'autres actions ici si nécessaire
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Carte Grise*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          selectedFileName ?? 'Aucun fichier sélectionné',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              setState(() {
                                selectedFileName = file.name;
                              });
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: screenWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Pour aligner le label à gauche
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PopupMenuButton<String>(
                        icon: Icon(Icons.help_outline), // Icône de question
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'help',
                              child: ListTile(
                                title: Text('Comment importer un fichier'),
                                onTap: () {
                                  // Afficher le popup avec l'image et les instructions ici
                                  Navigator.pop(
                                      context); // Fermer le menu contextuel
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            Text('Instructions d\'importation'),
                                        content: Column(
                                          children: [
                                            Image.asset(
                                                'assets/assurance.jpg'), // Remplacez 'assets/import_instructions.png' par le chemin de votre image
                                            Text(
                                                'Suivez ces instructions pour importer un fichier.'),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context); // Fermer la boîte de dialogue
                                            },
                                            child: Text('Fermer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          // Gérez d'autres actions ici si nécessaire
                        },
                      ),
                      Flexible(
                        child: Text(
                          'Carte Assurance*',
                          style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10), // Espace entre le label et le Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Text(
                          selectedFileName ?? 'Aucun fichier sélectionné',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Couleur de fond du bouton
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              setState(() {
                                selectedFileName = file.name;
                              });
                            }
                          },
                          child: Text("Parcourir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Devenez chauffeur',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: screenWidth < 600
                      ? 14
                      : 16, // Taille de la police (responsive)
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
