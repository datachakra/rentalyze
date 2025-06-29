import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String label;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 24,
            width: 24,
            errorBuilder: (context, error, stackTrace) {
              // Fallback icon if image not found
              return Icon(
                _getIconForProvider(label),
                size: 24,
                color: _getColorForProvider(label),
              );
            },
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForProvider(String label) {
    if (label.contains('Google')) {
      return Icons.g_mobiledata;
    } else if (label.contains('Apple')) {
      return Icons.apple;
    } else if (label.contains('Facebook')) {
      return Icons.facebook;
    }
    return Icons.login;
  }

  Color _getColorForProvider(String label) {
    if (label.contains('Google')) {
      return Colors.red;
    } else if (label.contains('Apple')) {
      return Colors.black;
    } else if (label.contains('Facebook')) {
      return Colors.blue;
    }
    return Colors.grey;
  }
}