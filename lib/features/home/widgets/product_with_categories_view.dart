import 'package:shimmer/shimmer.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BasicCampaignView extends StatelessWidget {
  final CampaignController campaignController;
  const BasicCampaignView({super.key, required this.campaignController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
          child: TitleWidget(title: 'basic_campaigns'.tr),
        ),
        SizedBox(
          height: 80,
          child: campaignController.basicCampaignList != null ? ListView.builder(
            itemCount: campaignController.basicCampaignList!.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getBasicCampaignRoute(
                    campaignController.basicCampaignList![index],
                  )),
                  child: Container(
                    margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      color: Theme.of(context).cardColor,
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      child: CustomImage(
                        image: '${campaignController.basicCampaignList![index].imageFullUrl}',
                        width: 200, height: 80, fit: BoxFit.cover,
                      ),
                    ),
                  )
              );
            },
          ) : CampaignShimmer(campaignController: campaignController),
        ),
      ],
    );
  }
}

class CampaignShimmer extends StatelessWidget {
  final CampaignController campaignController;
  const CampaignShimmer({super.key, required this.campaignController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
      itemBuilder: (context, index) {
        return Shimmer(
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
          enabled: campaignController.basicCampaignList == null,
          child: Container(
            width: 200, height: 80,
            margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
          ),
        );
      },
    );
  }
}

