# My App - Flutter E-Commerce API Demo

## 📋 Tổng Quan Dự Án

Ứng dụng Flutter demo integrates API để hiển thị danh sách sản phẩm, banners và chi tiết sản phẩm. Sử dụng BLoC pattern cho state management.

---

## 🏗️ Cấu Trúc Dự Án

```
lib/
├── main.dart                          # Entry point, setup BlocProvider
├── core/
│   ├── routes/
│   │   └── app_routes.dart           # Go Router config
│   └── widgets/
│       ├── banner_widget.dart        # Banner carousel
│       ├── border_list_image.dart    # Image list với border
│       ├── product_card.dart         # Product card UI
│       └── search_bar.dart           # Search bar widget
├── features/
│   ├── Cart/
│   │   └── cart_screen.dart         # Cart screen (TODO)
│   └── Home/
│       ├── bloc/
│       │   ├── product_bloc.dart     # BLoC logic
│       │   ├── product_event.dart    # Events: FetchProducts, FetchBanners
│       │   └── product_state.dart    # States: Loading, Loaded, Error
│       ├── data/
│       │   ├── dio_client.dart       # Dio singleton config
│       │   ├── product_api.dart      # API calls
│       │   ├── product_repository.dart # Business logic layer
│       │   └── models/
│       │       ├── products.dart     # Product model
│       │       └── products.g.dart   # Generated JSON serialization
│       └── views/
│           ├── homepage_screen.dart  # Home page (BLoC UI)
│           ├── product_detail_screen.dart # Product detail
│           └── tabbar.dart          # Tab navigation
└── Test/
    ├── future.dart                   # Future testing
    ├── opp.dart                      # OOP testing
    └── stream.dart                   # Stream testing
```

---

## 🔄 Data Flow (Architecture)

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