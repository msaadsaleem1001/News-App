
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/Res/colors/app_colors.dart';

class ReusableSpinner extends StatelessWidget {
  final bool linearWaveLoading;
  final bool circleWaveLoading;
  final bool circleLinesLoading;
  final bool glassFillLoading;

  const ReusableSpinner({
    super.key,
    required this.linearWaveLoading,
    required this.circleWaveLoading,
    required this.circleLinesLoading,
    required this.glassFillLoading

  });

  @override
  Widget build(BuildContext context) {
    if(linearWaveLoading){
      return SpinKitWave(
        color: AppColors.themeColor,
        itemCount: 6,
      );
    }
    else if(circleWaveLoading) {
      return SpinKitWaveSpinner(
        color: AppColors.spinnerCircleColor,
        waveColor: AppColors.spinnerWaveColor,
        size: 80,
        trackColor: AppColors.spinnerTrackColor,
      );
    }
    else if(circleLinesLoading){
      return SpinKitSpinningLines(
          color: AppColors.greyContent,
      );
    }
    else{
      return SpinKitPouringHourGlass(
        color: AppColors.themeColor,
        strokeWidth: 1,

      );
    }
  }
}
