import 'package:get/get.dart';
import 'package:sixam_mart/features/brands/domain/models/brands_model.dart';
import 'package:sixam_mart/features/brands/domain/services/brands_service_interface.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
/*
class BrandsController extends GetxController implements GetxService {
  final BrandsServiceInterface brandsServiceInterface;
  BrandsController({required this.brandsServiceInterface});

  List<BrandModel>? _brandList;
  List<BrandModel>? get brandList => _brandList;

  List<Item>? _brandItems;
  List<Item>? get brandItems => _brandItems;

  int _offset = 1;
  int get offset => _offset;

  int? _pageSize;
  int? get pageSize => _pageSize;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getBrandList() async {
    List<BrandModel>? brandList = await brandsServiceInterface.getBrandList();
    if (brandList != null) {
      _brandList = [];
      _brandList!.addAll(brandList);
    }
    update();
  }

  Future<void> getBrandItemList(int brandId, int offset, bool notify) async {
    _offset = offset;
    if(offset == 1) {
      _brandItems = null;
      if(notify) {
        update();
      }
    }
    ItemModel? brandItemModel = await brandsServiceInterface.getBrandItemList(brandId: brandId, offset: offset);
    if (brandItemModel != null) {
      if (offset == 1) {
        _brandItems = [];
      }
      _brandItems!.addAll(brandItemModel.items!);
      _pageSize = brandItemModel.totalSize;
      _isLoading = false;
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}*/
import 'package:get/get.dart';
import 'package:sixam_mart/features/brands/domain/models/brands_model.dart';
import 'package:sixam_mart/features/brands/domain/services/brands_service_interface.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';

class BrandsController extends GetxController implements GetxService {
  final BrandsServiceInterface brandsServiceInterface;
  BrandsController({required this.brandsServiceInterface});

  List<BrandModel>? _brandList;
  List<BrandModel>? get brandList => _brandList;

  List<BrandModel>? _brandListbystore;
  List<BrandModel>? get brandListbystore => _brandListbystore;

  ItemModel? _brandItemModel;
  ItemModel? get brandItemModel => _brandItemModel;

  Future<void> getBrandList() async {
    List<BrandModel>? brandList = await brandsServiceInterface.getBrandList();
    if (brandList != null) {
      _brandList = [];
      _brandList!.addAll(brandList);
    }
    update();
  }

  Future<void> getBrandListbystore(int storeid) async {
    print('brand/test');
    List<BrandModel>? brandListbystore =
        await brandsServiceInterface.getBrandList(offset: storeid);
    if (brandListbystore != null) {
      _brandListbystore = [];
      _brandListbystore!.addAll(brandListbystore);
    }
    update();
  }

  Future<void> getBrandItemList(int brandId, int offset, bool notify) async {
    if (offset == 1 || _brandItemModel == null) {
      _brandItemModel = null;
      if (notify) {
        update();
      }
    }
    ItemModel? brandItemModel = await brandsServiceInterface.getBrandItemList(
        brandId: brandId, offset: offset);
    if (brandItemModel != null) {
      if (offset == 1) {
        _brandItemModel = brandItemModel;
      } else {
        _brandItemModel!.items!.addAll(brandItemModel.items!);
        _brandItemModel!.totalSize = brandItemModel.totalSize;
        _brandItemModel!.offset = brandItemModel.offset;
      }
    }
    update();
  }
}
