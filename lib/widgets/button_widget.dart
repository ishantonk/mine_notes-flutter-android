import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.color,
    this.size,
    this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final Color? color;
  final ButtonSize? size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Functionality of the button.
      onTap: onPressed ?? () {},
      borderRadius: BorderRadius.circular(16),
      focusColor: color?.withOpacity(0.2) ??
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
      splashColor: color?.withOpacity(0.2) ??
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
      // Button shape.
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color?.withOpacity(0.035) ??
              Theme.of(context).colorScheme.primary.withOpacity(0.035),
        ),
        height: size?.height ?? 48,
        width: size?.width ?? 124,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color ?? Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Class to get size of the button.
class ButtonSize {
  final double width;
  final double height;

  const ButtonSize({
    required this.width,
    required this.height,
  });
}
