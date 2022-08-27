import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/utils/utils.dart';
// Bloc imports.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';

// Edit note page.
class SignUpAccount extends StatelessWidget {
  const SignUpAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Input fields controllers.
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    // Widget.
    return Material(
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess) {
            // Navigate to the user details page.
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.userDetailsPage, (route) => route.isFirst,
                arguments: state.user);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              // Title and description.
              Image.asset('assets/images/signup.png',
                  height: 200, width: double.infinity),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Please enter your details below'),
                    const SizedBox(height: 24),

                    // Email input field.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: emailController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          hintText: 'Email',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.email),
                          errorText: state is AccountError
                              ? state.error['email']
                              : null,
                        ),
                      ),
                    ),

                    // Password input field.
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: passwordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Iconsax.lock_15),
                          errorText: state is AccountError
                              ? state.error['password']
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Confirm password input field.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: confirmPasswordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          hintText: 'Confirm password',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Iconsax.lock_15),
                          errorText: state is AccountError
                              ? state.error['confirmPassword']
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign up button.
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AccountCubit>(context)
                            .signUpWithEmailAndPassword(
                          emailController.text.trim(),
                          passwordController.text,
                          confirmPasswordController.text,
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                      ),
                      child: state is AccountLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                        ),
                        const Text("OR"),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 10.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 36,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Google sign in button.
                    TextButton(
                      onPressed: () => BlocProvider.of<AccountCubit>(context)
                          .signUpWithGoogle(),
                      style: TextButton.styleFrom(
                        minimumSize: const Size.fromHeight(42),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                      ),
                      child: state is AccountLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const Text(
                              'Sign Up with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 32),

                    // Already have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Sign in button.
                        TextButton(
                          onPressed: () {
                            // Navigate to the sign up page.
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.signInPage, (route) => route.isFirst);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
