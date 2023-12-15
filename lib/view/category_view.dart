import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Data/Response/status.dart';
import 'package:news_app/Res/Components/exeption_widget.dart';
import 'package:news_app/Res/Components/loading_spinner.dart';
import 'package:news_app/Res/colors/app_colors.dart';
import 'package:news_app/Res/text%20styles/app_text_styles.dart';
import 'package:news_app/Utils/utils/app_utilities.dart';
import '../ViewModel/Category Services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = Get.put(CategoriesServices());
  final format = DateFormat('MMMM, dd, yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCategories(controller.categoriesList[0]);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.white,
          centerTitle: true,
          backgroundColor: AppColors.themeColor,
          title: Text('News Categories',
              style: AppTextStyles.normalStyle(
                  color: AppColors.white, fontSize: 20)),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: height * .05,
              width: width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categoriesList.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return InkWell(
                        enableFeedback: false,
                        onTap: () {
                          controller.setSelectedCategory(index);
                          controller
                              .getCategories(controller.categoriesList[index]);
                        },
                        child: Container(
                            margin: const EdgeInsets.all(2),
                            height: height * .05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color:
                                    controller.selectedCategory.value == index
                                        ? AppColors.selectedCategory
                                        : AppColors.greyContent),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                  child: Text(
                                controller.categoriesList[index].toString(),
                                style: AppTextStyles.normalStyle(),
                              )),
                            )),
                      );
                    });
                  }),
            ),
            Expanded(
              child: Obx(() {
                if (controller.rxStatusCodeCategory.value == Status.LOADING) {
                  return const ReusableSpinner(
                    linearWaveLoading: false,
                    circleWaveLoading: false,
                    circleLinesLoading: false,
                    glassFillLoading: true,
                  );
                } else if (controller.rxStatusCodeCategory.value ==
                    Status.ERROR) {
                  return InternetErrorWidget(
                    msg: controller.errorMsgCategory.value.toString(),
                    callback: () {
                      controller.getCategories(controller
                          .categoriesList[controller.selectedCategory.value]);
                    },
                  );
                } else {
                  return ListView.builder(
                      itemCount:
                          controller.categoryModal.value.articles!.length >= 200
                              ? 200
                              : controller.categoryModal.value.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(controller
                            .categoryModal.value.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          enableFeedback: false,
                          onTap: () {
                            Utils.showBottomSheet(
                              context,
                              controller.categoryModal.value.articles![index]
                                  .source!.name
                                  .toString(),
                              controller
                                  .categoryModal.value.articles![index].title
                                  .toString(),
                              controller.categoryModal.value.articles![index]
                                  .description
                                  .toString(),
                              controller.categoryModal.value.articles![index]
                                  .urlToImage
                                  .toString(),
                              controller
                                  .categoryModal.value.articles![index].content
                                  .toString(),
                              format.format(dateTime).toString(),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  width: width * .4,
                                  height: height * .3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.categoryModal.value
                                          .articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          SpinKitWave(
                                              color:
                                                  AppColors.selectedCategory),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              size: 30, color: AppColors.error),
                                    ),
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: width * .5,
                                height: height * .3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.categoryModal.value
                                          .articles![index].title
                                          .toString(),
                                      style: AppTextStyles.readableStyle(
                                          fontSize: 16, color: AppColors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          format.format(dateTime),
                                          style: AppTextStyles.montserratStyle(
                                              color:
                                                  AppColors.spinnerTrackColor,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                }
              }),
            ),
          ],
        )));
  }
}
