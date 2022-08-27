import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NewCategorySheet extends StatelessWidget {
  const NewCategorySheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    int colorId = 0;
    int iconId = 0;

    void changeColorId(int newColorId) {
      colorId = newColorId;
    }

    void changeIconId(int newIconId) {
      iconId = newIconId;
    }

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Container(
          // * Padding is used when keyboard is shown.
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sheet holder.
                const SheetHolderWidget(),

                const SizedBox(height: 8),

                // Title.
                const Text(
                  'New Category',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                // Category name input.
                ClipRRect(
                  // Make the input field round.
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: TextField(
                      controller: categoryController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Category name',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                // Color picker.
                ColorSliderWidget(
                  title: 'Choose category color',
                  currentColorId: colorId,
                  colorsList: SliderColors.categoriesColors,
                  getChangedColorId: changeColorId,
                ),

                const SizedBox(height: 16),
                // Icon picker.
                ListIconButtonBar(
                  title: 'Choose category icon',
                  selectedIconId: iconId,
                  getChangedIconId: changeIconId,
                ),

                const SizedBox(height: 24),
                // Button bar.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel button.
                    ButtonWidget(
                      icon: Icons.close,
                      label: 'Cancel',
                      color: Theme.of(context).colorScheme.error,
                      size: const ButtonSize(
                        width: 124,
                        height: 42,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                    ),

                    // Save button.
                    BlocListener<CategoryCubit, CategoryState>(
                      listener: (context, state) {
                        if (state is CategoryCreateDone) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Category created successfully!'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Navigator.pop(context);
                        } else if (state is CategoryCreateError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: ButtonWidget(
                        icon: Icons.done_rounded,
                        label: 'Add',
                        size: const ButtonSize(
                          width: 124,
                          height: 42,
                        ),
                        onPressed: () async {
                          HapticFeedback.lightImpact();
                          BlocProvider.of<CategoryCubit>(context)
                              .createCategory(
                            name: categoryController.text,
                            colorId: colorId,
                            iconId: iconId,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
