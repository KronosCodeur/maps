import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps/main.dart';

final List<String> images = [
  'assets/img1.jpg',
  'assets/img2.jpg',
  'assets/img3.jpg',
  'assets/img4.jpg',
  'assets/img5.jpeg',
];

final carouselSlider = CarouselSlider(
  options: CarouselOptions(
    height: double.infinity,
    aspectRatio: 16 / 9,
    viewportFraction: 1.0,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 5),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    pauseAutoPlayOnTouch: false,
    enlargeCenterPage: true,
  ),
  items: images.map((imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
    );
  }).toList(),
);

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          carouselSlider,
          Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "GoodTrips",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: HexColor("#ffd700"),
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Bienvenue sur notre application mobile dédiée aux touristes et guides touristiques ! Découvrez les meilleures destinations touristiques, trouvez les meilleurs guides locaux et vivez une expérience inoubliable en voyageant à travers le monde",
                      style: GoogleFonts.poppins(
                          color: HexColor("#ffffff"), fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bonne Decouvertes",
                          style: GoogleFonts.poppins(
                              color: HexColor("#ffffff"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor("#115173")),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePage(title: "GoodTrips"),
                                    ));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 25,
                                color: HexColor("#ffd700"),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
