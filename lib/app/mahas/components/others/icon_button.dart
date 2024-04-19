// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../mahas_colors.dart';
import '../mahas_themes.dart';

class ButtonWithIcon extends StatefulWidget {
  final String label;
  final Icon? icon;
  final Color? color;
  final double? radius;
  final Function()? onTap;

  const ButtonWithIcon({
    Key? key,
    required this.label,
    this.onTap,
    this.icon,
    this.color,
    this.radius,
  }) : super(key: key);

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color ?? MahasColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(widget.radius ?? MahasThemes.borderRadius)),
        ),
      ),
      onPressed: widget.onTap ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon ?? Icon(FontAwesomeIcons.envelope),
          const Padding(padding: EdgeInsets.all(5)),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
              )
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
