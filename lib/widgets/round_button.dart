import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String title;
  bool loading;
  final VoidCallback ontap;
  RoundButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: loading
                ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white)
                : Text(title, style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
