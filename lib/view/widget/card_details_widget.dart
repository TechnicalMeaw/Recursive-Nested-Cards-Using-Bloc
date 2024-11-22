import 'package:flutter/material.dart';
import 'package:redoq_assignment/utils/color_constants.dart';

class CardDetailsWidget extends StatelessWidget {
  const CardDetailsWidget({super.key, required this.name, required this.age, this.onEditClicked});
  final String name;
  final int age;
  final Function()? onEditClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(color: ColorConstants.textColor, fontSize: 14, fontWeight: FontWeight.w500),),
            Text("$age Years Old", style: const TextStyle(color: ColorConstants.textColorFaded, fontSize: 12, fontWeight: FontWeight.w400),)
          ],
        ),

        const SizedBox(width: 8,),
        InkWell(
            onTap: onEditClicked,
            child: const Icon(Icons.edit))
      ],
    );
  }
}
