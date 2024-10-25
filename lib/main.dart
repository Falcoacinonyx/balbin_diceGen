import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dice Generator',
            style: TextStyle(
              fontFamily: 'JqksWildfont',
              color: Colors.black,
              fontSize: 30.0,
            ),

          ),
          backgroundColor: const Color(0xffA04747),
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int totalDiceRoll = 2;
  List<int> diceValues = [1, 1];

  void changeDiceValue() {
    setState(() {
      for (int i = 0; i < diceValues.length; i++) {
        diceValues[i] = 1 + Random().nextInt(6);
      }
      totalDiceRoll = diceValues.reduce((value, element) => value + element);
    });
  }

  void addDice() {
    if (diceValues.length < 6) {
      setState(() {
        diceValues.add(1);
        resetDiceValues();
      });
    }
  }

  void removeDice() {
    if (diceValues.length > 1) {
      setState(() {
        diceValues.removeLast();
        resetDiceValues();
      });
    }
  }

  void resetDiceValues() {
    setState(() {
      for (int i = 0; i < diceValues.length; i++) {
        diceValues[i] = 1;
      }
      totalDiceRoll = diceValues.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double diceSize = MediaQuery.of(context).size.width / 2.5;
    if (diceValues.length > 2) {
      diceSize = MediaQuery.of(context).size.width / 3.5;
    }
    if (diceValues.length > 4) {
      diceSize = MediaQuery.of(context).size.width / 4.5;
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background2.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < diceValues.length; i += 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (i < diceValues.length)
                  SizedBox(
                    width: diceSize,
                    height: diceSize,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('images/dice${diceValues[i]}.png'),
                    ),
                  ),
                if (i + 1 < diceValues.length)
                  SizedBox(
                    width: diceSize,
                    height: diceSize,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('images/dice${diceValues[i + 1]}.png'),
                    ),
                  ),
              ],
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 20.0, height: 100.0),
              Text(
                'Total Dice Roll: $totalDiceRoll',
                style: const TextStyle(fontSize: 30.0, color: Colors.white, fontFamily: 'JqksWildfont'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: addDice,
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color(0xffE6DEDD))
                ),
                child: const Text(
                    'Add Dice',
                    style: TextStyle(fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'JqksWildfont',
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: removeDice,
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Color(0xffE6DEDD))
                ),
                child: const Text(
                    'Remove Dice',
                    style: TextStyle(fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'JqksWildfont',
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: changeDiceValue,
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Color(0xffEEDF7A))
            ),
            child: const Text('  Roll Dice  ',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontFamily: 'JqksWildfont',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
