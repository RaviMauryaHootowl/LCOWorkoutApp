import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lco_workout/done.dart';
import 'package:lco_workout/info.dart';
import 'package:lco_workout/workout_generation.dart';
import 'package:lco_workout/workout_page.dart';

void main() async => runApp(MaterialApp(
  //home: WorkoutGeneration(),
  //initialRoute: '/workoutScreen',
  debugShowCheckedModeBanner: false,
  routes: {
    '/' : (context) => Home(),
    '/workoutGenerator' : (context) => WorkoutGeneration(),
    '/workoutScreen' : (context) => WorkoutScreen(),
    '/infoPage' : (context) => InfoPage(),
    '/done' : (context) => Done(),
  },
)
);

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Image logoImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logoImage = Image.asset('assets/logo.png',
      width: double.infinity,
    );
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(logoImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        // load info page
                        Navigator.pushNamed(context, '/infoPage');
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: HexColor('BD21D9'),
                      ),
                    )
                  ],
                ),
              ),

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
                              logoImage,
                              Text('“All progress takes place outside the comfort zone”',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                ),
                                
                              ),
                              Text('- Michael John Bobak',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: HexColor('BD21D9'),
                                  fontWeight: FontWeight.bold
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
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: HexColor('BD21D9'),
                    width: 3.0
                  )
                ),
                padding: EdgeInsets.all(20.0),
                onPressed: (){
                  Navigator.pushNamed(context, 
                    '/workoutGenerator',
                    arguments: {
                      'type' : 0
                    },
                  );
                },

                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.swap_calls,
                      color: HexColor('BD21D9'),
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Random Workout',
                      style: GoogleFonts.montserrat(
                        color: HexColor('BD21D9'),
                        fontSize: 20.0
                      ),
                    ),
                  ],
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
                  Navigator.pushNamed(context, 
                    '/workoutGenerator',
                    arguments: {
                      'type' : 1
                    },
                  );
                },
                color: HexColor('BD21D9'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.schedule,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Daily Workout',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}