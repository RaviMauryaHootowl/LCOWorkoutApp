import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //logoImage,
                              Container(
                                margin: EdgeInsets.all(20.0),
                                child: CircleAvatar(
                                  backgroundColor: HexColor('F9DAFF'),
                                  radius: 100,
                                  backgroundImage: AssetImage('assets/clippy.jpg'),
                                ),
                              ),
                              Text('Developed by',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                ),
                              ),
                              Text('Ravi Maurya',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(
                                height: 30
                              ),
                              Text('made for',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                ),
                              ),
                              Text('Hitesh Choudhary\nMobile App Challenge',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 22.0,
                                  color: HexColor('BD21D9'),
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                ),
              ),
              RaisedButton(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                padding: EdgeInsets.all(20.0),
                onPressed: (){
                  
                },
                color: Colors.white,
                child: Text(
                  'App Challenge',
                  style: GoogleFonts.montserrat(
                    color: HexColor('BD21D9'),
                    fontSize: 20.0
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                padding: EdgeInsets.all(20.0),
                onPressed: (){
                  
                },
                color: HexColor('BD21D9'),
                child: Text(
                  'My LinkedIn Profile',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}