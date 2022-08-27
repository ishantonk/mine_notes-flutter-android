import 'package:flutter/material.dart';
import 'package:mine_notes/utils/utils.dart';

class ColorSliderWidget extends StatefulWidget {
  const ColorSliderWidget({
    Key? key,
    required this.title,
    required this.colorsList,
    required this.currentColorId,
    required this.getChangedColorId,
  }) : super(key: key);
  final String title;
  final List<Color> colorsList;
  final int currentColorId;
  final Function getChangedColorId;

  @override
  State<ColorSliderWidget> createState() => _ColorSliderWidgetState();
}

class _ColorSliderWidgetState extends State<ColorSliderWidget> {
  late int stateColorId;

  @override
  void initState() {
    super.initState();
    stateColorId = widget.currentColorId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title.
        Align(
          alignment: Alignment.center,
          child: Text(widget.title),
        ),

        const SizedBox(height: 4),
        // List of colors.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(widget.colorsList.length,
                  (index) => _buildColor(context, index)),
            ),
          ),
        ),
      ],
    );
  }

  _buildColor(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateColorId = index;
        });
        widget.getChangedColorId(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: SliderColors.borderColor, width: 1),
          shape: BoxShape.circle,
          color: SliderColors.borderColor,
        ),
        child: CircleAvatar(
          foregroundColor: SliderColors.foregroundColor,
          backgroundColor: widget.colorsList[index],
          child: stateColorId == index ? const Icon(Icons.check) : null,
        ),
      ),
    );
  }
}
