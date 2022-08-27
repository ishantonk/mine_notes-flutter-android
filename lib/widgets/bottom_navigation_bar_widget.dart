import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/cubits/cubits.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      'notes': {
        'icon': AnimatedIcons.home_menu,
        'activeIconColor': Colors.amberAccent,
        'title': 'Home',
        'index': 0,
      },
      'categories': {
        'icon': AnimatedIcons.menu_close,
        'activeIconColor': Colors.lightGreenAccent,
        'title': 'Category',
        'index': 1,
      },
      'archives': {
        'icon': AnimatedIcons.list_view,
        'activeIconColor': Colors.lightBlueAccent,
        'title': 'Archive',
        'index': 2,
      },
      'settings': {
        'icon': AnimatedIcons.add_event,
        'activeIconColor': Colors.redAccent,
        'title': 'Settings',
        'index': 3,
      },
    };

    return AnimatedContainer(
      color: Colors.black,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final key in data.keys)
            BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
              builder: (context, state) {
                final currentIndex =
                    BlocProvider.of<HomeNavigationCubit>(context)
                        .getPageIndex();
                final item = data[key];
                final isActive = currentIndex == item['index'];
                return IconButton(
                  icon: AnimatedIcon(
                    icon: item['icon'],
                    semanticLabel: item['title'],
                    color: isActive ? item['activeIconColor'] : Colors.grey,
                    size: isActive ? 28 : 20,
                    progress: _animationController,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    widget.pageController.jumpToPage(item['index']);
                    BlocProvider.of<HomeNavigationCubit>(context)
                        .changeIndex(item['index']);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
