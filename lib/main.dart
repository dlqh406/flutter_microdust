import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30),),
              SizedBox(height: 16,),
              Card(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('얼굴사진'),
                          Text('80',style: TextStyle(fontSize: 40.0),),
                          Text('보통',style: TextStyle(fontSize: 20.0)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text('이미지'),
                              Text('11',style: TextStyle(fontSize: 16.0)),
                              SizedBox(width: 16)
                            ],
                          ),
                          Text('습도100%'),
                          Text('풍속 5.7m/s'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              ClipRRect(
                borderRadius:BorderRadius.circular(30),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  color: Colors.orange,
                  child: Icon(
                      Icons.refresh,
                      color: Colors.white
                  ), onPressed: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

