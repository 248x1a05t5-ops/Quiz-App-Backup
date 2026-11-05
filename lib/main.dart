import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey[50], // Light elegant background
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': '1. What is the programming language used by Flutter?',
      'answers': ['Python', 'Java', 'Dart', 'Kotlin'],
      'correctAnswer': 'Dart',
    },
    {
      'questionText': '2. Who developed the Flutter framework?',
      'answers': ['Facebook', 'Google', 'Microsoft', 'Apple'],
      'correctAnswer': 'Google',
    },
    {
      'questionText': '3. What is the capital of India?',
      'answers': ['Mumbai', 'New Delhi', 'Hyderabad', 'Bengaluru'],
      'correctAnswer': 'New Delhi',
    },
    {
      'questionText': '4. Which planet is known as the Red Planet?',
      'answers': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars',
    },
    {
      'questionText': '5. What is the largest ocean on Earth?',
      'answers': ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      'correctAnswer': 'Pacific Ocean',
    }
  ];

  void _answerQuestion(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Quiz App', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: SingleChildScrollView( // ఇక్కడ స్క్రోలింగ్ యాడ్ చేశాను bro, దీనివల్ల ఓవర్‌ఫ్లో ఎర్రర్ రాదు!
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _currentQuestionIndex < _questions.length
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // క్వశ్చన్ కార్డ్
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            _questions[_currentQuestionIndex]['questionText'] as String,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25), // స్పేస్ కొంచెం తగ్గించాను
                      
                      // ఆప్షన్స్ బటన్స్
                      ...(_questions[_currentQuestionIndex]['answers'] as List<String>).map((answer) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 2,
                            ),
                            onPressed: () => _answerQuestion(answer),
                            child: Text(answer, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        );
                      }),
                    ],
                  )
                : Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_events, size: 70, color: Colors.amber),
                          const SizedBox(height: 15),
                          const Text('Quiz Finished!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal)),
                          const SizedBox(height: 15),
                          Text('Your Score: $_score / ${_questions.length}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 25),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: _resetQuiz,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Restart Quiz', style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
