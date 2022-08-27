import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mine_notes/pages/pages.dart';

class AppRoutes {
  // Routes names.

  static const String welcomePage = 'welcome';

  // --Account routes.
  static const String signUpPage = 'signUp';
  static const String signInPage = 'signIn';
  static const String userDetailsPage = 'userDetails';

  // --Home routes.
  static const String homePage = 'home';
  static const String settingsPage = 'settings';
  static const String archivesPage = 'archives';
  static const String categoriesPage = 'categories';

  // --Note routes.
  static const String newNotePage = 'new_note';
  static const String editNotePage = 'edit_note';

// Controllers.

  // Control the routes.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    // Get the route name.
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(builder: (context) => const WelcomePage());

      // --Account routes.
      case signUpPage:
        return MaterialPageRoute(builder: (context) => const SignUpAccount());
      case signInPage:
        return MaterialPageRoute(builder: (context) => const SignInAccount());
      case userDetailsPage:
        if (args is User) {
          return MaterialPageRoute(
              builder: (context) => UserDetailsAccount(user: args));
        }
        throw Exception('User is required');

      // --Home routes.
      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePages());

      // --Note routes.
      case newNotePage:
        return MaterialPageRoute(builder: (context) => const NewNote());
      case editNotePage:
        if (args is DocumentSnapshot) {
          return MaterialPageRoute(builder: (context) => EditNote(note: args));
        }
        throw Exception('Note id is required');
      default:
        throw ('Unknown route: ${settings.name}');
    }
  }
}
