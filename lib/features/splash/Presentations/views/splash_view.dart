import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wateen/features/splash/Presentations/views/widgets/pulse_line_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 200),
                Image.asset(
                  'assets/images/wateen_logo.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 32),
                const PulseLineWidget(),
              ],
            ),
          ),
        ),

        // Bottom Curves
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/svgs/splash_bottom_curves.svg',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
