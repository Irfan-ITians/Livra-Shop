/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';

class BrandsItemScreen extends StatefulWidget {
  final int brandId;
  final String brandName;
  const BrandsItemScreen({super.key, required this.brandId, required this.brandName});

  @override
  State<BrandsItemScreen> createState() => _BrandsItemScreenState();
}

class _BrandsItemScreenState extends State<BrandsItemScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Get.find<BrandsController>().getBrandItemList(widget.brandId, 1, false);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<BrandsController>().brandItems != null
          && !Get.find<BrandsController>().isLoading) {
        int pageSize = (Get.find<BrandsController>().pageSize! / 10).ceil();
        if (Get.find<BrandsController>().offset < pageSize) {
          if (kDebugMode) {
            print('end of the page');
          }
          Get.find<BrandsController>().showBottomLoader();
          Get.find<BrandsController>().getBrandItemList(widget.brandId, Get.find<BrandsController>().offset+1, true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: CustomAppBar(title: widget.brandName),
      endDrawer: const MenuDrawer(), endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<BrandsController>(builder: (brandsController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: FooterView(
            child: Column(children: [

              WebScreenTitleWidget(title: widget.brandName),

              SizedBox(
                width: Dimensions.webMaxWidth,
                child: brandsController.brandItems != null ? brandsController.brandItems!.isNotEmpty
                    ? ItemsView(isStore: false, items: brandsController.brandItems, stores: null, noDataText: 'no_brand_item_found'.tr)
                    : Center(child: Padding(padding: EdgeInsets.only(top: isDesktop ? context.height * 0.3 : context.height * 0.4), child: Text('no_brand_item_found'.tr)))
                    : const BrandItemScreenShimmer(),

              ),

              brandsController.isLoading ? Center(child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
              )) : const SizedBox(),
            ]),
          ),
        );
      }),
    );
  }
}

class BrandItemScreenShimmer extends StatelessWidget {
  const BrandItemScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      itemCount: 12,
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
            height: 100,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey[300],
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [BoxShadow(color: Get.isDarkMode ? Colors.black12 : Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 1))],
            ),
            child: Row(children: [

              Container(
                height: 80, width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(height: 20, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(height: 15, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(height: 15, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                ]),
              ),

            ]),
          ),
        );
      },
    ) : ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            height: 100,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.white.withOpacity(0.05) : Colors.grey[300],
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              boxShadow: [BoxShadow(color: Get.isDarkMode ? Colors.black12 : Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 1))],
            ),
            child: Row(children: [

              Container(
                height: 80, width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(height: 20, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(height: 15, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Container(height: 15, width: double.maxFinite, color: Get.isDarkMode ? Theme.of(context).disabledColor.withOpacity(0.2) : Theme.of(context).cardColor),
                ]),
              ),

            ]),
          ),
        );
      },
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:sixam_mart/features/store/screens/testScreen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';

import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../common/widgets/custom_snackbar.dart';
import '../../../util/app_constants.dart';
import '../../language/controllers/language_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../store/controllers/store_controller.dart';
import '../../store/widgets/customizable_space_bar_widget.dart';

class BrandsItemScreen extends StatefulWidget {
  final int brandId;
  final String brandName;
  final int storeId;

  const BrandsItemScreen({
    super.key,
    required this.brandId,
    required this.brandName,
    required this.storeId,
  });

  @override
  State<BrandsItemScreen> createState() => _BrandsItemScreenState();
}

class _BrandsItemScreenState extends State<BrandsItemScreen> {
  @override
  void initState() {
    Get.find<BrandsController>().getBrandItemList(widget.brandId, 1, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    print('forever: ${teststore!.address}');
    print('forever2: ${teststore!.id}');

    return Scaffold(
        body: GetBuilder<BrandsController>(builder: (brandsController) {
      return GetBuilder<BrandsController>(
        builder: (brandsController) {
          return SingleChildScrollView(
              child: FooterView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Container(
                    //   height: 70,
                    //   width: double.infinity,
                    //   color: Colors.red,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Center(
                        child: SizedBox(
                          //  width: 330,

                          height: 345,
                          child: CustomImage(
                            fit: BoxFit.cover,
                            image:
                                '${Get.find<SplashController>().configModel!.baseUrls!.storeCoverPhotoUrl}/${teststore!.coverPhoto}',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 13,
                      child: IconButton(
                        icon: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          alignment: Alignment.center,
                          child: Icon(Icons.chevron_left,
                              color: Theme.of(context).cardColor),
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Positioned(
                      top: 245,
                      child: Column(
                        children: [
                          /*   teststore!.discount != null
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(1),
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.radiusLarge)),
                                  ),
                                  padding: EdgeInsets.all(Dimensions
                                          .paddingSizeExtraSmall -
                                      (GetPlatform.isAndroid
                                          ? (Dimensions.paddingSizeExtraSmall)
                                          : 0)),
                                  child: Text(
                                    '${teststore!.discount!.discountType == 'percent' ? '${teststore!.discount!.discount}% ${'off'.tr}' : '${PriceConverter.convertPrice(teststore!.discount!.discount)} ${'off'.tr}'} '
                                    '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(teststore!.discount!.minPurchase)},'
                                    ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(teststore!.discount!.startTime!)} '
                                    '- ${DateConverter.convertTimeToTime(teststore!.discount!.endTime!)}',
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.black,
                                      // .withOpacity(
                                      //     1 - scrollingRate),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : const SizedBox(),*/
                          Container(
                            width: 600,
                            color: Theme.of(context).cardColor,
                            //.withOpacity(scrollingRate),
                            // padding: EdgeInsets.only(
                            //   bottom: 0,
                            //   left: Get.find<LocalizationController>().isLtr
                            //       ? 20
                            //       : 0,
                            //   right: Get.find<LocalizationController>().isLtr
                            //       ? 0
                            //       : 20,
                            // ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: 100,
                                color: Theme.of(context).cardColor,
                                // .withOpacity(
                                //     scrollingRate == 0.0
                                //         ? 1
                                //         : 0),
                                padding: EdgeInsets.only(
                                  left: Get.find<LocalizationController>().isLtr
                                      ? 35
                                      : 0,
                                  right:
                                      Get.find<LocalizationController>().isLtr
                                          ? 0
                                          : 35,
                                ),
                                child: Row(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSmall),
                                    child: Stack(children: [
                                      CustomImage(
                                        image: '${teststore!.logoFullUrl}',
                                        // '${Get.find<SplashController>().configModel!.baseUrls!.storeImageUrl}/${teststore!.logoFullUrl}',
                                        height: 60,
                                        // (scrollingRate * 15),
                                        width: 70,
                                        // (scrollingRate * 15),
                                        fit: BoxFit.cover,
                                      ),
                                      // storeController
                                      //         .isStoreOpenNow(
                                      //             teststore!.active!,
                                      //             teststore!.schedules)
                                      //     ? const SizedBox()
                                      //     :
                                      Positioned(
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
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          Text(
                                            teststore!.name!,
                                            style: robotoMedium.copyWith(
                                                // fontSize: Dimensions
                                                //         .fontSizeLarge -
                                                //     (scrollingRate *
                                                //         3),
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .color),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall),
                                        ]),
                                        const SizedBox(
                                            height: Dimensions
                                                .paddingSizeExtraSmall),
                                        Text(
                                          teststore!.address ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: robotoRegular.copyWith(
                                              // fontSize: Dimensions
                                              //         .fontSizeSmall -
                                              //     (scrollingRate *
                                              //         2),
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        SizedBox(
                                            height: ResponsiveHelper.isDesktop(
                                                    context)
                                                ? Dimensions
                                                    .paddingSizeExtraSmall
                                                : 0),
                                        Row(children: [
                                          Text('minimum_order'.tr,
                                              style: robotoRegular),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall),
                                          Text(
                                            PriceConverter.convertPrice(
                                                teststore!.minimumOrder),
                                            textDirection: TextDirection.ltr,
                                            style: robotoMedium.copyWith(
                                                // fontSize: Dimensions
                                                //         .fontSizeExtraSmall -
                                                //     (scrollingRate *
                                                //         2),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ]),
                                      ]),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeSmall),
                                  InkWell(
                                    onTap: () {
                                      String shareUrl =
                                          '${AppConstants.webHostedUrl}${Get.find<StoreController>().filteringUrl(teststore!.slug ?? '')}';
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
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(
                                  //       Dimensions.radiusDefault),
                                  //   child: CustomImage(
                                  //     image:
                                  //         '${Get.find<SplashController>().configModel!.baseUrls!.brandImageUrl}/${list![0].image}',
                                  //     height: 60,
                                  //     width: 60,
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //     width: Dimensions.paddingSizeSmall),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                WebScreenTitleWidget(title: widget.brandName),
                //   GridView.builder(
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                // padding:
                //     const EdgeInsets.all(Dimensions.paddingSizeDefault),
                // gridDelegate:
                //     const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 3,
                //   crossAxisSpacing: 13,
                //   mainAxisSpacing: 13,
                //   childAspectRatio: 1.0,
                // ),
                // Container(
                //   color: Colors.amber,
                //   width: 400,
                //   //  height: 150,
                //   // width: Dimensions.webMaxWidth,
                //   child: brandsController.brandItemModel != null
                //       ? brandsController.brandItemModel!.items!.isNotEmpty
                //           ? GridView.builder(
                //               gridDelegate:
                //                   SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 2,
                //                 // crossAxisSpacing: 8.0,
                //                 // mainAxisSpacing: 8.0,
                //               ),
                //               itemCount: widget.storeId == 0
                //                   ? brandsController
                //                       .brandItemModel!.items!.length
                //                   : brandsController.brandItemModel!.items!
                //                       .where((element) =>
                //                           element.storeId == widget.storeId)
                //                       .toList()
                //                       .length,
                //               itemBuilder: (BuildContext context, int index) {
                //                 final item = widget.storeId == 0
                //                     ? brandsController
                //                         .brandItemModel!.items![index]
                //                     : brandsController.brandItemModel!.items!
                //                         .where((element) =>
                //                             element.storeId == widget.storeId)
                //                         .toList()[index];

                //                 // Return the ItemsView widget for the item
                //                 return ItemsView(
                //                   isStore: false,
                //                   items: [
                //                     item
                //                   ], // Pass a list with a single item
                //                   stores: null,
                //                   noDataText: 'no_brand_item_found'.tr,
                //                   selected_storeId: widget.storeId,
                //                 );
                //               },
                //             )
                //           : Center(
                //               child: Padding(
                //                 padding: EdgeInsets.only(
                //                   top: isDesktop
                //                       ? context.height * 0.3
                //                       : context.height * 0.4,
                //                 ),
                //                 child: Text('no_brand_item_found'.tr),
                //               ),
                //             )
                //       : const BrandItemScreenShimmer(),
                // )

                SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: brandsController.brandItemModel != null
                      ? brandsController.brandItemModel!.items!.isNotEmpty
                          ? ItemsView(
                              isStore: false,
                              items: widget.storeId == 0
                                  ? brandsController.brandItemModel!.items!
                                  : brandsController.brandItemModel!.items!
                                      .where((element) =>
                                          element.storeId == widget.storeId)
                                      .toList(),
                              stores: null,
                              noDataText: 'no_brand_item_found'.tr,
                              selected_storeId: widget.storeId,
                            )
                          : Center(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: isDesktop
                                          ? context.height * 0.3
                                          : context.height * 0.4),
                                  child: Text('no_brand_item_found'.tr)))
                      : const BrandItemScreenShimmer(),
                ),
              ],
            ),
          ));
        },
      );
    })
        //),

        //  ),

        // teststore != null
        //     ?
        // TestScreen(
        //   store: teststore,
        // ),
        //: Container(),

        //     ]),
        //   ),
        // );
        // }),
        );
  }
}

class BrandItemScreenShimmer extends StatelessWidget {
  const BrandItemScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 150,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Shimmer(
                period: const Duration(seconds: 2),
                enabled: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.grey
                        .withOpacity(0.1), // First color with 10% opacity
                    Colors.grey
                        .withOpacity(0.2), // Second color with 20% opacity
                    Colors.grey
                        .withOpacity(0.1), // Third color with 10% opacity
                  ],
                  stops: [0.1, 0.5, 0.9], // Positions of the gradient colors
                  begin: Alignment(-1.0, -0.3),
                  end: Alignment(1.0, 0.3),
                ),
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    boxShadow: [
                      BoxShadow(
                          color: Get.isDarkMode
                              ? Colors.black12
                              : Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1))
                    ],
                  ),
                  child: Row(children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault),
                        color: Get.isDarkMode
                            ? Theme.of(context).disabledColor.withOpacity(0.2)
                            : Theme.of(context).cardColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 20,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                height: 15,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                height: 15,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                          ]),
                    ),
                  ]),
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer(
                period: const Duration(seconds: 2),
                enabled: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.grey
                        .withOpacity(0.1), // First color with 10% opacity
                    Colors.grey
                        .withOpacity(0.2), // Second color with 20% opacity
                    Colors.grey
                        .withOpacity(0.1), // Third color with 10% opacity
                  ],
                  stops: [0.1, 0.5, 0.9], // Positions of the gradient colors
                  begin: Alignment(-1.0, -0.3),
                  end: Alignment(1.0, 0.3),
                ),
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    boxShadow: [
                      BoxShadow(
                          color: Get.isDarkMode
                              ? Colors.black12
                              : Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 1))
                    ],
                  ),
                  child: Row(children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault),
                        color: Get.isDarkMode
                            ? Theme.of(context).disabledColor.withOpacity(0.2)
                            : Theme.of(context).cardColor,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 20,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                height: 15,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Container(
                                height: 15,
                                width: double.maxFinite,
                                color: Get.isDarkMode
                                    ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.2)
                                    : Theme.of(context).cardColor),
                          ]),
                    ),
                  ]),
                ),
              );
            },
          );
  }
}
