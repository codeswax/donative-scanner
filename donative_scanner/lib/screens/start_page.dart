import 'package:flutter/material.dart';
import 'package:donative_scanner/widgets/credentials.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/image.png'),
                fit: BoxFit.cover,
              ),
              UserCredentialsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
