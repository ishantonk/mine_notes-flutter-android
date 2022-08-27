import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/utils/utils.dart';
// Firebase imports.
import 'package:firebase_auth/firebase_auth.dart';
// Bloc imports.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';

// User details page.
class UserDetailsAccount extends StatelessWidget {
  const UserDetailsAccount({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // Input fields controllers.
    final TextEditingController nameController = TextEditingController();

    // Profile image container.
    File? profileImage;

    // Check if the user has a display name.
    if (user.displayName != null) {
      nameController.text = user.displayName ?? '';
    }

    // Widget.
    return Material(
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess) {
            // Navigate to the home page.
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.homePage, (route) => route.isFirst);
          }
          if (state is AccountSuccess) {
          } else if (state is AccountChangeProfile) {
            profileImage = state.profileImage;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              // Title and description.
              Image.asset('assets/images/user-details.png',
                  height: 200, width: double.infinity),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey there!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Let\'s get to know you better'),
                    const SizedBox(height: 24),

                    // Choose profile image button.
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<AccountCubit>(context)
                              .chooseProfileImage();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.45),
                              backgroundImage: profileImage != null
                                  ? FileImage(profileImage!)
                                  : null,
                              radius: 50,
                              child: state is AccountChangeProfile
                                  ? null
                                  : const Icon(
                                      Iconsax.user,
                                      color: Colors.grey,
                                      size: 42,
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add a profile picture',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Name input field.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: TextField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 1,
                        autofocus: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          hintText: 'Name',
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.person),
                          errorText: state is AccountError
                              ? state.error['name']
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Finish button.
                    TextButton(
                      onPressed: () => BlocProvider.of<AccountCubit>(context)
                          .createUserDetails(
                              user, nameController.text, profileImage!),
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
                              'Finish',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
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
