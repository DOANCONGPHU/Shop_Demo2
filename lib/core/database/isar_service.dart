import 'package:isar_community/isar.dart';
import 'package:my_app/features/Cart/models/purchased_item.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late final Isar _db;

  Isar get db => _db;

  IsarService();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    _db = await Isar.open(
      [PurchasedItemSchema],
      directory: dir.path,
      name: 'my_app_isar',
    );
  }

  Future<void> close() async {
    await _db.close();
  }
}