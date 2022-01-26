import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AppFormFields extends StatelessWidget {
  const AppFormFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Form Fields'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            AppButton.primary(
              onPressed: () {},
              child: const AppTextField(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
