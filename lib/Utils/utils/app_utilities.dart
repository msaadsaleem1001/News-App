
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Res/Components/loading_spinner.dart';
import 'package:news_app/Res/colors/app_colors.dart';
import 'package:news_app/Res/text%20styles/app_text_styles.dart';

class Utils {
  static void generateSnackBar(String title, String msg) {
    Get.snackbar(title, msg,
        titleText: Text(
          title,
          style: AppTextStyles.headerTextStyle(color: AppColors.white),
        ),
        messageText: Text(
          msg,
          style: AppTextStyles.normalStyle(color: AppColors.white),
        ),
        colorText: AppColors.white,
        backgroundColor: AppColors.greyContent,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showBottomSheet(
      BuildContext context,
      String newsSourceName,
      String newsTitle,
      String newsDescription,
      String imageUrl,
      String newsContent,
      String publishedAt) {
    Get.bottomSheet(
      Column(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const ReusableSpinner(
                  linearWaveLoading: true,
                  circleWaveLoading: false,
                  circleLinesLoading: false,
                  glassFillLoading: false),
              fit: BoxFit.cover,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * .33,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * .6,
              width: MediaQuery.sizeOf(context).width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Source: $newsSourceName',
                            style: AppTextStyles.readableStyle(
                                color: AppColors.themeColor, fontSize: 12)),
                      ],
                    ),
                    Text('Title:\n$newsTitle',
                        style: AppTextStyles.montserratStyle(
                            color: AppColors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('Description:\n$newsDescription',
                        style: AppTextStyles.normalStyle(
                            color: AppColors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Text('News Content:\n$newsContent',
                        style: AppTextStyles.readableStyle(
                            color: AppColors.black, fontSize: 16)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Published at: $publishedAt',
                            style: AppTextStyles.readableStyle(
                                color: AppColors.themeColor, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          )
        ],
      ),
      ignoreSafeArea: false,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      enterBottomSheetDuration: const Duration(milliseconds: 1000),
      exitBottomSheetDuration: const Duration(milliseconds: 1000),
    );
  }
}
