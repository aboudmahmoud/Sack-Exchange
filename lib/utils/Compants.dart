
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../data/remote/repostroy.dart';
import '../moudel/QusteionMoudel.dart';
import '../screens/QusetionDetislScreen.dart';



Container QustionIndex(Items items) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    color: Colors.white,
    child: Column(
      children: [
        InkWell(
            onTap: () {
              Respostry.itemsRobo = items;
              Get.to(() => QusteionDetialScreen());
            },
            child: Text(items.title!)),
      ],
    ),
  );
}