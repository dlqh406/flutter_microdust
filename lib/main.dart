
import 'package:flutter/material.dart';
import 'package:flutter_microdust/models/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
  AirResult _result;
  // 테스트코드에서 가져옴 이제 테스크파일은 필요없음
  // async로 받아오니깐 future로 받아옴
  Future<AirResult> fetchData() async{
    var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=e556999a-9950-4709-8047-7b27a69c5846');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }
// 앱이 시작하자마 바로 실행 -> _result에 값 삽입
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((airResult){
      setState(() {
        _result = airResult;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // http로 받아오는 중일때 값이 0이기 때문에, 받아 오기 전까지 Circular를 보여줌
      body: Center(
        child: _result == null ? CircularProgressIndicator() : Padding(
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
                        color: getColor(_result),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('얼굴사진'),
                            Text('${_result.data.current.pollution.aqius}',style: TextStyle(fontSize: 40.0),),
                            Text(getString(_result),style: TextStyle(fontSize: 20.0)),
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
                                Image.network('http://airvisual.com/images/${_result.data.current.weather.ic}.png', width: 32,height: 32,),
                                SizedBox(width: 16),
                                Text('${_result.data.current.weather.tp}',style: TextStyle(fontSize: 16.0)),
                                SizedBox(width: 12)
                              ],
                            ),
                            Text('습도 ${_result.data.current.weather.hu}%'),
                            Text('풍속 ${_result.data.current.weather.ws}m/s'),
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

