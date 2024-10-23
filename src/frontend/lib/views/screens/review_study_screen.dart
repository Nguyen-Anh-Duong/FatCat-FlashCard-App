import 'package:flutter/material.dart';
import 'package:FatCat/constants/colors.dart';

class ReviewStudyScreen extends StatelessWidget {
  final int? correctAnswers;
  final int? incorrectAnswers;
  final Map<String, int>? detailedAnswers;

  const ReviewStudyScreen({
    super.key,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.detailedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with close button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Tiến độ của bạn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // To balance the close button
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Checkmark icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Congratulatory text
                  const Text(
                    'Chà, bạn nắm bài\nthật chắc! Hãy thử\nchế độ Học để ôn\nluyện thêm.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Progress indicators
                  if (detailedAnswers != null) ...[
                    _buildProgressIndicator(
                        'Dễ', detailedAnswers!['Dễ'] ?? 0, Colors.green),
                    const SizedBox(height: 8),
                    _buildProgressIndicator(
                        'Tốt', detailedAnswers!['Tốt'] ?? 0, Colors.blue),
                    const SizedBox(height: 8),
                    _buildProgressIndicator(
                        'Khó', detailedAnswers!['Khó'] ?? 0, Colors.orange),
                    const SizedBox(height: 8),
                    _buildProgressIndicator('Học lại',
                        detailedAnswers!['Học lại'] ?? 0, Colors.red),
                  ] else ...[
                    _buildProgressIndicator(
                        'Biết', correctAnswers ?? 0, Colors.green),
                    const SizedBox(height: 8),
                    _buildProgressIndicator(
                        'Đang học', incorrectAnswers ?? 0, Colors.orange),
                    const SizedBox(height: 8),
                    _buildProgressIndicator('Còn lại', 0, Colors.grey),
                  ],
                ],
              ),
            ),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement "Ôn luyện trong chế độ Học" functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Ôn luyện trong chế độ Học',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement "Đặt lại Thẻ ghi nhớ" functionality
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Đặt lại Thẻ ghi nhớ',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
