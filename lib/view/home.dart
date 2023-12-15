import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Data/Response/status.dart';
import 'package:news_app/Res/Components/exeption_widget.dart';
import 'package:news_app/Res/Components/loading_spinner.dart';
import 'package:news_app/Res/Routes/routes_names.dart';
import 'package:news_app/Res/assets/app_assets.dart';
import 'package:news_app/Res/colors/app_colors.dart';
import 'package:news_app/Res/text%20styles/app_text_styles.dart';
import 'package:news_app/Utils/utils/app_utilities.dart';
import 'package:news_app/ViewModel/Home%20Services/home_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeViewModel());
  final format = DateFormat('MMMM, dd, yyyy');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNews(controller.channelsListEndPoint[0]);
    controller.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.themeColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          enableFeedback: false,
            onPressed: () {
              Get.toNamed(RouteNames.categoriesScreen);
            },
            icon: Image.asset(
              AppAssets.menuIcon,
              height: 25,
              color: AppColors.white,
            )),
        title: Text(
          'News App',
          style: AppTextStyles.headerTextStyle(
            color: AppColors.white,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
              enableFeedback: false,
              onSelected: (val) {
                controller.getNews(val);
              },
              itemBuilder: (context) => controller.channelsList
                  .map((item) => PopupMenuItem<String>(
                        value: controller.channelsListEndPoint[
                            controller.channelsList.indexOf(item)],
                        child: Text(item),
                      ))
                  .toList()),
        ],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .55,
                child: Obx(() {
                  if (controller.rxStatusCode.value == Status.LOADING) {
                    return const ReusableSpinner(
                      linearWaveLoading: false,
                      circleWaveLoading: false,
                      circleLinesLoading: true,
                      glassFillLoading: false,
                    );
                  } else if (controller.rxStatusCode.value == Status.ERROR) {
                    return InternetErrorWidget(
                      msg: controller.errorMsg.value.toString(),
                      callback: () {
                        controller.getNews(controller.channelsListEndPoint[0]);
                      },
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.newsModal.value.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(controller
                              .newsModal.value.articles![index].publishedAt
                              .toString());
                          return Stack(
                            children: [
                              InkWell(
                                enableFeedback: false,
                                onTap: () {
                                  Utils.showBottomSheet(
                                    context,
                                    controller.newsModal.value.articles![index]
                                        .source!.name
                                        .toString(),
                                    controller
                                        .newsModal.value.articles![index].title
                                        .toString(),
                                    controller.newsModal.value.articles![index]
                                        .description
                                        .toString(),
                                    controller.newsModal.value.articles![index]
                                        .urlToImage
                                        .toString(),
                                    controller.newsModal.value.articles![index]
                                        .content
                                        .toString(),
                                    format.format(dateTime).toString(),
                                  );
                                },
                                child: Container(
                                    width: width,
                                    height: height * .55,
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.newsModal.value
                                            .articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SpinKitWave(
                                                color:
                                                    AppColors.spinnerWaveColor),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline,
                                                size: 25,
                                                color: AppColors.error),
                                      ),
                                    )),
                              ),
                              Positioned(
                                  bottom: 20,
                                  right: 20,
                                  left: 20,
                                  child: Card(
                                    child: Container(
                                        width: width * .9,
                                        height: height * .18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.newsModal.value
                                                    .articles![index].title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                style: AppTextStyles
                                                    .montserratStyle(
                                                        color: AppColors.black,
                                                        fontSize: 16),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                        .newsModal
                                                        .value
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: AppTextStyles
                                                        .montserratStyle(
                                                            color: AppColors
                                                                .spinnerTrackColor,
                                                            fontSize: 12),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    style: AppTextStyles
                                                        .montserratStyle(
                                                            color: AppColors
                                                                .spinnerTrackColor,
                                                            fontSize: 12),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  )),
                            ],
                          );
                        });
                  }
                }),
              ),
              Obx(() {
                if (controller.rxStatusCodeCategory.value == Status.LOADING) {
                  return const ReusableSpinner(
                    linearWaveLoading: true,
                    circleWaveLoading: false,
                    circleLinesLoading: false,
                    glassFillLoading: false,
                  );
                } else if (controller.rxStatusCodeCategory.value ==
                    Status.ERROR) {
                  return InternetErrorWidget(
                    msg: controller.errorMsg.value.toString(),
                    callback: () {
                      controller.getCategories();
                    },
                  );
                } else {
                  return ListView.builder(
                      itemCount:
                          controller.categoryModal.value.articles!.length >= 200
                              ? 200
                              : controller.categoryModal.value.articles!.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        DateTime dateTime = DateTime.parse(controller
                            .categoryModal.value.articles![index].publishedAt
                            .toString());
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: InkWell(
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
                                  controller.categoryModal.value.articles![index]
                                      .content
                                      .toString(),
                                  format.format(dateTime).toString(),
                                );
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.categoryModal.value
                                          .articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Center(
                                          child: SpinKitWave(
                                              color:
                                                  AppColors.selectedCategory)),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              size: 30, color: AppColors.error),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: height * .18,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.categoryModal.value
                                              .articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          style: AppTextStyles.readableStyle(
                                              fontSize: 16,
                                              color: AppColors.black),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .categoryModal
                                                    .value
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                style: AppTextStyles
                                                    .montserratStyle(
                                                        color: AppColors
                                                            .spinnerTrackColor,
                                                        fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              format.format(dateTime),
                                              style:
                                                  AppTextStyles.montserratStyle(
                                                      color: AppColors
                                                          .spinnerTrackColor,
                                                      fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ));
                      });
                }
              }),
            ],
          )),
    );
  }
}
