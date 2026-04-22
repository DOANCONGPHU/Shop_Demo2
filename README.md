# 🛍️ My App - Ứng Dụng Thương Mại Điện Tử Flutter

Ứng dụng thương mại điện tử hiện đại được xây dựng bằng Flutter, thể hiện kiến trúc sạch, quản lý trạng thái BLoC và tích hợp REST API. Sử dụng DummyJSON API làm backend.

**Ngôn ngữ / Languages:** Tiếng Việt 🇻🇳 | English 🇬🇧

---

## 📋 Mục Lục

- [Tổng Quan Dự Án](#-tổng-quan-dự-án)
- [Tính Năng](#-tính-năng)
- [Công Nghệ Sử Dụng](#-công-nghệ-sử-dụng)
- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [Kiến Trúc](#-kiến-trúc)
- [Cài Đặt & Thiết Lập](#-cài-đặt--thiết-lập)
- [Chạy Ứng Dụng](#-chạy-ứng-dụng)
- [Các Thư Viện Phụ Thuộc](#-các-thư-viện-phụ-thuộc)
- [Tích Hợp API](#-tích-hợp-api)
- [Chi Tiết Tính Năng](#-chi-tiết-tính-năng)

---

## 🎯 Tổng Quan Dự Án

**My App** là ứng dụng thương mại điện tử đầy đủ tính năng được xây dựng bằng Flutter. Nó thể hiện các thực hành phát triển ứng dụng chuyên nghiệp bao gồm:

- **Kiến Trúc Phân Lớp** với tách biệt trách nhiệm
- **Mẫu BLoC/Cubit** để quản lý trạng thái
- **GoRouter** để điều hướng
- **Tích hợp REST API** với xử lý lỗi
- **Giám sát kết nối mạng** theo thời gian thực
- **Giao diện đáp ứng** với widget tùy chỉnh
- **Trực quan hóa dữ liệu** bằng ECharts

Ứng dụng tích hợp với **DummyJSON API** để lấy các sản phẩm, danh mục và dữ liệu thương mại thực tế.

---

## ✨ Tính Năng

### 🏠 Module Trang Chủ
- Hiển thị sản phẩm với phân trang
- Lọc theo danh mục sản phẩm
- Carousel banner nổi bật
- Xem chi tiết sản phẩm
- Tính năng tìm kiếm
- Lọc theo danh mục

### 🛒 Giỏ Hàng
- Thêm/xóa mục khỏi giỏ hàng
- Cập nhật số lượng mục
- Quản lý mục trong giỏ
- Tính toán giá

### 📊 Bảng Điều Khiển Phân Tích
- Trực quan hóa biểu đồ bằng Flutter ECharts
- Trực quan hóa dữ liệu tỉnh thành Việt Nam
- Tích hợp bản đồ GeoJSON
- Phân tích bán hàng theo vùng

### 👤 Module Hồ Sơ Người Dùng
- Quản lý hồ sơ người dùng
- Màn hình cài đặt

### 🌐 Tính Năng Mạng
- Giám sát kết nối mạng theo thời gian thực
- Tự động thử lại khi mất kết nối
- Xử lý lỗi và phản hồi người dùng

---

## 🛠️ Công Nghệ Sử Dụng

### Frontend
- **Flutter** 3.11+ - Framework UI
- **Dart 3.11+** - Ngôn ngữ lập trình

### Quản Lý Trạng Thái & Điều Hướng
- **flutter_bloc** ^9.1.1 - Cài đặt mẫu BLoC
- **equatable** ^2.0.3 - So sánh giá trị
- **go_router** ^14.0.0 - Điều hướng & định tuyến

### Mạng & API
- **dio** ^5.0.0 - HTTP client với interceptor
- **http** ^1.6.0 - Gói HTTP
- **connectivity_plus** ^7.1.1 - Giám sát kết nối mạng

### Xử Lý Dữ Liệu
- **json_annotation** ^4.9.0 - Tuần tự hóa JSON
- **json_serializable** ^6.9.0 - Tạo mã
- **freezed** ^2.4.4 - Tạo mã (tùy chọn)

### UI & Widget
- **cached_network_image** ^3.2.0 - Lưu trữ hình ảnh
- **shimmer** ^3.0.0 - Hiệu ứng tải
- **smooth_page_indicator** ^1.0.0 - Chỉ báo trang
- **motion_tab_bar** ^2.0.4 - Thanh tab hoạt hình
- **flutter_echarts** ^2.5.0 - Trực quan hóa biểu đồ
- **webview_flutter** ^4.9.0 - Hỗ trợ WebView

### Công Cụ Phát Triển
- **build_runner** ^2.4.9 - Trình tạo mã
- **flutter_lints** ^6.0.0 - Quy tắc linting

---

## 🏗️ Cấu Trúc Dự Án

```
lib/
├── main.dart                           # Điểm vào ứng dụng & thiết lập BLoC
│
├── core/                               # Mã dùng chung
│   ├── network/
│   │   ├── network_cubit.dart         # Trạng thái kết nối mạng
│   │   ├── network_wrapper.dart       # Tiện ích mạng
│   │   └── networking.dart            # Cấu hình mạng
│   │
│   ├── routes/
│   │   └── app_routes.dart            # Cấu hình GoRouter
│   │
│   └── widgets/                        # Widget tái sử dụng
│       ├── banner_widget.dart         # Carousel banner
│       ├── border_list_image.dart     # Danh sách hình ảnh có đường viền
│       ├── category_widget.dart       # Hiển thị danh mục
│       ├── search_bar.dart            # Widget nhập tìm kiếm
│       └── shimmer.dart               # Hiệu ứng shimmer khi tải
│
├── features/                           # Các module tính năng
│   │
│   ├── Home/                           # Module thương mại điện tử chính
│   │   ├── bloc/                       # Quản lý trạng thái BLoC
│   │   │   ├── product/
│   │   │   │   ├── product_bloc.dart         # Product BLoC
│   │   │   │   ├── product_event.dart        # Sự kiện sản phẩm
│   │   │   │   └── product_state.dart        # Trạng thái sản phẩm
│   │   │   ├── category/
│   │   │   │   ├── category_bloc.dart        # Category BLoC
│   │   │   │   ├── category_event.dart       # Sự kiện danh mục
│   │   │   │   └── category_state.dart       # Trạng thái danh mục
│   │   │   └── banner/
│   │   │       ├── banner_bloc.dart          # Banner BLoC
│   │   │       ├── banner_event.dart         # Sự kiện banner
│   │   │       └── banner_state.dart         # Trạng thái banner
│   │   │
│   │   ├── data/                       # Lớp dữ liệu
│   │   │   ├── dio_client.dart        # Singleton HTTP client Dio
│   │   │   ├── product_api.dart       # Gọi API
│   │   │   ├── product_repository.dart # Kho dữ liệu
│   │   │   └── models/
│   │   │       ├── products.dart      # Model sản phẩm (tuần tự hóa JSON)
│   │   │       ├── products.g.dart    # Mã tạo JSON
│   │   │       ├── categories.dart    # Model danh mục
│   │   │       └── categories.g.dart  # Mã tạo JSON
│   │   │
│   │   └── views/                     # Lớp UI
│   │       ├── homepage_screen.dart   # Trang chủ với danh sách sản phẩm
│   │       ├── product_card.dart      # Widget thẻ sản phẩm
│   │       └── product_detail_screen.dart # Trang chi tiết sản phẩm
│   │
│   ├── Cart/                           # Module giỏ hàng
│   │   ├── cubit/
│   │   │   ├── cart_cubit.dart        # Quản lý trạng thái giỏ hàng
│   │   │   └── cart_state.dart        # Trạng thái giỏ hàng
│   │   ├── models/
│   │   │   └── cart_model.dart        # Model mục giỏ hàng
│   │   └── views/
│   │       ├── cart_screen.dart       # Trang giỏ hàng
│   │       └── cart_item.dart         # Widget mục giỏ hàng
│   │
│   ├── Chart/                          # Module trực quan hóa dữ liệu
│   │   ├── chart_screen.dart          # Trực quan hóa ECharts
│   │   ├── debug.dart                 # Tiện ích gỡ lỗi
│   │   └── model/
│   │       └── vietnam_regions.dart   # Model dữ liệu vùng Việt Nam
│   │
│   ├── Profile/                        # Module hồ sơ người dùng
│   │   └── profile_screen.dart        # Trang hồ sơ
│   │
│   └── tabbar.dart                    # Điều hướng thanh tab dưới cùng
│
├── assets/                             # Tài sản tĩnh
│   ├── vietnam-provinces.json         # Dữ liệu tỉnh thành
│   ├── vietnam.geojson                # Dữ liệu bản đồ GeoJSON
│   └── vietnam.json                   # Dữ liệu Việt Nam
│
└── pubspec.yaml                        # Thư viện phụ thuộc & cấu hình
```

---

## 🔄 Kiến Trúc

### Mẫu Kiến Trúc Phân Lớp

```
┌─────────────────────────────────────┐
│      Lớp UI (Views)                 │
│  - Widget, Screen, Quản lý trạng thái│
└────────────────┬────────────────────┘
                 │ sử dụng
┌────────────────▼────────────────────┐
│  Lớp Logic Kinh Doanh (BLoC/Cubit)  │
│  - Xử lý sự kiện, phát sinh trạng thái│
└────────────────┬────────────────────┘
                 │ phụ thuộc vào
┌────────────────▼────────────────────┐
│   Lớp Dữ Liệu (Repository)          │
│  - Gọi API, biến đổi dữ liệu        │
└────────────────┬────────────────────┘
                 │ sử dụng
┌────────────────▼────────────────────┐
│  Lớp Mạng (Dio, API Client)         │
│  - Yêu cầu HTTP, xử lý lỗi          │
└─────────────────────────────────────┘
```

### Ví Dụ Luồng Dữ Liệu (Lấy Sản Phẩm)

```
Giao diện (HomePage)
    ↓
Phát Sự Kiện (FetchAllProducts)
    ↓
ProductBloc
    ↓
ProductRepository.getProducts()
    ↓
ProductApi.getProducts()
    ↓
DioClient (HTTP GET /products)
    ↓
Phân tích Phản hồi → Model Sản phẩm
    ↓
Phát Trạng Thái (ProductLoaded)
    ↓
Giao diện Tái xây dựng với Sản phẩm
```

### Mẫu Quản Lý Trạng Thái

**Mẫu BLoC (Module Trang Chủ):**
- Sự kiện: `FetchAllProducts`, `FetchProductsByCategory`, `RetryFetchProducts`
- Trạng thái: `ProductLoading`, `ProductLoaded`, `ProductError`
- Sử dụng cho logic kinh doanh phức tạp

**Mẫu Cubit (Module Giỏ Hàng):**
- Phương thức: `addToCart()`, `removeFromCart()`, `updateQuantity()`
- Trạng thái: `CartInitial`, `CartLoaded`
- Sử dụng cho quản lý trạng thái đơn giản

**Network Cubit:**
- Giám sát trạng thái kết nối theo thời gian thực
- Trạng thái: `NetworkConnected`, `NetworkDisconnected`

---

## 💻 Cài Đặt & Thiết Lập

### Yêu Cầu Tiên Quyết

- Flutter SDK 3.11+ ([Tải Flutter](https://flutter.dev))
- Dart SDK 3.11+
- Android SDK (cho phát triển Android)
- Xcode (cho phát triển iOS trên macOS)
- Git

### Hướng Dẫn Cài Đặt Từng Bước

1. **Sao chép kho lưu trữ**
   ```bash
   git clone <repository-url>
   cd My_App
   ```

2. **Cài đặt thư viện phụ thuộc**
   ```bash
   flutter pub get
   ```

3. **Tạo mã (tuần tự hóa JSON & các tệp tạo khác)**
   ```bash
   flutter pub run build_runner build
   ```
   
   Hoặc để tạo mã liên tục trong quá trình phát triển:
   ```bash
   flutter pub run build_runner watch
   ```

4. **Xác minh cài đặt**
   ```bash
   flutter doctor
   ```

---

## 🚀 Chạy Ứng Dụng

### Chế Độ Phát Triển
```bash
# Chạy ở chế độ debug (cần thiết bị được kết nối hoặc giả lập)
flutter run

# Chạy trên thiết bị cụ thể
flutter run -d <device-id>

# Chạy với hồ sơ
flutter run --profile
```

### Liệt Kê Thiết Bị Khả Dụng
```bash
flutter devices
```

### Thiết Lập iOS (macOS)
```bash
cd ios
pod install
cd ..
flutter run
```

### Thiết Lập Android
```bash
# Xây dựng APK
flutter build apk

# Xây dựng App Bundle
flutter build appbundle
```

### Thiết Lập Web
```bash
flutter run -d chrome
```

---

## 📦 Các Thư Viện Phụ Thuộc

### Các Thư Viện Cốt Lõi

| Thư Viện | Phiên Bản | Mục Đích |
|---------|---------|---------|
| flutter | SDK | Framework UI |
| flutter_bloc | ^9.1.1 | Quản Lý Trạng Thái |
| go_router | ^14.0.0 | Điều Hướng |
| dio | ^5.0.0 | HTTP Client |
| connectivity_plus | ^7.1.1 | Trạng Thái Mạng |
| json_serializable | ^6.9.0 | Tạo JSON |
| cached_network_image | ^3.2.0 | Lưu Trữ Hình Ảnh |
| flutter_echarts | ^2.5.0 | Trực Quan Hóa Biểu Đồ |

### Cập Nhật Thư Viện Phụ Thuộc
```bash
# Kiểm tra các gói cũ
flutter pub outdated

# Nâng cấp lên phiên bản mới nhất
flutter pub upgrade

# Nâng cấp lên phiên bản chính mới nhất
flutter pub upgrade --major-versions
```

---

## 🌐 Tích Hợp API

### Cấu Hình API Cơ Sở

- **URL Cơ Sở**: `https://dummyjson.com/` (DummyJSON API)
- **HTTP Client**: Dio với interceptor
- **Định Dạng Yêu Cầu/Phản Hồi**: JSON

### Các Điểm Cuối API Được Sử Dụng

#### Sản Phẩm
```
GET /products                      # Lấy tất cả sản phẩm
GET /products/:id                  # Lấy sản phẩm theo ID
GET /products/categories           # Lấy tất cả danh mục
GET /products/category/:name       # Lấy sản phẩm theo danh mục
```

#### Xử Lý Lỗi
- Các ngoại lệ Dio được bắt và chuyển đổi thành thông báo thân thiện với người dùng
- Kết nối mạng được giám sát bằng `NetworkCubit`
- Cơ chế thử lại tự động khi lấy sản phẩm không thành công

### Ví Dụ Luồng Gọi API

```dart
// Lớp kho lưu trữ
Future<List<Product>> getProducts() async {
  try {
    final response = await productApi.getProducts();
    final data = response.data as List;
    return data.map((p) => Product.fromJson(p)).toList();
  } catch (e) {
    throw Exception('Không thể lấy sản phẩm: $e');
  }
}
```

---

## 🎨 Chi Tiết Tính Năng

### 1. Danh Sách & Lọc Sản Phẩm
- **Vị Trí**: `lib/features/Home/`
- **Quản Lý Trạng Thái**: ProductBloc
- **Tính Năng**:
  - Tải sản phẩm từ API
  - Lọc theo danh mục
  - Hiển thị trong lưới phản ứng
  - Xử lý lỗi với thử lại

### 2. Giỏ Hàng
- **Vị Trí**: `lib/features/Cart/`
- **Quản Lý Trạng Thái**: CartCubit
- **Tính Năng**:
  - Thêm mục với số lượng
  - Cập nhật số lượng
  - Xóa mục
  - Phát hiện trùng lặp (hợp nhất số lượng)
  - Trạng thái giỏ hàng bền vững

### 3. Biểu Đồ & Phân Tích
- **Vị Trí**: `lib/features/Chart/`
- **Công Nghệ**: Flutter ECharts + GeoJSON
- **Tính Năng**:
  - Biểu đồ tương tác
  - Trực quan hóa tỉnh thành Việt Nam
  - Hiển thị dữ liệu theo vùng
  - Mã hóa màu động

### 4. Giám Sát Mạng
- **Vị Trí**: `lib/core/network/`
- **Quản Lý Trạng Thái**: NetworkCubit
- **Tính Năng**:
  - Phát hiện kết nối theo thời gian thực
  - Tích hợp plugin connectivity_plus
  - Phát sinh trạng thái tự động
  - Phản hồi UI khi mất kết nối

### 5. Hệ Thống Điều Hướng
- **Vị Trí**: `lib/core/routes/`
- **Công Nghệ**: GoRouter
- **Tuyến Đường**:
  - `/home` - Trang chủ với sản phẩm
  - `/cart` - Giỏ hàng
  - `/chart` - Bảng điều khiển phân tích
  - `/profile` - Hồ sơ người dùng
  - `/settings` - Cài đặt
  - `/product_detail/:id` - Chi tiết sản phẩm

---

## 🧪 Kiểm Thử

Dự án bao gồm các tiện ích kiểm thử:
- **Kiểm thử Future**: `lib/features/Home/bloc/` 
- **Kiểm thử Stream**: Các luồng kết nối mạng
- **Kiểm thử OOP**: Các lớp mô hình và biến đổi dữ liệu

Để chạy kiểm thử:
```bash
flutter test
```

---

## 📝 Tạo Mã

Dự án sử dụng tạo mã cho tuần tự hóa JSON:

```bash
# Tạo một lần
flutter pub run build_runner build

# Chế độ xem (tạo khi thay đổi tệp)
flutter pub run build_runner watch

# Xóa các tệp đã tạo
flutter pub run build_runner clean
```

Các tệp được tạo bao gồm:
- `products.g.dart` - Tuần tự hóa JSON của model sản phẩm
- `categories.g.dart` - Tuần tự hóa JSON của model danh mục

---

## 🐛 Khắc Phục Sự Cố

### Sự Cố Thường Gặp

**1. Sự Cố Build Runner**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build
```

**2. Sự Cố Pod Install (iOS)**
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
```

**3. Sự Cố Bộ Nhớ Đệm**
```bash
flutter clean
flutter pub get
```

**4. Sự Cố Xây Dựng Android**
```bash
cd android
./gradlew clean
cd ..
flutter run
```

---

## 📱 Nền Tảng Được Hỗ Trợ

- ✅ **Android** - Kiểm thử trên Android 5.0+
- ✅ **iOS** - Kiểm thử trên iOS 12.0+
- ✅ **Web** - Chrome, Firefox, Safari
- ✅ **macOS** - Intel & Apple Silicon
- ✅ **Windows** - Windows 10+
- ✅ **Linux** - Ubuntu 18.04+

---

## 🎓 Tài Nguyên Học Tập

- [Tài Liệu Flutter Chính Thức](https://flutter.dev/docs)
- [Mẫu BLoC](https://bloclibrary.dev/)
- [Tài Liệu GoRouter](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [DummyJSON API](https://dummyjson.com/)

---

## 📄 Giấy Phép

Dự án này là một phần của sáng kiến học tập. Thoải mái sử dụng và sửa đổi cho các mục đích giáo dục.

---

## 👨‍💻 Tác Giả

Được tạo như một dự án trình diễn phát triển Flutter hiện đại thể hiện các thực hành tốt nhất và mẫu kiến trúc sạch.

---

## 🤝 Đóng Góp

Chúng tôi chào đón các đóng góp và cải tiến! Thoải mái gửi yêu cầu pull hoặc mở các vấn đề cho lỗi và yêu cầu tính năng.

---

## 📞 Hỗ Trợ

Nếu có câu hỏi và vấn đề, vui lòng mở một vấn đề trong kho lưu trữ.

---

**Cập Nhật Lần Cuối**: Tháng 4 năm 2026
**Phiên Bản Flutter**: 3.11+
**Phiên Bản Dart**: 3.11+

```
HomePage (UI)
    ↓
BlocBuilder<ProductBloc, ProductState>
    ↓
ProductBloc (Event Handler)
    ├─→ FetchProducts event → _onFetchProducts()
    └─→ FetchBanners event → _onFetchBanners()
    ↓
ProductRepository (Business Logic)
    ↓
ProductApi (HTTP Calls via Dio)
    ↓
DioClient (HTTP Client Singleton)
    ↓
API Backend
```

---

## 🔌 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0          # State management
  go_router: ^10.0.0            # Navigation
  dio: ^5.0.0                   # HTTP client
  json_serializable: ^6.0.0     # JSON parsing
  
dev_dependencies:
  build_runner: ^2.0.0          # Code generation
  json_serializable: ^6.0.0
```

---

## 📱 Features

### 1. **Home Page**
- Hiển thị banner carousel (PageView)
- Danh sách products (ListView)
- Search bar
- Pull-to-refresh (TODO)

### 2. **Product Detail**
- Chi tiết sản phẩm
- Danh sách ảnh (gallery)
- Add to cart (TODO)

### 3. **Cart**
- Danh sách items trong giỏ hàng (TODO)

---

## 🚀 Setup & Run

### 1. Clone & Setup
```bash
cd /Users/gem/StudioProjects/My_App
flutter pub get
```

### 2. Generate JSON Serialization
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run App
```bash
flutter run
```

---

## ⚙️ Configuration

### API Base URL
Chỉnh sửa trong `lib/features/Home/data/dio_client.dart`:

```dart
baseUrl: 'https://api.example.com', // Thay URL thực tế
```

### API Endpoints
```
GET  /products       → Fetch all products
GET  /banners        → Fetch all banners
GET  /products/{id}  → Fetch product detail
```

---

## 🔧 BLoC Flow

### Event Definitions
```dart
// product_event.dart
class FetchProducts extends ProductEvent {}
class FetchBanners extends ProductEvent {}
```

### State Definitions
```dart
// product_state.dart
abstract class ProductState {}
class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Products> products;
  final List<Products> banners;
}
class ProductError extends ProductState {
  final String message;
}
```

### Event Handlers
```dart
// product_bloc.dart
on<FetchProducts>((event, emit) async {
  emit(ProductLoading());
  try {
    final products = await repository.fetchProducts();
    // Update state with products
    emit(ProductLoaded(...));
  } catch (e) {
    emit(ProductError(message: e.toString()));
  }
});
```

---

## 🎨 Widgets

| Widget | Path | Tác Dụng |
|--------|------|---------|
| `BannerWidget` | `core/widgets/banner_widget.dart` | Carousel banners |
| `ProductCard` | `core/widgets/product_card.dart` | Product item card |
| `MySearchBar` | `core/widgets/search_bar.dart` | Search input |
| `BorderListImage` | `core/widgets/border_list_image.dart` | Image list với border |

---

## 🐛 Known Issues & TODO

- [ ] Implement cart functionality
- [ ] Add pull-to-refresh
- [ ] Add product filtering/sorting
- [ ] Add favorites feature
- [ ] Implement pagination
- [ ] Add offline caching (Hive/SQLite)

---

## 📊 Models

### Products Model
```dart
class Products {
  final String id;
  final String name;
  final String thumbnail;
  final List<String>? images;
  final double price;
  final String description;
  final int stock;
}
```

---

## 🔐 Error Handling

### HTTP Errors
- **DioException** → Caught in `ProductApi`
- **Parse Errors** → Caught in `ProductRepository`
- **BLoC Errors** → Emitted as `ProductError` state

### UI Error Handling
```dart
if (state is ProductError) {
  return ErrorWidget(
    message: state.message,
    onRetry: () => context.read<ProductBloc>().add(FetchProducts()),
  );
}
```

---

## 📝 Code Standards

- **Naming**: camelCase for variables, PascalCase for classes
- **Naming Convention**: `_` prefix for private members
- **Comments**: Tiếng Anh cho comments quan trọng
- **Formatting**: `dart format .` để auto format

---

## 👨‍💻 Developer Info

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Architecture**: BLoC + Repository Pattern
- **Navigation**: Go Router

---

## 📞 Contact & Support

For issues or questions, contact the development team.

---

**Last Updated**: 16 tháng 4, 2026