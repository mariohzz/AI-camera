import 'package:flutter/material.dart';

class BabyTall extends StatelessWidget {
  const BabyTall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 219, 120),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,

            child: Container(
              child: Text(
                'Your baby is :',
                style: TextStyle(
                    color: Color.fromARGB(255, 153, 105, 0),
                    fontSize: 30,
                    fontFamily: 'Tempsitc',
                    fontWeight: FontWeight.w500),
              ),
              margin: const EdgeInsets.only(top: 80),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(
                  left: 250,
                  bottom: 30
                ),
                width: 160,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: new AssetImage("images/Picture.png"),
                  fit: BoxFit.contain,
                ))),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 214, 103),
                    Color.fromARGB(255, 255, 205, 69)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: const Color.fromARGB(255, 252, 205, 77),
                border: Border.all(
                  color: const Color.fromARGB(255, 177, 130, 0),
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.only(left: 250, top: 300),
              width: 160,
              height: 60,
            ),
          ),
           Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 214, 103),
                    Color.fromARGB(255, 255, 205, 69)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: const Color.fromARGB(255, 252, 205, 77),
                border: Border.all(
                  color: const Color.fromARGB(255, 177, 130, 0),
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.only(left: 200, top: 421),
              width: 250,
              height: 60,
            ),
          ),
           Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 214, 103),
                    Color.fromARGB(255, 255, 205, 69)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: const Color.fromARGB(255, 252, 205, 77),
                border: Border.all(
                  color: const Color.fromARGB(255, 177, 130, 0),
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.only(left: 150, top: 541),
              width: 400,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
