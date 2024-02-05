import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onClick;
  final bool isEnabled;

  const ProfileItem(
      {Key? key,
      required this.icon,
      required this.name,
      required this.onClick,
      this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ElevatedButton(
        onPressed: isEnabled ? onClick : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Container(
          constraints: const BoxConstraints(minHeight: 50),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 10),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
