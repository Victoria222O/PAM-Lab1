import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bmi_calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Welcome 🐙 \n BMI CALCULATOR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _weight = 70;
  int _age = 23;
  double _height = 170;
  String _bmiResult = ' ';
  String _bmiStatus = ' ';
  String _gender = 'Male';

  void _incrementWeight() {
    setState(() {
      _weight++;
    });
  }

  void _decrementWeight() {
    setState(() {
      if (_weight > 0) {
        _weight--;
      }
    });
  }

  void _incrementAge() {
    setState(() {
      _age++;
    });
  }

  void _decrementAge() {
    setState(() {
      if (_age > 0) {
        _age--;
      }
    });
  }

  void _calculateBMI() {
    double bmi = _weight / ((_height / 100) * (_height / 100));
    setState(() {
      _bmiResult = bmi.toStringAsFixed(1);
      if (bmi < 18.5) {
        _bmiStatus = 'Underweight';
      } else if (bmi < 24.9) {
        _bmiStatus = 'Normal';
      } else if (bmi < 29.9) {
        _bmiStatus = 'Overweight';
      } else {
        _bmiStatus = 'Obese';
      }
    });
  }

  void _setGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  label: 'Male',
                  isSelected: _gender == 'Male',
                  onPressed: () => _setGender('Male'),
                ),
                SizedBox(width: 115),
                Button(
                  label: 'Female',
                  isSelected: _gender == 'Female',
                  onPressed: () => _setGender('Female'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text('Weight', style: TextStyle(color: Colors.grey)),
                      Text(
                        '$_weight',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _decrementWeight,
                            icon: const Icon(Icons.remove),
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: _incrementWeight,
                            icon: const Icon(Icons.add),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 75),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text('Age', style: TextStyle(color: Colors.grey)),
                      Text(
                        '$_age',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _decrementAge,
                            icon: const Icon(Icons.remove),
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: _incrementAge,
                            icon: const Icon(Icons.add),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Height',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Height',
                  ),
                  onChanged: (value) {
                    _height = double.tryParse(value) ?? 170;
                  },
                ),
              ),
            ),
            SizedBox(height: 80),
            if (_bmiResult.isNotEmpty)
              Column(
                children: [
                  Text(
                    '$_bmiResult',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Text(
                    ' $_bmiStatus',
                    style: const TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ],
              ),
            SizedBox(height: 80),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: _calculateBMI,
                  child: const Text(
                    'Let\'s Go',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const Button({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
