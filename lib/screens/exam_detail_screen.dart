import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String getTimeRemaining() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);

    if (diff.isNegative) return 'Испитот е завршен.';

    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final isPast = exam.dateTime.isBefore(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subject),
        backgroundColor: Colors.indigo[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isPast ? Colors.red[50] : Colors.green[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isPast ? Colors.red : Colors.green,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Датум и време:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(DateFormat('dd MMM yyyy – HH:mm').format(exam.dateTime), style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Text('Просторија:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(exam.rooms.join(', '), style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              Text(
                isPast ? 'Испитот е завршен' : '⏳ ${getTimeRemaining()}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPast ? Colors.red : Colors.green[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
