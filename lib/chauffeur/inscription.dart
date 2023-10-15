import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:weslini/chauffeur/chauffeurHome.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _pages,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Aligner les boutons à droite
            children: <Widget>[
              if (_currentPage > 0)
                ElevatedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child:
                      Icon(Icons.arrow_back), // Icône de flèche vers la gauche
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btngreyColor,
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
              if (_currentPage < _pages.length - 1)
                ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Icon(
                      Icons.arrow_forward), // Icône de flèche vers la droite
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedFileName;

    final List<String> sexe = ['Femme', 'Homme'];
    String selectedSexe = 'Femme';

    final List<String> ville = ['alger', 'boumerdes', 'chlef'];
    String selectedVille = 'alger';
    return Scaffold(
        body: ListView(children: <Widget>[
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
          child: DropdownButtonFormField<String>(
            hint: Text('quel est votre sexe'),
            //value: selectedSexe,
            onChanged: (newValue) {
              // Mettre à jour le sexe sélectionné lorsque l'utilisateur fait un choix
              selectedSexe = newValue!;
            },
            items: sexe.map((sexe) {
              return DropdownMenuItem<String>(
                value: sexe,
                child: Text(sexe),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
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
          child: DropdownButtonFormField<String>(
            hint: Text('quel est votre sexe'),
            //value: selectedVille,
            onChanged: (newValue) {
              // Mettre à jour le Ville sélectionné lorsque l'utilisateur fait un choix
              selectedVille = newValue!;
            },
            items: ville.map((ville) {
              return DropdownMenuItem<String>(
                value: ville,
                child: Text(ville),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
    ]));
  }
}

class Page2 extends StatelessWidget {
  Color textColor = Color(0xFF8C8C8C);
  Color primaryColor = Color(0xFFEC6294);
  Color btngreyColor = Color(0xFF8C8C8C);
  Color textColorBlack = Color.fromARGB(255, 46, 46, 46);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String? selectedFileName;

    final List<String> marque = ['gonow', 'bmw', 'cherry'];
    String selectedMarque = 'gonow';

    final List<String> annee = ['2020', '2010', '2003'];
    String selectedAnnee = '2020';

    final List<String> couleur = ['grise', 'rouge', 'blanche'];
    String selectedCouleur = 'grise';

    final List<String> motorisation = ['none', 'dsel', 'essence'];
    String selectedMotorisation = 'none';
    return Scaffold(
        body: ListView(children: <Widget>[
      SizedBox(
        height: 40.0,
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
          child: DropdownButtonFormField<String>(
            hint: Text('Marque de votre vehicule'),
            //value: selectedMarque,
            onChanged: (newValue) {
              // Mettre à jour le Marque sélectionné lorsque l'utilisateur fait un choix
              selectedMarque = newValue!;
            },
            items: marque.map((marque) {
              return DropdownMenuItem<String>(
                value: marque,
                child: Text(marque),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
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
          child: DropdownButtonFormField<String>(
            hint: Text('Année'),
            //value: selectedAnnee,
            onChanged: (newValue) {
              // Mettre à jour le Annee sélectionné lorsque l'utilisateur fait un choix
              selectedAnnee = newValue!;
            },
            items: annee.map((annee) {
              return DropdownMenuItem<String>(
                value: annee,
                child: Text(annee),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
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
          child: DropdownButtonFormField<String>(
            hint: Text('Couleur'),
            //value: selectedCouleur,
            onChanged: (newValue) {
              // Mettre à jour le Couleur sélectionné lorsque l'utilisateur fait un choix
              selectedCouleur = newValue!;
            },
            items: couleur.map((couleur) {
              return DropdownMenuItem<String>(
                value: couleur,
                child: Text(couleur),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
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
          child: DropdownButtonFormField<String>(
            hint: Text('Motorisation'),
            //value: selectedMotorisation,
            onChanged: (newValue) {
              // Mettre à jour le Motorisation sélectionné lorsque l'utilisateur fait un choix
              selectedMotorisation = newValue!;
            },
            items: motorisation.map((motorisation) {
              return DropdownMenuItem<String>(
                value: motorisation,
                child: Text(motorisation),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEC6294),
                ),
              ),
            ),
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
    ]));
  }
}

class Page3 extends StatelessWidget {
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
    String? selectedFileName;
    return Scaffold(
      body: ListView(
        children: <Widget>[
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
                  MaterialPageRoute(builder: (context) => ChauffeurHome()),
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
            height: 40.0,
          )
        ],
      ),
    );
  }
}
