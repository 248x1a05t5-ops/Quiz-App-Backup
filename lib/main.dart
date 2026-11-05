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
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
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
      'questionText': 'What is the programming language used by Flutter?',
      'answers': ['Python', 'Java', 'Dart', 'Kotlin'],
      'correctAnswer': 'Dart',
    },
    {
      'questionText': 'Who developed the Flutter framework?',
      'answers': ['Facebook', 'Google', 'Microsoft', 'Apple'],
      'correctAnswer': 'Google',
    },
    {
      'questionText': 'Which widget is used for repeating structural layouts?',
      'answers': ['ListView', 'Text', 'Container', 'Stack'],
      'correctAnswer': 'ListView',
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
        title: const Text('Quiz App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentQuestionIndex < _questions.length
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _questions[_currentQuestionIndex]['questionText'] as String,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ...(_questions[_currentQuestionIndex]['answers'] as List<String>).map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(answer),
                        child: Text(answer, style: const TextStyle(fontSize: 16)),
                      ),
                    );
                  }),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Quiz Finished!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Your Score: $_score / ${_questions.length}', style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _resetQuiz,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Restart Quiz'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
