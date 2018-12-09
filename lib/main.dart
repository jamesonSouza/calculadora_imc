import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home() ,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController= TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _info= "Insira as informações acima";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  void _resetField(){
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _info="Insira as informações acima";

    });

}

 void _calculo(){
   setState(() {

     double weight = double.parse(weightController.text);
     double height = double.parse(heightController.text) /100;
     double imc = weight /(height * height);
     if(imc < 18.6){
       _info = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
     }else if(imc >= 18.6 && imc < 24.9){
       _info = "Peso Ideal (${imc.toStringAsPrecision(3)})";
     }else if(imc >= 24.9 && imc <29.9){
       _info = "Levemente A cima do peso (${imc.toStringAsPrecision(3)})";
     }else if (imc>= 29.9 && imc <34.9){
       _info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
     }else if (imc>= 34.9 && imc <39.9){
     _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
     }else if (imc>=40){
     _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
   }

   });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ("Calculadora de Imc"),
        backgroundColor: Colors.green,
        centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
            onPressed: _resetField
            ),
          ],
        elevation: 10.0 ,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.green,),),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                    validator: (value){
                    if(value.isEmpty || value.length<2){
                      return "Insira o peso!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child:  TextFormField(keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.green,),),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty || value.length<2 ){
                      return "Insira a altura!";
                    }
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                child:Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formkey.currentState.validate()){
                        _calculo();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      )
    );
  }
}
