import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

String candy = '🍬';


class MyDraggableItem {
  final String emoji;
  
  MyDraggableItem(this.emoji);
}



class CandyButton extends StatefulWidget {
  final Function() onCandyGenerated; 
  final Function() growCircle;

  CandyButton({required this.onCandyGenerated, required this.growCircle});
  
  @override
  _CandyButtonState createState() => _CandyButtonState();
}

class _CandyButtonState extends State<CandyButton> {

  String randCandy() {
    final random = Random();
    int randomNumber = random.nextInt(1000);
  
    if (randomNumber < 400) {
      return '🍬';
    } else if (randomNumber < 600) {
     return '🍫';
    } else if (randomNumber < 700) {
     return '👻';
    } else if (randomNumber < 800) {
      return '😈';
    } else if (randomNumber < 850) {
      return '👽';
    } else if (randomNumber < 875) {
      return '👺';
    } else {
     return '🍭';
    }
  }

  void updateCandy() {
    setState(() {
      candy = randCandy();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child: Container(
            height: 150,
            width: 500,
            child: FittedBox(
              child: ElevatedButton(
                onPressed: () {
                  widget.onCandyGenerated();
                  updateCandy();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: DragTarget<MyDraggableItem>(
                  builder: (context, candidateItems, rejectedItems) {
                    return Text(
                      candy, 
                      style: const TextStyle(color: Colors.amber, fontSize: 30.0)
                    );
                  },
                  onAccept: (item) {
                    widget.growCircle();
                    updateCandy();
                  }
                ),
              ),
            ),
          ),
          ),
        ]
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Candy Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double ringSize = 0.0;

  void _incrementCounter(String candy) {
    setState(() {
      if (candy == '🍬') {
        _counter++;
      }
      else if (candy == '🍫') {
        _counter += 10;
      }
      else if (candy == '👺') {
        _counter = 0;
      }
      else if (candy == '👻') {
        if (_counter - 50 > 0) {
          _counter -= 50;
        } else {
          _counter = 0;
        }
      }
      else if (candy == '😈') {
        if (_counter - 100 > 0) {
          _counter -= 100;
        } else {
          _counter = 0;
        }
      }
      else if (candy == '👽') {
        if (_counter - 500 > 0) {
          _counter -= 200;
        } else {
          _counter = 0;
        }      }
      else {
        _counter += 50;
      }
    });
  }
  
  void _expandRing() {
    setState(() {
       ringSize = 150.0;
    });
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
         ringSize = 0.0;
      });
    });
  }
    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF5d5c58),
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80.0,
        title: Center(child: 
          Text(
            widget.title, 
            style: GoogleFonts.nosifer(
              textStyle: const TextStyle(fontSize: 60.0, color: Color(0xFF1ce619)),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  'You have collected:',
                  style: GoogleFonts.creepster(
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$_counter',
                  style: GoogleFonts.nosifer(
                    textStyle: const TextStyle(
                      color: Color(0xFF1ce619),
                      fontSize: 150.0,//Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'pieces of candy!',
                  style: GoogleFonts.creepster(
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(height: 55.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Center(child: CandyButton(onCandyGenerated: () => _incrementCounter(candy), growCircle: _expandRing)),
                    ),
                    Positioned(
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: ringSize,
                            height: ringSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60.0,
            right: 50.0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Color(0xFFb00b40),
              ),
              child: Draggable<MyDraggableItem>( 
                data: MyDraggableItem("⚔️"),
                feedback: const Text(
                  "⚔️",
                  style: TextStyle(
                    fontSize: 120.0,
                    decoration: TextDecoration.none,
                    color: Color(0xFFc61ddc),
                  )
                ),
                child: const Text(
                  "⚔️",
                  style: TextStyle(
                    fontSize: 100.0,
                    decoration: TextDecoration.none,
                    color: Color(0xFFdcdcdb),
                  )
                ),
             ),
            ),
          ),
        ],
      ),
    );
  }
}