// import 'package:sixam_mart/features/brands/domain/models/brands_model.dart';
// import 'package:sixam_mart/features/item/domain/models/item_model.dart';

// abstract class BrandsServiceInterface {
//   Future<List<BrandModel>?> getBrandList();
//   Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
// }
import 'package:sixam_mart/features/brands/domain/models/brands_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';

abstract class BrandsServiceInterface {
  Future<List<BrandModel>?> getBrandList({int? offset});
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
  Future<ItemModel?> getBrandItemListbystore(
      {required int brandId, required int storeId, int? offset});
}
