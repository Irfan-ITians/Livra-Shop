import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';

class MiddleSectionMultipleBannerViewWidget extends StatelessWidget {
  const MiddleSectionMultipleBannerViewWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(builder: (campaignController) {

      return campaignController.basicCampaignList != null ? campaignController.basicCampaignList!.isNotEmpty ? Container(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtremeLarge, bottom: Dimensions.paddingSizeDefault),
        child: GridView.builder(
          itemCount: campaignController.basicCampaignList!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: Dimensions.paddingSizeExtremeLarge,
            mainAxisSpacing: Dimensions.paddingSizeExtremeLarge,
            mainAxisExtent: 130,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              hoverColor: Colors.transparent,
              onTap: () => Get.toNamed(RouteHelper.getBasicCampaignRoute(
                campaignController.basicCampaignList![index],
              )),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                  color: Theme.of(context).cardColor,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                  child: CustomImage(
                    image: '${campaignController.basicCampaignList![index].imageFullUrl}',
                    fit: BoxFit.cover, height: 230, width: double.infinity,
                  ),
                ),
              ),
            );
          },
        ),
      ) : const SizedBox() : const MiddleSectionMultipleBannerShimmer();
    });
  }
}

class MiddleSectionMultipleBannerShimmer extends StatelessWidget {
  const MiddleSectionMultipleBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Dimensions.paddingSizeExtremeLarge,
        mainAxisSpacing: Dimensions.paddingSizeExtremeLarge,
        mainAxisExtent: 230,
      ),
      itemBuilder: (context, index) {
        return Shimmer(
            period: const Duration(seconds: 2),
          enabled: true,
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
          child: Container(
            height: 230, width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
              color: Colors.grey[300],
            ),
          ),
        );
      },
    );
  }
}
