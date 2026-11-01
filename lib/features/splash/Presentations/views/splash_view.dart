import 'package:flutter/material.dart';
import 'package:wateen/features/splash/Presentations/views/widgets/pulse_line_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/wateen_logo.png',
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(height: 32,),
        PulseLineWidget(),

      ],
    );
  }
}
