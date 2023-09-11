import 'package:flutter/material.dart';

class Passager extends StatefulWidget {
  const Passager({super.key});

  @override
  State<Passager> createState() => _PassagerState();
}

class _PassagerState extends State<Passager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Resume de trajet',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEC6294)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFFEC6294),
                                size: 38.0,
                              ),
                              SizedBox(width: 70.0),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Hamida nader',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                  SizedBox(width: 50.0),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFEC6294),
                                    size: 20.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFEC6294),
                                    size: 20.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFEC6294),
                                    size: 20.0,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFEC6294),
                                    size: 20.0,
                                  ),
                                  Icon(
                                    Icons.star_border,
                                    color: Color(0xFFEC6294),
                                    size: 20.0,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Audi Ibiza noir',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF979797),
                                    ),
                                  ),
                                  SizedBox(width: 50.0),
                                  Text(
                                    '0559417723',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF979797),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 46.0, right: 46.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: Color(0xFFEC6294),
                            size: 22.0,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Alger , Algerie',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF979797),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: Color(0xFFEC6294),
                            size: 22.0,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Alger , Algerie',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF979797),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Centrer les éléments horizontalement
                          children: [
                            Text(
                              '200 KM',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF979797),
                              ),
                            ),
                            SizedBox(width: 100.0),
                            Text(
                              '550 DZ',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF979797),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centrer les étoiles horizontalement
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFFEC6294),
                            size: 42.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFEC6294),
                            size: 42.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFEC6294),
                            size: 42.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xFFEC6294),
                            size: 42.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color(0xFFEC6294),
                            size: 42.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              46.0), // Ajustez la valeur de 16.0 selon vos besoins
                      child: SingleChildScrollView(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                'Dites-nous ce que vous pensez de ce trajet',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Couleur de la bordure lorsque le champ n'est pas en focus
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                    0xFFEC6294), // Couleur de la bordure lorsque le champ est en focus
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFEC6294), // Background color
                      onPrimary: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Border radius
                      ),
                    ),
                    onPressed: () {
                      // Your button's onPressed callback
                    },
                    child: Text('Soumettre'),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
