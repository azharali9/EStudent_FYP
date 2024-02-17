/*
import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/animation.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  _launchURL() async {
    final Uri url = Uri.parse('https://hamza5743.github.io/TimeTableGenerator/Calculator.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top quarter of the screen with an image
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/db.PNG'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 40 , width: 100,),

            // Three interactable rounded corner 3D-looking squares
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquare(
                  context,
                  'Square 1',
                  'assets/images/download(1).png',
                  screenWidth * 0.4, // Adjust the width of the first two boxes
                      () {
                    // Navigate to the desired page for Square 1
                  },
                ),
                _buildSquare(
                  context,
                  'Square 2',
                  'assets/images/download(1).png',
                  screenWidth * 0.4, // Adjust the width of the first two boxes
                      () {
                    // Navigate to the desired page for Square 2
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildSquare(
              context,
              'Square 3',
              'assets/images/download(1).png',
              screenWidth * 0.8, // Adjust the width of the third box
                  () {
                // Navigate to the desired page for Square 3
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquare(
      BuildContext context,
      String text,
      String imagePath,
      double width,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: () {
        _launchURL();
    },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setEntry(3, 2, 0.001),
        child: Container(
          width: width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.cyan, // Set your desired color
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white, // Set your desired border color
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 50, // Set your desired image height
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white, // Set your desired text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:fyp_project/view/webview.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _launchURL(String _url) async {
    final Uri url = Uri.parse(_url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.4,
            0.6,
            0.9,
          ],
          colors: [
            Colors.black,
            Colors.black12,
            Colors.cyan.shade50.withOpacity(0.8),
            Colors.cyan.withOpacity(0.95),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top quarter of the screen with an image
              Container(
                height: screenHeight * 0.25,
                width: screenWidth, // Set width to take the entire screen width
          
                child: Image.asset(
                  "assets/images/logot.png",
                  color: Colors.white,
                  colorBlendMode: BlendMode.dstIn,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
          
              // Two interactable rounded corner 3D-looking squares in the first row
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSquare(
                          context,
                          'Time Table Generator',
                          'assets/images/tt.png',
                          screenWidth * 0.6,
                          screenWidth * 0.6,
                          'https://time-table-generator-q6o8p9ciz-mudassirw165.vercel.app',
                          1),
          
                      /*_buildSquare(
                        context,
                        'Square 2',
                        'assets/images/download(1).png',
                        screenWidth * 0.4,
                        'http://192.168.1.15:5000',
                      ),*/
                    ],
                  ),
                ),
              ),
          
              // One interactable rounded corner 3D-looking square in the second row
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSquare(
                        context,
                        'Facial Recognition',
                        'assets/images/fr.png',
                        screenWidth * 0.6,
                        screenWidth * 0.6,
                        'http://192.168.31.5:5000',
                        2),
                  ],
                ),
              ),
          
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/images/eslogo.png'),height: 120,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(
    BuildContext context,
    String text,
    String imagePath,
    double width,
    double height,
    String url,
    int first,
  ) {
    return InkWell(
      onTap: () {
        if (first == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => web2()));
        } else {
          _launchURL(url);
        }
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setEntry(3, 2, 0.001),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white54,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  offset: const Offset(10, 10),
                  blurRadius: 5,
                  spreadRadius: 0),
              BoxShadow(
                  color: Colors.blue.withOpacity(0.25),
                  offset: Offset(1, 10),
                  blurRadius: 15,
                  spreadRadius: -5)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 90,
              ),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
