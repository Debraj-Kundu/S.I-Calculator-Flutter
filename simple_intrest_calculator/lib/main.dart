import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Intrest Calculator',
      home: MyHomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currencies = ['Rupee', 'Dollar', 'Pound'];
  final _minPadding = 5.0;
  var _selected = 'Rupee';

  TextEditingController principalCntr = TextEditingController();
  TextEditingController roiCntr = TextEditingController();
  TextEditingController termCntr = TextEditingController();
  
  String _amount = '0';
  
  @override
  Widget build(BuildContext context) {
    
    TextStyle styles = Theme.of(context).textTheme.headline6;
    
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('S.I Calculator'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: _minPadding * 2),
        child: ListView(
          children: [
            getImg(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: principalCntr,
                keyboardType: TextInputType.number,
                style: styles,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  hintText: 'Enter principal amount',
                  labelStyle: styles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: roiCntr,
                keyboardType: TextInputType.number,
                style: styles,
                decoration: InputDecoration(
                  labelText: 'Intrest',
                  hintText: 'Enter intrest rate',
                  labelStyle: styles,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: termCntr,
                      keyboardType: TextInputType.number,
                      style: styles,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Time in years',
                        labelStyle: styles,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Expanded(
                    child: DropdownButton(
                      value: _selected,
                      onChanged: (newVal) {
                        setState(() {
                          _selected = newVal;
                        });
                      },
                      items: _currencies.map((selectedVal) {
                        return DropdownMenuItem(
                          value: selectedVal,
                          child: Text(selectedVal),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Calculate'),
                      onPressed: (){
                        setState(() {
                          _amount = _calculateReturns();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Clear', style: TextStyle(fontSize: 20,),),
                      onPressed: (){
                        setState(() {
                          _clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_amount, style: styles,),
            ),
          ],
        ),
      ),
    );
  }

  void _clear(){
    principalCntr.text = '';
    roiCntr.text = '';
    termCntr.text = '';
    _amount = '0';
    _selected = _currencies[0];
  }

  String _calculateReturns(){
    double principal = double.parse(principalCntr.text);
    double roi = double.parse(roiCntr.text);
    double year = double.parse(termCntr.text);

    double sI = principal + (principal*roi*year)/100;
    String res = 'After $year years, you get $sI $_selected';
    return res;
  }

  Widget getImg() {
    AssetImage img = AssetImage('images/money.jpg');
    Image image = Image(image: img, width: 125, height: 125);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }
}
