import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lco_workout/workout.dart';

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

//List<String> names = ['Push Ups', 'Crunches', 'Sit Ups', 'Streching', 'Leg Strech'];
List<int> ids = [];
int nOfSets = 1;
int time = 3;
Map data = {};
String titleText;
List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thrusday', 'Friday', 'Saturday', 'Sunday'];
List<List<int>> dayids = [
  [1, 2, 3, 4, 5],
  [2, 3, 4, 5, 6],
  [3, 4, 5, 6, 7],
  [4, 5, 6, 7, 8],
  [5, 6, 7, 8, 9],
  [10, 11, 12, 13, 14],
  [7, 8, 9, 10, 11]
];
int estimatedDuration = 0;



Widget getExcersieList(context, index){
  Workout wo = Workout(ids[index]);
  return Container(
    margin: EdgeInsets.fromLTRB(10,0,10,20),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: HexColor('F9DAFF'),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: HexColor('99BD21D9'),
          offset: Offset(2.0,2.0),
          blurRadius: 5.0
        )
      ]
    ),
    
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
          child: Image.asset(
            'assets/${ids[index]}.png',
            height: 100,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(30,0,10,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${wo.name}',
                  style: GoogleFonts.montserrat(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: HexColor('343434')
                  ),
                ),
                Text(
                  '${wo.duration} seconds',
                  style: GoogleFonts.montserrat(
                    fontSize: 20.0,
                    color: HexColor('5C5C5C')
                  ),
                ),
              ],
            ),
          )
        )
      ],
    )
  );
}

class WorkoutGeneration extends StatefulWidget {
  @override
  _WorkoutGenerationState createState() => _WorkoutGenerationState();
}

class _WorkoutGenerationState extends State<WorkoutGeneration> {

  Timer _countdown;
  
  

  void generate(){
    // randomly generate 5 unique numbers from 1 to 14
    
    setState(() {
      if(data['type'] == 0){
        List list = List.generate(14, (i) => i+1);
        list.shuffle();
        ids.clear();
        for(int i = 0; i < 5; i++){
          ids.add(list[i]);
        }
      }else{
        // Get todays day.
        
        var now = DateTime.now();
        int today = now.weekday - 1;
        titleText = days[today] + ' Workout';
        ids.clear();
        for(int i = 0; i < 5; i++){
          ids.add(dayids[today][i]);
        }
      }
    });
  }

  void startCountdown(){
    time = 3;
    const oneSec = const Duration(seconds : 1);
    _countdown = new Timer.periodic(oneSec, 
      (Timer timer) => setState(
        (){
          if(time < 1){
            _countdown.cancel();

            Navigator.pushNamed(context, '/workoutScreen',
              arguments: {
                'ids' : ids,
                'nOfSets' : nOfSets
              },
            );
          }else{
            time-=1;
            print('increasing $time');
          }
        }
      )
    );
  }
  
  void setEstimatedDuration(){
    int dur = 0;
    for(int i = 0; i < ids.length; i++){
      Workout wo = Workout(ids[i]);
      dur += wo.duration;
    }
    setState(() {
      estimatedDuration = nOfSets * (dur + (40*4));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ids.clear();
    data.clear();
    super.dispose();

  }

  void changeSets(int n){
    setState(() {
      if(n == 1 && nOfSets < 10){
        nOfSets += 1;
      }else if(n == -1 && nOfSets > 1){
        nOfSets -= 1;
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    //DdebugPaintSizeEnabled = true;
    titleText = "Selected for you";
    if(ids.isEmpty){
      data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
      print(data);
      generate();
    }
    setEstimatedDuration();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,0),
              child: Image.asset(
                'assets/logo.png',
                height: 120,
              ),
            ),
            Text(
              '$titleText',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 25.0
              ),
            ),
            Expanded(
              child: Container(
                // child: GridView.count(
                //   crossAxisCount: 2,
                //   children: List.generate(5, (index){
                //     return Container(
                //       child: getExcersieList(index),
                //     );
                //   }),
                // )
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext ctx, int index){
                    return Container(
                      child: getExcersieList(ctx, index),
                    );
                  }
                ),
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: HexColor('BD21D9'),
                  width: 3.0
                ),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('99BD21D9'),
                    offset: Offset(2.0,2.0),
                    blurRadius: 5.0
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Number of Sets:',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                child: Text('-',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 40.0,
                                    color: HexColor('BD21D9'),
                                  ),
                                ),
                                onTap: (){
                                  changeSets(-1);
                                },
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10.0,0,10.0,0),
                                padding: EdgeInsets.fromLTRB(20,10,20,10),
                                decoration: BoxDecoration(
                                  color: HexColor('BD21D9'),
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Text(
                                  '$nOfSets',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22.0,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Text('+',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 40.0,
                                    color: HexColor('BD21D9'),
                                  ),
                                ),
                                onTap: (){
                                  changeSets(1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                  Text(
                    'Estimated Duration : ${(estimatedDuration/60).floor()} mins',
                    style: GoogleFonts.montserrat(
                      color: HexColor('5C5C5C')
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                (data['type'] == 0) ?
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: ButtonTheme(
                    minWidth: 20,
                    child: RaisedButton(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      padding: EdgeInsets.all(20.0),
                      onPressed: (){
                        generate();
                      },
                      color: HexColor('BD21D9'),
                      child: Icon(
                        Icons.refresh,
                        size: 23,
                        color: Colors.white
                      )
                    ),
                  ),
                ) : SizedBox(),
                Expanded(
                  child: RaisedButton(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    padding: EdgeInsets.all(20.0),
                    onPressed: (){
                      //startCountdown();
                      Navigator.pushNamed(context, '/workoutScreen',
                        arguments: {
                          'ids' : ids,
                          'nOfSets' : nOfSets
                        },
                      );
                    },
                    color: HexColor('BD21D9'),
                    child: Text(
                      'Start Workout',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
