import 'package:flutter/material.dart';

class SwitchListTileWidget extends StatefulWidget {
  const SwitchListTileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.switchVal,
    required this.onChangeVal,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final bool switchVal;
  final Function onChangeVal;

  @override
  State<SwitchListTileWidget> createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<SwitchListTileWidget> {
  bool stateSwitchVal = false;

  @override
  void initState() {
    super.initState();
    stateSwitchVal = widget.switchVal;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
      title: Row(
        children: [
          Icon(widget.icon),
          const SizedBox(width: 32),
          Text(widget.title)
        ],
      ),
      value: stateSwitchVal,
      onChanged: (value) {
        setState(() {
          stateSwitchVal = value;
        });
        widget.onChangeVal(value);
      },
    );
  }
}
