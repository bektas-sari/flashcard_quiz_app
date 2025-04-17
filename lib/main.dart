import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardQuizApp());
}

class FlashcardQuizApp extends StatelessWidget {
  const FlashcardQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const FlashcardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  final List<Flashcard> flashcards = [
    Flashcard(question: "What is the capital of France?", answer: "Paris"),
    Flashcard(question: "What is 2 + 2?", answer: "4"),
    Flashcard(
      question: "Which planet is known as the Red Planet?",
      answer: "Mars",
    ),
  ];

  int currentIndex = 0;
  bool showAnswer = false;
  Color cardColor = Colors.white;

  void _flipCard() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  void _nextCard(bool isCorrect) {
    setState(() {
      cardColor = isCorrect ? Colors.green.shade100 : Colors.red.shade100;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        cardColor = Colors.white;
        showAnswer = false;
        if (currentIndex < flashcards.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Quiz'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 220,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    showAnswer ? flashcard.answer : flashcard.question,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (showAnswer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _nextCard(true),
                    icon: const Icon(Icons.check),
                    label: const Text('Correct'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _nextCard(false),
                    icon: const Icon(Icons.close),
                    label: const Text('Wrong'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              )
            else
              const Text('Tap the card to reveal the answer'),
          ],
        ),
      ),
    );
  }
}

class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}
