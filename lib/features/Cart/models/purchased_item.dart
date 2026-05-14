import 'package:isar_community/isar.dart';
part 'purchased_item.g.dart';

@collection
class PurchasedItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String productId;

  PurchasedItem({required this.productId});
}
