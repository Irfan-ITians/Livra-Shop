import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/basic_campaign_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher_string.dart';

class WebNewBannerViewWidget extends StatelessWidget {
  final bool isFeatured;
  const WebNewBannerViewWidget({super.key, required this.isFeatured});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BannerController>(builder: (bannerController) {
      List<String?>? bannerList = isFeatured ? bannerController.featuredBannerList : bannerController.bannerImageList;
      List<dynamic>? bannerDataList = isFeatured ? bannerController.featuredBannerDataList : bannerController.bannerDataList;

        return (bannerList != null && bannerList.isEmpty) ? const SizedBox() : Container(
          width: MediaQuery.of(context).size.width,
          height: GetPlatform.isDesktop ? 330 : MediaQuery.of(context).size.width * 0.45,
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
          child: bannerList != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(seconds: 7),
                    onPageChanged: (index, reason) {
                      bannerController.setCurrentIndex(index, true);
                    },
                  ),
                  itemCount: bannerList.isEmpty ? 1 : bannerList.length,
                  itemBuilder: (context, index, _) {

                    return InkWell(
                      onTap: () async {
                        if(bannerDataList![index] is Item) {
                          Item? item = bannerDataList[index];
                          Get.find<ItemController>().navigateToItemPage(item, context);
                        }else if(bannerDataList[index] is Store) {
                          Store? store = bannerDataList[index];
                          if(isFeatured && Get.find<SplashController>().moduleList != null) {
                            for(ModuleModel module in Get.find<SplashController>().moduleList!) {
                              if(module.id == store!.moduleId) {
                                Get.find<SplashController>().setModule(module);
                                break;
                              }
                            }
                          }
                          Get.toNamed(
                            RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'banner'),
                            arguments: StoreScreen(store: store, fromModule: isFeatured),
                          );
                        }else if(bannerDataList[index] is BasicCampaignModel) {
                          BasicCampaignModel campaign = bannerDataList[index];
                          Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
                        }else {
                          String url = bannerDataList[index];
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url, mode: LaunchMode.externalApplication);
                          }else {
                            showCustomSnackBar('unable_to_found_url'.tr);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          child: GetBuilder<SplashController>(builder: (splashController) {
                            return CustomImage(
                              image: '${bannerList[index]}',
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerController.bannerImageList!.map((bnr) {
                  int index = bannerController.bannerImageList!.indexOf(bnr);
                  int totalBanner = bannerController.bannerImageList!.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: index == bannerController.currentIndex ? Container(
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      child: Text('${(index) + 1}/$totalBanner', style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: 12)),
                    ) : Container(
                      height: 5, width: 6,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ) : Shimmer(
              period: const Duration(seconds: 2),
   
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.1), // First color with 10% opacity
              Colors.grey.withOpacity(0.2), // Second color with 20% opacity
              Colors.grey.withOpacity(0.1), // Third color with 10% opacity
            ],
            stops: [0.1, 0.5, 0.9],  // Positions of the gradient colors
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
          ),
            enabled: bannerList == null,
            child: Container(margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              color: Theme.of(context).shadowColor,
            )),
          ),
        );
    });
  }
}