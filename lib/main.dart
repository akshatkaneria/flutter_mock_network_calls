import 'package:flutter/material.dart';
import 'package:flutter_mock_network_calls/api_service.dart';

void main() {
  runApp(
    FlutterTestApp(),
  );
}

class FlutterTestApp extends StatefulWidget {
  @override
  _FlutterTestAppState createState() => _FlutterTestAppState();
}

class _FlutterTestAppState extends State<FlutterTestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mocking API Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool api1Called = true;
  bool api2Called = true;
  String data1;
  String data2;

  @override
  void initState() {
    api1Called = true;
    api2Called = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Click the buttons below to fetch data from APIs',
                ),
                SizedBox(height: 20),
                _dataCardWidget(
                  context,
                  'API-1 data:',
                  data1,
                  // Color(0xff71C077),
                ),
                SizedBox(height: 8),
                Icon(
                  Icons.arrow_downward,
                ),
                SizedBox(height: 8),
                _customButtonWidget(
                  'Click here to fetch data from API-1',
                  Color(0xff4F9DE7),
                  _fetchDataFromAPI1,
                ),
                SizedBox(height: 16.0),
                Divider(
                  height: 2.0,
                  color: Colors.black,
                ),
                SizedBox(height: 16.0),
                _dataCardWidget(
                  context,
                  'API-2 data:',
                  data2,
                  // Color(0xffEB776C),
                ),
                SizedBox(height: 8),
                Icon(
                  Icons.arrow_downward,
                ),
                SizedBox(height: 8),
                _customButtonWidget(
                  'Click here to fetch data from API-2',
                  Color(0xff00509F),
                  _fetchDataFromAPI2,
                ),
                SizedBox(height: 16),
                if (!api1Called || !api2Called) ...[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 24.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xFFD5D5D5),
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF0070DD),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customButtonWidget(
    String buttonText,
    Color buttonColor,
    Function onButtonPressed,
  ) {
    return RaisedButton(
      onPressed: () => onButtonPressed(context),
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(
          16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataCardWidget(
    BuildContext context,
    String title,
    String data,
  ) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black, width: 2.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                data ?? 'null',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchDataFromAPI1(BuildContext context) async {
    print('Calling API-1 to fetch data');
    setState(() {
      api1Called = false;
    });
    await ApiService.callAPI1().then((response) {
      print('API-1 success!');
      print('API-1 data: ${response.data.toString()}');
      setState(() {
        api1Called = true;
        data1 = response.data['message'];
      });
    }).catchError((error) {
      print('Error while calling API-1: $error');
      setState(() {
        api1Called = true;
      });
    });
  }

  Future<void> _fetchDataFromAPI2(BuildContext context) async {
    print('Calling API-2 to fetch data');
    setState(() {
      api2Called = false;
    });
    await ApiService.callAPI2().then((response) {
      print('API-2 success!');
      print('API-2 data: ${response.data.toString()}');
      setState(() {
        api2Called = true;
        data2 = response.data['message'];
      });
    }).catchError((error) {
      print('Error while calling API-2: $error');
      setState(() {
        api2Called = true;
      });
    });
  }
}
