import 'package:isar_community/isar.dart';
part 'purchased_product.g.dart';

@collection
class PurchasedProduct {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String productId;

  PurchasedProduct({required this.productId});
}
