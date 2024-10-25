import 'package:flutter/material.dart';

class ReviewScreenViewModel extends ChangeNotifier {
  String generateTextReviewSelfStudy(int incorrectScore, int correctScore) {
    double progressPercent =
        (correctScore / (incorrectScore + correctScore)) * 100;
    if (progressPercent == 100) {
      return 'Chà, bạn nắm bài\nthật chắc! Hãy thử\nchế độ Học để ôn\nluyện thêm.';
    } else if (progressPercent >= 80) {
      return 'Bạn đang làm rất\ntuyệt! Hãy tiếp tục tập\ntrung vào các thuật ngữ khó.';
    } else if (progressPercent >= 50) {
      return 'Bạn đang tiến bộ!\nHãy cố gắng ôn tập\nthêm các thuật ngữ\nchưa thuộc.';
    } else if (progressPercent >= 20) {
      return 'Đừng nản chí!\nHãy tập trung vào\ncác thuật ngữ cơ bản\ntrước.';
    } else {
      return 'Hãy kiên nhẫn và\ntiếp tục cố gắng!\nMỗi ngày một ít\nsẽ tiến bộ dần.';
    }
  }

  String generateTextReviewIntermittentStudy(Map<String, int> data) {
    int incorrectScore = data["Học lại"]! + data["Khó"]!;
    int correctScore = data['Dễ']! + data['Tốt']!;
    double progressPercent =
        (correctScore / (incorrectScore + correctScore)) * 100;
    if (progressPercent == 100) {
      return 'Chà, bạn nắm bài\nthật chắc! Hãy thử\nchế độ Học để ôn\nluyện thêm.';
    } else if (progressPercent >= 80) {
      return 'Bạn đang làm rất\ntuyệt! Hãy tiếp tục tập\ntrung vào các thuật ngữ khó.';
    } else if (progressPercent >= 50) {
      return 'Bạn đang tiến bộ!\nHãy cố gắng ôn tập\nthêm các thuật ngữ\nchưa thuộc.';
    } else if (progressPercent >= 20) {
      return 'Đừng nản chí!\nHãy tập trung vào\ncác thuật ngữ cơ bản\ntrước.';
    } else {
      return 'Hãy kiên nhẫn và\ntiếp tục cố gắng!\nMỗi ngày một ít\nsẽ tiến bộ dần.';
    }
  }
}
