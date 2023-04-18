import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //chave global para validação dos campos

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "informe seus dados!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora fit"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6600),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //Implementa um scroll caso passe as informações com o teclado
        padding: const EdgeInsets.fromLTRB(
            10.0, 0.0, 10.0, 0.0), //espaçamento da coluna
        child: Form(
          //Para validação dos campos se estiverem em branco
          key: _formKey, //Para validação dos campos se estiverem em branco
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, //Alinhamento horizontal (Strech tudo ao centro)
            children: <Widget>[
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Color(0xFFFF6600),
              ),
              TextFormField(
                //Para validar o campo
                //Campo de texto do PESO
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Color(0xFFFF6600))),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Color(0xFFFF6600), fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  //validando campo vazio
                  if (value == null || value.isEmpty) {
                    return "Insira seu Peso!";
                  }
                  return null;
                },
              ),
              TextFormField(
                //Para validar o campo
                //Campo de texto da ALTURA
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Color(0xFFFF6600))),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Color(0xFFFF6600), fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  //validando campo vazio
                  if (value == null || value.isEmpty) {
                    return "Insira sua Altura!";
                  }
                  return null;
                },
              ),
              Padding(
                //Espaçamento do botão e texto
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    //ficou no lugar do RaisedButton
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //validando campos em branco ao calcular
                        _calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6600)),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFF6600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
