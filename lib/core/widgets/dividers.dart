import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

Widget orDivider({double height = 20}) => Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
            height: height,
            color: AppColors.shadedColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Or",
            style: TextStyle(fontSize: 18, color: AppColors.shadedColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            height: height,
            color: AppColors.shadedColor,
          ),
        ),
      ],
    );
