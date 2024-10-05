import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:sixam_mart/common/widgets/card_design/item_card.dart';

class SpecialOfferView extends StatelessWidget {
  final bool isFood;
  final bool isShop;
  const SpecialOfferView({super.key, required this.isFood, required this.isShop});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(builder: (itemController) {
      List<Item>? discountedItemList = itemController.discountedItemList;

      return discountedItemList != null ? discountedItemList.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Container(
          color: Theme.of(context).disabledColor.withOpacity(0.1),
          child: Column(children: [

            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
              child: TitleWidget(
                title: 'special_offer'.tr,
                image: Images.discountOfferIcon,
                onTap: () => Get.toNamed(RouteHelper.getPopularItemRoute(false, true)),
              ),
            ),

            SizedBox(
              height: 285, width: Get.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                itemCount: discountedItemList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                    child: ItemCard(item: discountedItemList[index], isPopularItem: false, isFood: isFood, isShop: isShop, index: index),
                  );
                  },
              ),
            ),
          ]),
        ),
      ) : const SizedBox() : const ItemShimmerView(isPopularItem: false);
    });
  }
}

class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  const ItemShimmerView({super.key, required this.isPopularItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Container(
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
            child: TitleWidget(
              title: isPopularItem ? 'most_popular_items'.tr : 'special_offer'.tr,
              image: isPopularItem ? Images.mostPopularIcon : Images.discountOfferIcon,
            ),
          ),

          SizedBox(
            height: 285, width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                  child: Shimmer(
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
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      height: 285, width: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(children: [

                        Container(
                          height: 150, width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Column(children: [

                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                              height: 15, width: 100,
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                              height: 20, width: 200,
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Container(
                              height: 15, width: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).shadowColor,
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              ),
                            ),
                          ]),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
