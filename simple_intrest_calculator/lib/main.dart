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
  
  var _formKey = GlobalKey<FormState>();
  
  var _currencies = ['Rupee', 'Dollar', 'Pound'];
  final _minPadding = 5.0;
  var _selected = '';

  @override
  void initState() {
    super.initState();
    _selected = _currencies[0];
  }

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
          child: ListView(
            children: [
              SizedBox(height: 10),
              getImg(),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: principalCntr,
                  keyboardType: TextInputType.number,
                  style: styles,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Enter some amount';
                    }
                    return '';
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14,),
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
                child: TextFormField(
                  validator: (String value){
                    if(value.isEmpty || double.tryParse(value) == null){
                      return 'Enter sometihing';
                    }
                    return '';
                  },
                  controller: roiCntr,
                  keyboardType: TextInputType.number,
                  style: styles,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14,),
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
                      child: TextFormField(
                        controller: termCntr,
                        keyboardType: TextInputType.number,
                        style: styles,
                        validator: (String value){
                          if(value.isEmpty){
                            return 'Enter time';
                          }
                          return '';
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.yellowAccent, fontSize: 14,),
                          labelText: 'Time',
                          hintText: 'Time in years',
                          labelStyle: styles,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
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
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()){
                              this._amount = _calculateReturns();
                            }
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
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
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
                child: Text(
                  _amount,
                  style: styles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clear() {
    principalCntr.text = '';
    roiCntr.text = '';
    termCntr.text = '';
    _amount = '0';
    _selected = _currencies[0];
  }

  String _calculateReturns() {
    double principal = double.parse(principalCntr.text);
    double roi = double.parse(roiCntr.text);
    double year = double.parse(termCntr.text);

    double sI = principal + (principal * roi * year) / 100;
    String res = 'After $year years, you get $sI $_selected';
    return res;
  }

  Widget getImg() {
    AssetImage img = AssetImage('images/money.jpg');
    Image image = Image(image: img, width: 125, height: 125);
    return Container(
      child: image,
      margin: EdgeInsets.symmetric(horizontal: _minPadding * 10, vertical: 0),
    );
  }
}
