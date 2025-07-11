import 'package:ecommerce/core/constant/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreInlineText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ReadMoreInlineText({
    super.key,
    required this.text,
    this.trimLength = 400,
  });

  @override
  State<ReadMoreInlineText> createState() => _ReadMoreInlineTextState();
}

class _ReadMoreInlineTextState extends State<ReadMoreInlineText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String fullText = widget.text;
    final bool isLong = fullText.length > widget.trimLength;
    final String visibleText =
        !_isExpanded && isLong ? fullText.substring(0, widget.trimLength) : fullText;

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          color: AppColors.subtitleColor,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(text: visibleText),
          if (!_isExpanded && isLong)
            TextSpan(
              text: '... Read More',
              style: TextStyle(
                color: AppColors.primaryColors,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Details'),
                      content: Text(fullText),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
            ),
        ],
      ),
    );
  }
}
