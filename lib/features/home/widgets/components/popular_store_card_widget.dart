import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';

class PopularStoreCard extends StatelessWidget {
  final Store store;
  const PopularStoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    print('Store id:${store.id}');
    print('Store id:${store.name}');
    return Container(
      width: ResponsiveHelper.isDesktop(context) ? 315 : 260,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0))
        ],
      ),
      child: CustomInkWell(
        onTap: () {
          Get.toNamed(
            RouteHelper.getStoreRoute(id: store.id, page: 'store'),
            arguments: StoreScreen(store: store, fromModule: false),
          );
        },
        radius: Dimensions.radiusDefault,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          child: Stack(
            children: [
              // CustomImage(
              //   image: '${store.coverPhotoFullUrl}',
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: 170,
              // ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 89,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                  child: CustomInkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteHelper.getStoreRoute(id: store.id, page: 'store'),
                        arguments: StoreScreen(store: store, fromModule: false),
                      );
                    },
                    radius: Dimensions.radiusDefault,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            //  decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.circular(100),
                            //   border: Border.all(
                            //       color: Theme.of(context)
                            //           .primaryColor
                            //           .withOpacity(0.3),
                            //       width: 1),
                            // ),
                            //  child: ClipRRect(
                            //  borderRadius: BorderRadius.circular(100),
                            // child: CustomImage(
                            //   image: '${store.coverPhotoFullUrl}',
                            //    height: 40,
                            //   width: 40,
                            // ),
                            //  ),
                            ),
                        // const SizedBox(width: Dimensions.paddingSizeDefault),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomImage(
                                image: '${store.logoFullUrl}',
                                height: 50,
                                width: 50,
                              ),
                              Text(store.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoMedium),
                              /*   Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color:
                                              Theme.of(context).primaryColor,
                                          size: 15),
                                      const SizedBox(
                                          width: Dimensions
                                              .paddingSizeExtraSmall),
                                      Text(
                                          store.avgRating!.toStringAsFixed(1),
                                          style: robotoRegular),
                                      const SizedBox(
                                          width: Dimensions
                                              .paddingSizeExtraSmall),
                                      Text('(${store.ratingCount})',
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context)
                                                  .disabledColor)),
                                    ],
                                  ),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeDefault),
                                  Text('${store.itemCount}' ' ' 'items'.tr,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context)
                                              .primaryColor)),
                                ],
                              ),
                         */
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';

class PopularStoreCard extends StatelessWidget {
  final Store store;
  const PopularStoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.isDesktop(context) ? 315 : 260,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        //color: Colors.amber,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        boxShadow: [
          BoxShadow(
              //color: Colors.green,
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0))
        ],
      ),
      child: CustomInkWell(
        onTap: () {
          print('isWorking');
          print('brand/test2');
          Get.find<BrandsController>().getBrandListbystore(store.id!);
          print('brand/test1');
          Get.toNamed(
            RouteHelper.getStoreRoute(id: store.id, page: 'store'),
            arguments: StoreScreen(store: store, fromModule: false),
          );
        },
        radius: Dimensions.radiusDefault,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          child: Stack(
            children: [
              CustomImage(
                image:
                    '${Get.find<SplashController>().configModel!.baseUrls!.storeCoverPhotoUrl}'
                    '/${store.coverPhoto}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 89,
                // decoration: BoxDecoration(
                //   //color: Colors.blue,
                //   color: Theme.of(context).cardColor,
                //   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                // ),
                child: CustomInkWell(
                  onTap: () {
                    print('brand/test3');
                    print('isWorking3');
                    Get.find<BrandsController>().getBrandListbystore(store.id!);
                    Get.toNamed(
                      RouteHelper.getStoreRoute(id: store.id, page: 'store'),
                      arguments: StoreScreen(store: store, fromModule: false),
                    );
                  },
                  // radius: Dimensions.radiusDefault,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      Container(
                        margin: EdgeInsets.only(top: 7),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(100),
                        // border: Border.all(
                        //     color: Theme.of(context)
                        //         .primaryColor
                        //         .withOpacity(0.3),
                        //     width: 1),
                        // ),
                        child: CustomImage(
                          image:
                              '${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}'
                              '/${store.logoFullUrl}',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      // const SizedBox(width: Dimensions.paddingSizeDefault),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Text(store.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: robotoMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/