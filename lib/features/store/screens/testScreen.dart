import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/app_constants.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../helper/auth_helper.dart';
import '../../../helper/price_converter.dart';
import '../../../helper/responsive_helper.dart';

import '../../language/controllers/language_controller.dart';

class TestScreen extends StatefulWidget {
  final Store? store;

  const TestScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      return GetBuilder<CategoryController>(builder: (categoryController) {
        return SliverAppBar(
          expandedHeight: 300,
          toolbarHeight: 100,
          pinned: true,
          floating: false,
          elevation: 0.5,
          backgroundColor: Theme.of(context).cardColor,
          leading: IconButton(
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              alignment: Alignment.center,
              child:
                  Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
            ),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            expandedTitleScale: 1.1,
            title: CustomizableSpaceBarWidget(
              builder: (context, scrollingRate) {
                return Container(
                  height: widget.store!.discount != null ? 145 : 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.radiusLarge)),
                  ),
                  child: Column(
                    children: [
                      // widget.store!.discount != null
                      //     ? Container(
                      //         width: double.infinity,
                      //         decoration: BoxDecoration(
                      //           color: Theme.of(context)
                      //               .primaryColor
                      //               .withOpacity(1 - scrollingRate),
                      //           borderRadius: const BorderRadius.vertical(
                      //               top: Radius.circular(
                      //                   Dimensions.radiusLarge)),
                      //         ),
                      //         padding: EdgeInsets.all(
                      //             Dimensions.paddingSizeExtraSmall -
                      //                 (GetPlatform.isAndroid
                      //                     ? (scrollingRate *
                      //                         Dimensions.paddingSizeExtraSmall)
                      //                     : 0)),
                      //         child: Text(
                      //           '${widget.store!.discount!.discountType == 'percent' ? '${widget.store!.discount!.discount}% ${'off'.tr}' : '${PriceConverter.convertPrice(widget.store!.discount!.discount)} ${'off'.tr}'} '
                      //           '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(widget.store!.discount!.minPurchase)},'
                      //           ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(widget.store!.discount!.startTime!)} '
                      //           '- ${DateConverter.convertTimeToTime(widget.store!.discount!.endTime!)}',
                      //           style: robotoMedium.copyWith(
                      //             fontSize: Dimensions.fontSizeSmall,
                      //             color: Colors.black
                      //                 .withOpacity(1 - scrollingRate),
                      //           ),
                      //           textAlign: TextAlign.center,
                      //           maxLines: 2,
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //       )
                      //     : const SizedBox(),
                      Container(
                        color: Theme.of(context)
                            .cardColor
                            .withOpacity(scrollingRate),
                        padding: EdgeInsets.only(
                          bottom: 0,
                          left: Get.find<LocalizationController>().isLtr
                              ? 40 * scrollingRate
                              : 0,
                          right: Get.find<LocalizationController>().isLtr
                              ? 0
                              : 40 * scrollingRate,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 100,
                            color: Theme.of(context)
                                .cardColor
                                .withOpacity(scrollingRate == 0.0 ? 1 : 0),
                            padding: EdgeInsets.only(
                              left: Get.find<LocalizationController>().isLtr
                                  ? 20
                                  : 0,
                              right: Get.find<LocalizationController>().isLtr
                                  ? 0
                                  : 20,
                            ),
                            child: Row(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall),
                                child: Stack(children: [
                                  CustomImage(
                                    image: '${widget.store!.logoFullUrl}',
                                    //  '${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}/${widget.store!.logoFullUrl}',
                                    height: 60 - (scrollingRate * 15),
                                    width: 70 - (scrollingRate * 15),
                                    fit: BoxFit.cover,
                                  ),
                                  storeController.isStoreOpenNow(
                                          widget.store!.active!,
                                          widget.store!.schedules)
                                      ? const SizedBox()
                                      : Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom: Radius.circular(
                                                          Dimensions
                                                              .radiusSmall)),
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            child: Text(
                                              'closed_now'.tr,
                                              textAlign: TextAlign.center,
                                              style: robotoRegular.copyWith(
                                                  color: Colors.white,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                            ),
                                          ),
                                        ),
                                ]),
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(
                                      widget.store!.name!,
                                      style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeLarge -
                                              (scrollingRate * 3),
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                        width: Dimensions.paddingSizeSmall),
                                    const SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall),
                                    Text(
                                      widget.store!.address ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall -
                                              (scrollingRate * 2),
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    SizedBox(
                                        height:
                                            ResponsiveHelper.isDesktop(context)
                                                ? Dimensions
                                                    .paddingSizeExtraSmall
                                                : 0),
                                    Row(children: [
                                      Text('minimum_order'.tr,
                                          style: robotoRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraSmall -
                                                    (scrollingRate * 2),
                                            color:
                                                Theme.of(context).disabledColor,
                                          )),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Text(
                                        PriceConverter.convertPrice(
                                            widget.store!.minimumOrder),
                                        textDirection: TextDirection.ltr,
                                        style: robotoMedium.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraSmall -
                                                    (scrollingRate * 2),
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ]),
                                  ])),
                              GetBuilder<FavouriteController>(
                                  builder: (favouriteController) {
                                bool isWished = favouriteController
                                    .wishStoreIdList
                                    .contains(widget.store!.id);
                                return InkWell(
                                  onTap: () {
                                    if (AuthHelper.isLoggedIn()) {
                                      isWished
                                          ? favouriteController
                                              .removeFromFavouriteList(
                                                  widget.store!.id, true)
                                          : favouriteController
                                              .addToFavouriteList(null,
                                                  widget.store as int?, true);
                                    } else {
                                      showCustomSnackBar(
                                          'you_are_not_logged_in'.tr);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusDefault),
                                    ),
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeExtraSmall),
                                    child: Icon(
                                      isWished
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isWished
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).disabledColor,
                                      size: 24 - (scrollingRate * 4),
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              InkWell(
                                onTap: () {
                                  String shareUrl =
                                      '${AppConstants.webHostedUrl}${Get.find<StoreController>().filteringUrl(widget.store!.slug ?? '')}';
                                  Share.share(shareUrl);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusDefault),
                                  ),
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeExtraSmall),
                                  child: Icon(
                                    Icons.share,
                                    size: 24 - (scrollingRate * 4),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            background: CustomImage(
              fit: BoxFit.cover,
              image:
                  '${Get.find<SplashController>().configModel!.baseUrls!.storeCoverPhotoUrl}/${widget.store!.coverPhoto}',
            ),
          ),
          actions: const [
            SizedBox(),
          ],
        );
      });
    });
  }
}
