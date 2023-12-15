

import 'package:flutter/material.dart';
import 'package:news_app/Res/colors/app_colors.dart';
import 'package:news_app/Res/text%20styles/app_text_styles.dart';


class InternetErrorWidget extends StatelessWidget {
  final String msg;
  VoidCallback callback;
  InternetErrorWidget({
    super.key,
    required this.msg,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 50,
            color: AppColors.error,
          ),
          const SizedBox(height: 20,),
          Text(
            msg,
            style: AppTextStyles.montserratStyle(
                color: AppColors.spinnerTrackColor,
                fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 20,),
          Center(
            child: InkWell(
                onTap: callback,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.greyContent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Retry',
                        style: AppTextStyles.montserratStyle(
                            color: AppColors.white,
                            fontSize: 14),
                      ),
                      Icon(Icons.refresh_rounded, size: 30, color: AppColors.white,),
                    ],
                  ),
                )
            ),
          )
        ]);
  }
}
