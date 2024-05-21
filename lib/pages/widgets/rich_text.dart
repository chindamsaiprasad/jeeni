import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String number;
  final String firstText;
  final String secondText;
  final String thirdText;
  final Color color;
  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.color,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number) ",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: firstText),
                  TextSpan(
                    text: secondText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  TextSpan(text: thirdText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
