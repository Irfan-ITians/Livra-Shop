import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/brands/widgets/brands_view_shimmer_widget.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart' as st;

class BrandsViewWidget extends StatefulWidget {
  const BrandsViewWidget(
      {super.key, this.bystore = false, this.storeId = 0, this.store = null});
  final bool bystore;
  final int storeId;
  final st.Store? store;

  @override
  State<BrandsViewWidget> createState() => _BrandsViewWidgetState();
}

class _BrandsViewWidgetState extends State<BrandsViewWidget> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    print('store id abc:${widget.storeId} check');
    var list;

    return GetBuilder<BrandsController>(builder: (brandsController) {
      if (!widget.bystore) {
        list = brandsController.brandList;
        print('brandsController.brandList:${list}');
        isloading = true;
      } else {
        list = brandsController.brandListbystore;
        print(
            'brandsController.brandListbystore:${brandsController.brandList}');
        isloading = true;
      }
      return isloading
          ? list != null
              ? list!.isNotEmpty
                  ? Column(children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: Dimensions.paddingSizeDefault),
                      //   child: TitleWidget(
                      //     title: 'brands'.tr,
                      //     onTap: () => Get.toNamed(RouteHelper.getBrandsScreen()),
                      //   ),
                      // ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 13,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: list!.length > 8 ? 8 : list!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .disabledColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDefault),
                            ),
                            child: InkWell(
                              onTap: () =>
                                  // Get.find<BrandsController>().getBrandListbystore(store!.id!);

                                  Get.toNamed(RouteHelper.getBrandsItemScreen(
                                //   widget.store,
                                list![index].id!,
                                list![index].name!,
                                storeId: widget.storeId,
                                //  brandImage: '${Get.find<SplashController>().configModel!.baseUrls!.brandImageUrl}/${list![index].image}',
                              )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault),
                                child: CustomImage(
                                  image:
                                      '${brandsController.brandList![index].imageFullUrl}',
                                  //'${Get.find<SplashController>().configModel!.baseUrls!.brandImageUrl}/${list![index].image}',
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ])
                  : const SizedBox()
              : const BrandViewShimmer()
          : Center(child: CircularProgressIndicator());
    });
  }
}/*

class BrandsViewWidget extends StatelessWidget {
  const BrandsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandsController>(builder: (brandsController) {
      return brandsController.brandList != null
          ? brandsController.brandList!.isNotEmpty
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: TitleWidget(
                      title: 'brands'.tr,
                      onTap: () => Get.toNamed(RouteHelper.getBrandsScreen()),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 13,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: brandsController.brandList!.length > 8
                        ? 8
                        : brandsController.brandList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).disabledColor.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                        child: InkWell(
                          onTap: () => Get.toNamed(
                              RouteHelper.getBrandsItemScreen(
                                  brandsController.brandList![index].id!,
                                  brandsController.brandList![index].name!)),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusDefault),
                            child: CustomImage(
                              image:
                                  '${brandsController.brandList![index].imageFullUrl}',
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ])
              : const SizedBox()
          : const BrandViewShimmer();
    });
  }
}
*/