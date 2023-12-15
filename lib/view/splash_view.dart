import 'package:flutter/material.dart';
import 'package:news_app/Res/Components/loading_spinner.dart';
import 'package:news_app/Res/assets/app_assets.dart';
import 'package:news_app/Res/colors/app_colors.dart';
import 'package:news_app/Res/text%20styles/app_text_styles.dart';
import 'package:news_app/ViewModel/Splash%20Services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.splashTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.splashImage,
            fit: BoxFit.cover,
            height: size.height * .5,
          ),
          SizedBox(
            height: size.height * .04,
          ),
          Text('Top Headlines', style: AppTextStyles.normalStyle(
            color: AppColors.greyContent
          ),),
          SizedBox(
            height: size.height * .04,
          ),
          const ReusableSpinner(
            linearWaveLoading: false,
            circleWaveLoading: true,
            circleLinesLoading: false,
            glassFillLoading: false,
          )
        ],
      ),
    );
  }
}
