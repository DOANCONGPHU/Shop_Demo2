
import 'package:isar_community/isar.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  Isar? _isar;                    

  Future<Isar> get db async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [PurchasedProductSchema],    
      directory: dir.path,
      name: 'my_app_isar',
    );

    return _isar!;
  }

  Future<void> init() async {
    await db;   
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}