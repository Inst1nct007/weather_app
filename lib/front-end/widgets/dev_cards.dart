import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

Widget DevCard(String name, var backgroundColor, String picture, double height, String link) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color(backgroundColor),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                //child: Text('hello'),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/$picture',
                  height: height,
                ),
              ),
              const SizedBox(height: 45,),
              Text(name, style: GoogleFonts.aBeeZee(textStyle: const TextStyle(fontSize: 40, color: Colors.black54)),),
              const SizedBox(height: 45,),
              ElevatedButton(onPressed: () async {
                await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
              },
              style: ElevatedButton.styleFrom(elevation: 0),child: Text('LinkedIn Profile', style: GoogleFonts.aBeeZee(color: Colors.white),),
              ),
              const SizedBox(height: 100,),
              Text('<<  Swipe >>', style: GoogleFonts.aBeeZee(fontSize: 20, color: Colors.black54),),
            ],
          ),
        )
      ],
    ),
  );
}