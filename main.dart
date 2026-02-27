class Student {
  final String name;
  final double? grade1;
  final double? grade2;
  final double? grade3;

  Student({required this.name, this.grade1, this.grade2, this.grade3});

  /// Compute the average of non-null grades. Returns `null` when no grades
  /// have been provided so we can handle the absence of data safely.
  double? get average {
    final grades = <double?>[grade1, grade2, grade3];
    // filter out nulls
    final valid = grades.where((g) => g != null).cast<double>().toList();
    if (valid.isEmpty) return null;
    return valid.reduce((a, b) => a + b) / valid.length;
  }

  /// Provide a letter representation for the calculated average. Uses a
  /// `switch` with `when` clauses (Dart 3) to show the Kotlin-like `when`
  /// behaviour the user asked for.
  String get letterGrade {
    final avg = average;
    if (avg == null) return 'N/A';
    return _letterForAverage(avg);
  }

  static String _letterForAverage(double avg) {
    switch (avg) {
      case var g when g >= 90:
        return 'A';
      case var g when g >= 80:
        return 'B';
      case var g when g >= 70:
        return 'C';
      case var g when g >= 60:
        return 'D';
      default:
        return 'F';
    }
  }
}

void main() {
  // A handful of sample students demonstrating nullable inputs and safe
  // navigation.
  final students = <Student>[
    Student(name: 'Alice', grade1: 95, grade2: 85),
    Student(name: 'Bob'), // no grades at all
    Student(name: 'Charlie', grade2: 72), // one grade null
    Student(name: 'Diana', grade1: null, grade2: null, grade3: null),
  ];

  for (var s in students) {
    // the Elvis operator `??` provides a sensible default if average is null.
    final avgStr = s.average?.toStringAsFixed(2) ?? 'no grades';
    print('Student: ${s.name}');
    print('Average: $avgStr');
    print('Letter: ${s.letterGrade}');
    print('-------------');
  }
}
