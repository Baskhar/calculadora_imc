import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  TextEditingController weightController =
      TextEditingController(); //controler do textofield(peso)
  TextEditingController heightController =
      TextEditingController(); //controler do textfield(altura)

  GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); //instanciando um objeto que é a chave do meu formulário para validação

  String _infotext =
      'Informe seus dados'; //variavel que será o texto no final da pagina

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Implementa a estrutura básica de layout visual do design de materiais.
      appBar: AppBar(
        //barra
        title: const Text('Calculadora de IMC'), //texto
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          //ações da minha barra
          IconButton(
            //botão refrash
            onPressed: _resetFields, //função vazia
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          //possibilita usar abrir o teclado e não bugar a tela(sobrepondo)
          child: Form(//formulário, onde será possivel validar as entradas com a key
            key: _formKey,//passando a chave que eu criei
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //faz com que os whidths ocupem toda a largura
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  controller: weightController,
                  //campo de texto 1(peso)
                  keyboardType: TextInputType.number,
                  //tipo de dado a ser inserido no campo
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (kg)', //título do texto
                    hintText: 'Ex:... 70(kg)',
                    labelStyle: TextStyle(
                      //edição do texto(título)
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      //edita o campo de texto
                      borderSide: BorderSide(
                        color: Colors.green, //cor
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                  ),
                  validator: (value){//validação através dessa função
                    if (value!.isEmpty){
                      return "Insira seu Peso!";
                    }

                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: heightController,
                  //campo de texto 2(altura)
                  keyboardType: TextInputType.number,
                  //tipo de dado a ser inserido no campo
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Altura (m)', //título do texto
                    hintText: 'Ex:... 1.60(kg)',
                    labelStyle: TextStyle(
                      //edição do texto(título)
                      color: Colors.green,
                    ),
                    focusedBorder: OutlineInputBorder(
                      //edita o campo de texto
                      borderSide: BorderSide(
                        color: Colors.green, //cor
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                  ),
                  validator: (value){//validação através dessa função
                    if (value!.isEmpty){
                      return "Insira sua altura!";
                    }

                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){//se ele foi validado, ele chama
                        _calculate();
                      }
                    },
                    child: const Text(
                      'CALCULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize: MaterialStateProperty.all(const Size(0, 60)),
                    ),
                  ),
                ),
                Text(
                  _infotext,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ), //corpo
    );
  }

  void _resetFields() {
    //função para o botão reset
    weightController.text = ""; //colocando o campo de texto vazio(peso)
    heightController.text = ""; //colocando o campo de texto vazio(altura)
    setState(() {
      _infotext =
          'Informe seus dados'; //variavel que será o texto no final da pagina
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController
          .text); //transformando o texto(peso) em double e armazenando numa variavel
      double height = double.parse(heightController
          .text); //transformando o texto(altura) em double e armazenando numa variavel
      //divido por 100 para converter em cm
      double imc = weight / (height * height);
      if (imc < 16) {
        _infotext =
            'Você se encontra no estado de Magreza Grave(IMC:${imc.toStringAsPrecision(4)})'; //adcionar a quantidade de numeros a serem exibidas
      }
      if ((imc >= 16) && (imc <= 17)) {
        _infotext =
            'Você se encontra no estado de Magreza Moderada(IMC:${imc.toStringAsPrecision(4)})';
      }
      if ((imc > 17) && (imc <= 18.5)) {
        _infotext =
            'Você se encontra no estado de Magreza Leve(IMC:${imc.toStringAsPrecision(4)})';
      }
      if ((imc > 18.5) && (imc <= 25)) {
        _infotext =
            'Você se encontra Saudável(IMC:${imc.toStringAsPrecision(4)})';
      }
      if ((imc > 25) && (imc <= 30)) {
        _infotext =
            'Você se encontra no estado de Sobrepeso(IMC:${imc.toStringAsPrecision(4)})';
      }
      if ((imc > 30) && (imc <= 35)) {
        _infotext =
            'Você se encontra no estado de Obesidade - GRAU 1(IMC:${imc.toStringAsPrecision(4)})';
      }
      if ((imc > 35) && (imc <= 40)) {
        _infotext =
            'Você se encontra no estado de Obesidade - GRAU 2 (Severa)(IMC:${imc.toStringAsPrecision(4)})';
      }
      if (imc > 40) {
        _infotext =
            'Você se encontra no estado de Obesidade - GRAU 3 (Mórbida)(IMC:${imc.toStringAsPrecision(4)})';
      }
    });
  }
}
