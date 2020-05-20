import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String message;

  LoadingIndicatorWidget({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          width: 5,
        ),
        Text('Loading...')
      ],
    );
  }
}
