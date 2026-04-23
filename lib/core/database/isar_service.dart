
import 'package:isar_community/isar.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  Isar? _isar;                    // Dùng nullable thay vì late

  // Getter an toàn
  Future<Isar> get db async {
    if (_isar != null) return _isar!;

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [PurchasedProductSchema],     // Thêm các schema khác nếu có
      directory: dir.path,
      name: 'my_app_isar',
    );

    return _isar!;
  }

  // Hàm init (gọi một lần khi app start)
  Future<void> init() async {
    await db;   // Gọi db để khởi tạo
  }

  // Đóng database khi cần (thường không cần gọi)
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}