import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resulText;
    if (resultScore <= 10) {
      resulText = "you are stupid!";
    } else if (resultScore <= 20) {
      resulText = "go study!!";
    } else if (resultScore <= 40) {
      resulText = "good";
    } else {
      resulText = "wow!!! topper!";
    }
    return resulText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetHandler,
            child: Text('restart quiz'),
            style: ElevatedButton.styleFrom(primary: Colors.amberAccent),
          )
        ],
      ),
    );
  }
}
