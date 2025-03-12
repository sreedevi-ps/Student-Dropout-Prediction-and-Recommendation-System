import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class PreditLoader extends StatelessWidget {
  const PreditLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      spacing: 10,
      children: [
        SpinKitDualRing(
          color: AppColors.orange,
          size: 30.0,
        ),
        Text(
          "checking chances for drop-out",
          style: TextStyle(color: Colors.white, fontSize: 8),
        )
      ],
    );
  }
}
