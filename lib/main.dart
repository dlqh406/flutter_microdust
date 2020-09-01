
import 'package:flutter/material.dart';
import 'package:flutter_microdust/bloc/AirBloc.dart';
import 'package:flutter_microdust/models/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {runApp(MyApp());}
final airBloc = AirBloc();

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
      // http로 받아오는 중일때 값이 0이기 때문에, 받아 오기 전까지 Circular를 보여줌
      body: Center(
        child: StreamBuilder<AirResult>(
              stream: airBloc.airResult,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return buildPadding(snapshot.data);
                }else{
                  return CircularProgressIndicator();
                }
              }
            ),
      ),
    );
  }

  Widget buildPadding(AirResult result) {
    return Padding(
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
                      color: getColor(result),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('얼굴사진'),
                          Text('${result.data.current.pollution.aqius}',style: TextStyle(fontSize: 40.0),),
                          Text(getString(result),style: TextStyle(fontSize: 20.0)),
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
                              Image.network('http://airvisual.com/images/${result.data.current.weather.ic}.png', width: 32,height: 32,),
                              SizedBox(width: 16),
                              Text('${result.data.current.weather.tp}',style: TextStyle(fontSize: 16.0)),
                              SizedBox(width: 12)
                            ],
                          ),
                          Text('습도 ${result.data.current.weather.hu}%'),
                          Text('풍속 ${result.data.current.weather.ws}m/s'),
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
                  ), onPressed: (){
                airBloc.fetch();
                },
                ),
              )
            ],
          ),
        ),
      );
  }

  Color getColor(AirResult result) {
    if(result.data.current.pollution.aqius <= 50){
      return Colors.green;
    }
    if(result.data.current.pollution.aqius <= 100){
      return Colors.blueAccent;
    }
    if(result.data.current.pollution.aqius <= 150){
      return Colors.deepOrangeAccent;
    }else{
        return Colors.red;
      }
    }

  String getString(AirResult result) {
    if(result.data.current.pollution.aqius <= 50){
      return '좋음';
    }
    if(result.data.current.pollution.aqius <= 100){
      return '보통';
    }
    if(result.data.current.pollution.aqius <= 150){
      return '안 좋음';
    }else{
      return '최악';
    }
  }

  }

