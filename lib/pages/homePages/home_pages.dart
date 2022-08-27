import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
// Bloc imports.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';
// Screen imports.
import 'package:mine_notes/pages/homePages/archives_home.dart';
import 'package:mine_notes/pages/homePages/categories_home.dart';
import 'package:mine_notes/pages/homePages/notes_home.dart';
import 'package:mine_notes/pages/homePages/settings_home.dart';
// BottomNavigationBar imports.
import 'package:mine_notes/widgets/bottom_navigation_bar_widget.dart';

// This is the main home page.
class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Change the system navigation bar color.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
      ),
    );
    // PageController for screen swiping and animation.
    final PageController pageController =
        PageController(initialPage: 0, keepPage: true);

    // List of pages to display on the home screen.
    final List<Widget> screens = [
      const NotesHome(),
      const CategoriesHome(),
      const ArchivesHome(),
      const SettingsHome(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),

        // PageView is used to display the pages in the home screen.
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PageView(
              physics: const PageScrollPhysics(),
              controller: pageController,
              restorationId: 'home_page',
              onPageChanged: (index) {
                BlocProvider.of<HomeNavigationCubit>(context)
                    .changeIndex(index);
              },
              children: screens,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the sign up page.
          Navigator.pushNamed(context, 'new_note');
        },
        child: const Icon(Iconsax.add),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar:
          BottomNavigationBarWidget(pageController: pageController),
    );
  }
}
