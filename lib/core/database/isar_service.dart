
import 'package:isar_community/isar.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [PurchasedProductSchema],
      directory: dir.path, 
      name: 'my_app_isar',
    );
  }

  Isar get db => isar;
}