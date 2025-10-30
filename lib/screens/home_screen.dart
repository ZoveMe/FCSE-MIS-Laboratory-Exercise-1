import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Exam> getExams() {
    return [
      Exam(subject: 'Администрација на бази податоци', dateTime: DateTime(2025, 11, 3, 10, 0), rooms: ['Лаб. 2']),
      Exam(subject: 'Мрежна и мобилна форензика', dateTime: DateTime(2025, 10, 26, 14, 0), rooms: ['Лаб. 3']),
      Exam(subject: 'Дистрибуирани системи', dateTime: DateTime(2025, 10, 29, 9, 0), rooms: ['Лаб. 117']),
      Exam(subject: 'Пресметување во облак', dateTime: DateTime(2025, 10, 30, 11, 30), rooms: ['Лаб. 215']),
      Exam(subject: 'Интернет на нештата', dateTime: DateTime(2025, 10, 25, 12, 0), rooms: ['Лаб. 138']),
      Exam(subject: 'Мобилни информациски системи', dateTime: DateTime(2025, 11, 10, 13, 0), rooms: ['Лаб. 200в']),
      Exam(subject: 'Програмирање на видео игри', dateTime: DateTime(2025, 11, 4, 15, 0), rooms: ['Лаб. 13']),
      Exam(subject: 'Иновации во ИКТ', dateTime: DateTime(2025, 11, 7, 8, 0), rooms: ['Лаб. 3']),
      Exam(subject: 'Мобилни платформи и програмирање', dateTime: DateTime(2025, 11, 1, 10, 0), rooms: ['Лаб. 12']),
      Exam(subject: 'Социјални мрежи и медуми', dateTime: DateTime(2025, 11, 6, 16, 0), rooms: ['115 TMФ']),
    ]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    final exams = getExams();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[100],
        title: const Text(
          '📚 Распоред за испити - 222022',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(
                  exam: exams[index],
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ExamDetailScreen(exam: exams[index]),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          final tween = Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.easeOut));
                          final fadeTween = Tween(begin: 0.0, end: 1.0);

                          return FadeTransition(
                            opacity: animation.drive(fadeTween),
                            child: ScaleTransition(
                              scale: animation.drive(tween),
                              child: child,
                            ),
                          );
                        },
                      ),
                    );

                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.indigo[50],
            child: Text(
              'Вкупно испити: ${exams.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
