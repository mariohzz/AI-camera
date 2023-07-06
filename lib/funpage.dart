import 'package:flutter/material.dart';
import 'package:python_project/paint_app/home_page.dart';
import 'package:python_project/videoFun.dart';

class FunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Fun Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context)=>YoutubePage())
                  );
                  // navigateToScreen(
                  //     context, 'screen2'); // Pass the identifier for screen 1
                },

                child: Container(
                  width: 200,
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Fun Videos',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height:10,),
                        Image.asset(
                          width: 200,
                          'images/fun.jpg',
                          fit: BoxFit.fill,
                        ),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors
                        .cyan, // Set the background color of the container
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Set the color and opacity of the shadow
                        spreadRadius: 2, // Set the spread radius of the shadow
                        blurRadius: 5, // Set the blur radius of the shadow
                        offset: Offset(0, 3), // Set the offset of the shadow
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 20.0),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context)=>PaintPage())
                  );
                  // navigateToScreen(
                  //     context, 'screen2'); // Pass the identifier for screen 1
                },

                child: Container(
                  width: 200,
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Draw',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height:10,),
                        Image.asset(
                          width: 200,
                          'images/fun.jpg',
                          fit: BoxFit.fill,
                        ),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors
                        .green, // Set the background color of the container
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Set the color and opacity of the shadow
                        spreadRadius: 2, // Set the spread radius of the shadow
                        blurRadius: 5, // Set the blur radius of the shadow
                        offset: Offset(0, 3), // Set the offset of the shadow
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
