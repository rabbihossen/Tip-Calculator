// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_element

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle titleStyle = const TextStyle(
    color: Color(0xff00474b),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  //Setp 1 : prepare the variables
  double bill = 0;
  double tip = 0;
  int person = 1;

  //prepare the result
  double tipPerPerson = 0;
  double totalPerPerson = 0;

  //todo create the text Editing controller to get the value from input
  TextEditingController billController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  TextEditingController personController = TextEditingController();

  //todo Create a function to calculte the tip
  void calculte() {
    tipPerPerson = (bill * tip) / person;
    totalPerPerson = (bill * (1 + tip)) / person;
  }

  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //todo Header
            _header(),
            //todo Body
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  //todo lets add bill
                  _billTextField(),
                  //todo lets create the  button grid
                  _buttonGrid(),
                  //todo Number of People
                  _countPeople(),
                  //todo Show Tip Amount & Total Amount
                  _showAmount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _countPeople() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of People', style: titleStyle),
        const SizedBox(height: 15),
        TextField(
          onEditingComplete: () {
            setState(() {
              if (personController.text.isNotEmpty) {
                person = int.parse(personController.text);
              } else {
                person = 1;
              }
              //todo dismiss the keybord after editing
              FocusScope.of(context).unfocus();
              calculte();
            });
          },
          controller: personController,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xfff3f8fb),
            border: InputBorder.none,
            hintText: 'eg: 5',
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xff00474b),
            ),
          ),
          textAlign: TextAlign.end,
          style: titleStyle,
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _buttonGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Tip %', style: titleStyle),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 60,
                color: isSelect ? Color(0xff00474b) : Color(0xff26c2ad),
                onPressed: () {
                  setState(() {
                    isSelect = !isSelect;
                    tip = 0.05;
                    calculte();
                  });
                },
                child: Text(
                  '5%',
                  style: TextStyle(
                    color: isSelect ? Colors.white : Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: FlatButton(
                height: 60,
                color: Color(0xff00474b),
                onPressed: () {
                  setState(() {
                    tip = 0.1;
                    calculte();
                  });
                },
                child: Text(
                  '10%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 60,
                color: Color(0xff00474b),
                onPressed: () {
                  setState(() {
                    tip = 0.15;
                    calculte();
                  });
                },
                child: Text(
                  '15%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FlatButton(
                height: 60,
                color: Color(0xff00474b),
                onPressed: () {
                  setState(() {
                    tip = 0.25;
                    calculte();
                  });
                },
                child: Text(
                  '25%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 60,
                color: Color(0xff00474b),
                onPressed: () {
                  setState(() {
                    tip = 0.5;
                    calculte();
                  });
                },
                child: Text(
                  '50%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onEditingComplete: () {
                  setState(() {
                    if (tipController.text.isNotEmpty) {
                      tip = double.parse(tipController.text) / 100;
                    } else {
                      tip = 0;
                    }
                    //todo dismiss the keybord after editing
                    FocusScope.of(context).unfocus();
                    calculte();
                  });
                },
                controller: tipController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xfff3f8fb),
                  border: InputBorder.none,
                  hintText: 'Custom',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff00474b),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  _billTextField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bills', style: titleStyle),
        const SizedBox(height: 15),
        TextField(
          onEditingComplete: () {
            setState(() {
              if (billController.text.isNotEmpty) {
                bill = double.parse(billController.text);
              } else {
                bill = 0;
              }
              //todo dismiss the keybord after editing
              FocusScope.of(context).unfocus();
              calculte();
            });
          },
          controller: billController,
          keyboardType: TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xfff3f8fb),
            border: InputBorder.none,
            hintText: 'eg: 100',
            prefixIcon: Icon(Icons.attach_money_rounded),
          ),
          textAlign: TextAlign.end,
          style: titleStyle,
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  _showAmount() {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Color(0xff00474b), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tip Amount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '/ Person',
                    style: TextStyle(
                      color: Color(0xff598689),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${tipPerPerson.toStringAsFixed(1)}',
                style: TextStyle(
                  color: Color(0xff598689),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '/ Person',
                    style: TextStyle(
                      color: Color(0xff598689),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${totalPerPerson.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Color(0xff598689),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _restButton(),
        ],
      ),
    );
  }

  _restButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 50,
        color: Color(0xff26c2ad),
        onPressed: () {
          setState(() {
            tip = 0;
            person = 1;
            bill = 0;
            calculte();
            tipController.clear();
            billController.clear();
            personController.clear();
            isSelect = true;
          });
        },
        child: Text(
          'Rest',
          style: TextStyle(
            color: Color(0xff00494b),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _header() {
    return const SizedBox(
      width: double.infinity,
      height: 220.0,
      child: Center(
        child: Text(
          'T I P\nC A L C U L A T O R',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
