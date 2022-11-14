import 'package:flutter/material.dart';

import '../data/remote/repostroy.dart';


class QusteionDetialScreen extends StatefulWidget {
  const QusteionDetialScreen({Key? key}) : super(key: key);

  @override
  State<QusteionDetialScreen> createState() => _QusteionDetialScreenState();
}

class _QusteionDetialScreenState extends State<QusteionDetialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Answerd: ${Respostry.itemsRobo.isAnswered}"),
                  Text("Asked By: ${Respostry.itemsRobo.owner!.displayName}"),
                  Text("Number Of Answer That Given: ${Respostry.itemsRobo.answerCount}")


                ],

              )

          )
      )),
    );
  }
}
