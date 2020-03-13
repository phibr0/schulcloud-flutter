import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:schulcloud/app/app.dart';

class SignOutScreen extends StatefulWidget {
  @override
  _SignOutScreenState createState() => _SignOutScreenState();
}

class _SignOutScreenState extends State<SignOutScreen> {
  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      // This should probably be awaited, but right now awaiting it
      // leads to the issue that logging out becomes impossible.
      unawaited(services.get<StorageService>().clear());

      unawaited(SchulCloudApp.navigator.pushReplacementNamed('/login'));
      logger.i('Logged out!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text(
              'Signing out…',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}