import 'package:flutter/material.dart';
import 'package:mentalove_app/ui/shared/theme.dart';

class NewForm extends StatelessWidget {
  final TextEditingController controller;
  final String nama;
  final String hintText;
  final bool obscureText;
  final double horizontalPadding;

  const NewForm({
    super.key,
    required this.controller,
    required this.nama,
    required this.hintText,
    required this.obscureText,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nama,
            style: blackTextStyle.copyWith(fontSize: 16),
          ),

          const SizedBox(
            height: 10,
          ),

          //TextField
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffB46BE9)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: hintText,
                hintStyle: blackTextStyle.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
