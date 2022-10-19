import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/front-end/widgets/dev_cards.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late List devCards = [
    DevCard('Abhirup Basak', 0xff80ed99, 'abhirup basak.jpg', 150,
        'https://www.linkedin.com/in/abhirup-basak-ab5357221/'),
    DevCard('Agniban Saha', 0xffff9b85, 'agniban saha.jpg', 150,
        'https://www.linkedin.com/in/agniban-saha-804b2320a/'),
    DevCard('Deep Sarkar', 0xffaaf683, 'deep sarkar.jpg', 150,
        'https://www.linkedin.com/in/deep-sarkar-6a3588219/'),
    DevCard('Sharmistha Das', 0xffbde0fe, 'sarmistha das.jpg', 150,
        'https://www.linkedin.com/in/sharmistha-das-a639031b5/'),
    /*DevCard('Kingshuk Saha', 0xffee6055, 'kingshuk saha.jpg', 150,
        'https://www.linkedin.com/in/kingshuk-saha-566740217/'),*/
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffb8b8ff),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Developers',
          style: GoogleFonts.aBeeZee(),
        ),
      ),
      body: Container(
        color: const Color(0xffb8b8ff),
        child: Swiper(
          itemBuilder: (context, index) {
            return devCards[index];
          },
          itemCount: 4,
          itemHeight: MediaQuery.of(context).size.height / 1.418,
          itemWidth: MediaQuery.of(context).size.width / 0.981,
          layout: SwiperLayout.TINDER,
        ),
      ),
    );
  }
}
