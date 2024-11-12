import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(500,35,153,160)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isImageSmall = false;
  double _number1 = 0;
  double _number2 = 0;
  double _result = 0;
  String _operation = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _toggleImageSize() {
    setState(() {
      _isImageSmall = !_isImageSmall;
    });
  }

  void _calculateResult(String operation) {
    setState(() {
      switch (operation) {
        case '+':
          _result = _number1 + _number2;
          _operation = 'Сложение';
          break;
        case '-':
          _result = _number1 - _number2;
          _operation = 'Вычитание';
          break;
        case '*':
          _result = _number1 * _number2;
          _operation = 'Умножение';
          break;
        case '/':
          if (_number2 != 0) {
            _result = _number1 / _number2;
            _operation = 'Деление';
          } else {
            _result = 0;
            _operation = 'Ошибка: деление на ноль';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Калькулятор'),
      ),
      body: Stack(
        children: <Widget>[
          // Центральное изображение
          Center(
            child: GestureDetector(
              onTap: _toggleImageSize,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isImageSmall ? 100 : 400,
                height: _isImageSmall ? 100 : 400,
                child: Image.asset(
                  'assets/image/фон.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Калькулятор в левой части
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              width: 220,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Поле для первого числа
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _number1 = double.tryParse(value) ?? 0;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '1-е число',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Поле для второго числа
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _number2 = double.tryParse(value) ?? 0;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '2-е число',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Кнопки операций
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOperationButton('+'),
                      _buildOperationButton('-'),
                      _buildOperationButton('×', '*'),
                      _buildOperationButton('÷', '/'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Результат
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Операция: $_operation',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Результат: ${_result.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Счетчик в нижней части
          Positioned(
            left: 16,
            bottom: 80,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Счетчик нажатий:',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Уменьшить',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Увеличить',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationButton(String label, [String? operation]) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ElevatedButton(
        onPressed: () => _calculateResult(operation ?? label),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}