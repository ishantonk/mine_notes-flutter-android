import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/utils/utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Title image.
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: ScrollController(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and description.
                const Text(
                  'Welcome to the Note App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is a simple note app that you can use to keep track of your notes.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You can add notes, edit them, and delete them.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You can also share your notes with your friends.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Enjoy!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 32),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    // Sign in button or sign up button.
                    onPressed: () {
                      // Navigate to the sign in page.
                      Navigator.pushNamedAndRemoveUntil(context,
                          AppRoutes.signInPage, (route) => route.isFirst);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Get Started',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Iconsax.arrow_right_3)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
