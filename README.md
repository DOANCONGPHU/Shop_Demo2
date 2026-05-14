# My App - Project Documentation

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Technology Stack](#technology-stack)
3. [Architecture](#architecture)
4. [Project Structure](#project-structure)
5. [Key Features](#key-features)
6. [Core Modules](#core-modules)
7. [Features](#features)
8. [Database](#database)
9. [State Management](#state-management)
10. [Networking](#networking)
11. [Notifications & Services](#notifications--services)
12. [Dependencies](#dependencies)
13. [Getting Started](#getting-started)

---

## Project Overview

**My App** is a comprehensive Flutter mobile application that combines e-commerce functionality with geographic mapping and analytical features. The app is built with modern Flutter architecture patterns including BLoC, Cubit, and Dependency Injection.

### Key Capabilities:
- 🛍️ E-commerce shopping cart system
- 📊 Data visualization with charts
- 🗺️ Real-time GPS tracking with Google Maps integration
- 🔔 Firebase Cloud Messaging (FCM) notifications
- 💾 Multi-database support (SQLite & Isar)
- 🔍 Advanced product search functionality
- ⚙️ Responsive settings management

---

## Technology Stack

### Framework & Language
- **Flutter** - Cross-platform mobile framework
- **Dart 3.11+** - Programming language

### State Management
- **Flutter BLoC** - Business Logic Component pattern
- **flutter_bloc** v9.1.1 - BLoC library

### Networking & HTTP
- **Dio** v5.0.0 - HTTP client
- **HTTP** v1.6.0 - Additional HTTP support
- **Connectivity Plus** v7.1.1 - Network connectivity monitoring

### Database & Storage
- **Isar Community** v3.3.2 - High-performance local database
- **SQLite** v2.4.2+1 - Relational database support
- **Path Provider** v2.1.5 - File system access

### Firebase & Cloud
- **Firebase Core** v4.7.0
- **Firebase Messaging** v16.2.0 - Push notifications

### UI & Widgets
- **Material Design** - Material UI components
- **Cupertino Icons** v1.0.8
- **Cached Network Image** v3.2.0
- **Shimmer** v3.0.0
- **Smooth Page Indicator** v1.0.0
- **Dotted Border** v3.1.0
- **Flutter Staggered Animations** v1.1.1
- **Motion Tab Bar** v2.0.4

### Maps & Location
- **Google Maps Flutter** v2.17.0 - Google Maps integration
- **Flutter Map** v8.3.0 - Alternative map library
- **Geolocator** v14.0.2 - GPS location services
- **LatLong2** v0.9.1 - Latitude/longitude utilities

### Utilities & Tools
- **Go Router** v14.0.0 - Navigation and routing
- **JSON Serialization** v4.11.0 - JSON parsing
- **Equatable** v2.0.3 - Value equality
- **Image Picker** v1.2.1 - Image selection
- **URL Launcher** v6.3.2 - URL opening
- **Alarm** v5.2.1 - Alarm scheduling
- **Flutter Markdown Plus** v1.0.7 - Markdown rendering
- **Flutter Local Notifications** v21.0.0 - Local notifications
- **Permission Handler** v12.0.0 - Permission management
- **Flutter Timezone** v5.0.2 - Timezone handling
- **Flutter Foreground Task** v9.2.2 - Background tasks
- **App Settings** v7.0.0 - App settings access

### Dependency Injection & Code Generation
- **Get It** v9.2.1 - Service locator
- **Injectable** v3.0.0 - Dependency injection decorator
- **Build Runner** v2.4.9 - Code generation tool
- **Injectable Generator** v3.0.2 - Injectable code generation
- **Isar Generator** v3.3.2 - Isar database code generation
- **JSON Serializable** v6.8.0 - JSON serialization code generation

---

## Architecture

### Design Patterns Used

1. **BLoC (Business Logic Component) Pattern**
   - Separates business logic from UI
   - Event-driven architecture
   - State management through streams

2. **Cubit Pattern**
   - Simplified BLoC without events
   - Direct state emission
   - Used for Cart management

3. **Repository Pattern**
   - Data abstraction layer
   - Handles API and local database operations
   - Caching mechanism

4. **Dependency Injection**
   - Using GetIt service locator
   - Injectable annotations for automatic setup
   - Lazy singleton and factory patterns

### Layered Architecture

```
┌─────────────────────────────────┐
│         UI Layer (Views)        │
├─────────────────────────────────┤
│   BLoC/Cubit (State Management) │
├─────────────────────────────────┤
│      Repository Layer           │
├─────────────────────────────────┤
│    API/Database Services        │
├─────────────────────────────────┤
│       Core Services             │
└─────────────────────────────────┘
```

---

## Project Structure

```
my_app/
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── firebase_options.dart              # Firebase configuration
│   │
│   ├── core/                              # Core functionality
│   │   ├── database/
│   │   │   ├── isar_service.dart         # Isar database service
│   │   │   └── sqflite_service.dart      # SQLite service
│   │   ├── di/
│   │   │   ├── injection.dart            # DI setup
│   │   │   ├── injection.config.dart     # Generated DI config
│   │   │   └── register_module.dart      # Module registration
│   │   ├── network/
│   │   │   ├── networking.dart           # Base networking setup
│   │   │   ├── network_cubit.dart        # Network state management
│   │   │   └── network_wrapper.dart      # Network wrapper utilities
│   │   ├── Notification/
│   │   │   ├── fcm_service.dart          # Firebase Cloud Messaging
│   │   │   └── notification_service.dart # Local notifications
│   │   ├── routes/
│   │   │   └── app_routes.dart           # Navigation routes (GoRouter)
│   │   └── widgets/
│   │       ├── banner_widget.dart
│   │       ├── border_list_image.dart
│   │       ├── category_widget.dart
│   │       ├── search_bar.dart
│   │       └── shimmer.dart
│   │
│   └── features/                          # Feature modules
│       ├── Cart/                          # Shopping cart feature
│       │   ├── cubit/
│       │   │   ├── cart_cubit.dart       # Cart state management
│       │   │   └── cart_state.dart       # Cart states
│       │   ├── models/
│       │   │   ├── cart_model.dart
│       │   │   ├── purchased_item.dart
│       │   │   └── purchased_item.g.dart # Generated Isar model
│       │   └── views/
│       │       ├── cart_item.dart
│       │       └── cart_screen.dart
│       │
│       ├── Chart/                         # Data visualization feature
│       │   ├── model/
│       │   │   └── vietnam_regions.dart  # Vietnamese regional data
│       │   └── views/
│       │       ├── chart_screen.dart     # Chart display
│       │       └── map_viewer.dart       # Map visualization
│       │
│       ├── Home/                          # Main home/shopping feature
│       │   ├── bloc/
│       │   │   ├── banner/               # Banner BLoC
│       │   │   │   ├── banner_bloc.dart
│       │   │   │   ├── banner_event.dart
│       │   │   │   └── banner_state.dart
│       │   │   ├── category/             # Category BLoC
│       │   │   │   ├── category_bloc.dart
│       │   │   │   ├── category_event.dart
│       │   │   │   └── category_state.dart
│       │   │   ├── product/              # Product BLoC
│       │   │   │   ├── product_bloc.dart
│       │   │   │   ├── product_event.dart
│       │   │   │   └── product_state.dart
│       │   │   ├── product detail/       # Product detail BLoC
│       │   │   │   ├── product_detail_bloc.dart
│       │   │   │   ├── product_detail_event.dart
│       │   │   │   └── product_detail_state.dart
│       │   │   └── search/               # Search BLoC
│       │   │       └── bloc/
│       │   │           ├── search_bloc.dart
│       │   │           ├── search_event.dart
│       │   │           └── search_state.dart
│       │   ├── data/
│       │   │   ├── dio_client.dart       # Dio HTTP client
│       │   │   ├── product_api.dart      # Product API calls
│       │   │   ├── product_repository.dart # Data repository
│       │   │   └── models/
│       │   │       ├── categories.dart
│       │   │       ├── categories.g.dart # Generated JSON model
│       │   │       ├── product_review.dart
│       │   │       ├── products.dart
│       │   │       └── products.g.dart   # Generated JSON model
│       │   ├── views/
│       │   │   ├── homepage_screen.dart
│       │   │   ├── product_detail_screen.dart
│       │   │   ├── review_product.dart
│       │   │   ├── reviewed_product.dart
│       │   │   └── search_result.dart
│       │   └── widgets/
│       │       ├── media_upload.dart
│       │       ├── product_card.dart
│       │       └── rating_section.dart
│       │
│       ├── Map/                           # GPS tracking and mapping
│       │   ├── api_key.dart              # API keys (Maps, etc.)
│       │   ├── bloc/
│       │   │   └── bloc/
│       │   │       ├── map_bloc.dart     # Map BLoC
│       │   │       ├── map_event.dart
│       │   │       └── map_state.dart
│       │   ├── services/
│       │   │   ├── gps_task_handler.dart # GPS background task
│       │   │   └── rest_alarm.dart       # Rest interval alarms
│       │   └── views/
│       │       └── map_screen.dart
│       │
│       ├── Setting/                       # Application settings
│       │   └── setting_screen.dart
│       │
│       └── Tabbar/                        # Navigation tab bar
│           └── tabbar.dart
│
├── assets/                                 # Static assets
│   ├── vietnam.geojson                   # Vietnam geographic data
│   ├── vietnam.json
│   ├── Hải Phòng (phường xã) - 34.geojson
│   ├── markdown/
│   │   └── policy.md                     # Policy markdown
│   └── sounds/
│
├── android/                                # Android native code
│   └── app/
│       ├── build.gradle.kts
│       └── src/
│
├── ios/                                    # iOS native code
│   ├── Podfile
│   ├── Runner/                            # iOS app configuration
│   └── Runner.xcworkspace/
│
├── web/                                    # Web platform
│
├── linux/                                  # Linux platform
│
├── windows/                                # Windows platform
│
├── macos/                                  # macOS platform
│
├── test/                                   # Unit & widget tests
│   └── widget_test.dart
│
├── pubspec.yaml                            # Flutter dependencies
├── analysis_options.yaml                   # Dart analysis config
├── devtools_options.yaml
├── firebase.json                           # Firebase config
└── README.md
```

---

## Key Features

### 1. **E-Commerce Shopping**
- Browse products by category
- View detailed product information
- Read and write product reviews
- Add/remove items from shopping cart
- Track cart quantity and totals
- Persistent cart storage using Isar database

### 2. **Product Management**
- Product listing with pagination
- Search functionality
- Category filtering
- Banner/promotional items
- Discount calculation
- Image gallery for products

### 3. **Geographic Mapping**
- Google Maps integration
- Real-time GPS tracking
- Background location monitoring
- Rest interval alarms for driver safety
- Foreground task service for continuous tracking
- Vietnamese regional data visualization

### 4. **Data Analytics & Visualization**
- ECharts integration for charts
- Vietnamese regional statistics
- Data-driven insights

### 5. **Notification System**
- Firebase Cloud Messaging (FCM)
- Local push notifications
- Alarm scheduling
- Background notification handling

### 6. **Settings & User Preferences**
- Application settings screen
- User customization options
- Permission management

---

## Core Modules

### Network Module (`core/network/`)
**Purpose**: Manages all network connectivity and HTTP operations

**Components**:
- `networking.dart` - Base Dio client configuration
- `network_cubit.dart` - Network state monitoring (online/offline)
- `network_wrapper.dart` - Network request wrapping utilities

**Key Features**:
- Connectivity monitoring
- Automatic retry logic
- Network state awareness
- Error handling

### Database Module (`core/database/`)
**Purpose**: Multi-database support for data persistence

**Components**:
- `isar_service.dart` - Isar database service
  - Used for purchased items tracking
  - High-performance NoSQL storage
  - Real-time queries
  
- `sqflite_service.dart` - SQLite database service
  - Relational data storage
  - Backup and sync capabilities

### Notification Module (`core/Notification/`)
**Purpose**: Handles all notification operations

**Components**:
- `fcm_service.dart`
  - Firebase Cloud Messaging initialization
  - Remote notification handling
  - Token management
  
- `notification_service.dart`
  - Local notifications
  - Notification scheduling
  - Alarm management

### Dependency Injection Module (`core/di/`)
**Purpose**: Application-wide dependency management

**Components**:
- `injection.dart` - Main DI setup with GetIt
- `injection.config.dart` - Generated configuration
- `register_module.dart` - Module registration

**Setup Pattern**:
```dart
// Register services using injectable annotations
// @lazySingleton, @singleton, @factory decorators
// Run: flutter pub run build_runner build
```

### Routing Module (`core/routes/`)
**Purpose**: Navigation and routing management

**Components**:
- `app_routes.dart` - GoRouter configuration

**Routes**:
- `/home` - Homepage with product listing
- `/cart` - Shopping cart
- `/chart` - Data visualization
- `/map` - GPS mapping
- `/settings` - Application settings
- `/product_detail/:id` - Product details

---

## Features

### Cart Feature (`features/Cart/`)
**State Management**: Cubit
**Responsibilities**:
- Add/remove products from cart
- Update quantities
- Calculate totals
- Persist cart data to Isar

**Key Classes**:
- `CartCubit` - State management
- `CartState` - State definitions
- `CartModel` - Cart data model
- `PurchasedItem` - Cart item model with Isar annotations

### Home Feature (`features/Home/`)
**State Management**: BLoC (multiple BLoCs)
**Responsibilities**:
- Product listing and management
- Category filtering
- Banner management
- Search functionality
- Product details and reviews

**BLoCs**:
- `BannerBloc` - Promotional banners
- `CategoryBloc` - Category management
- `ProductBloc` - Product listings
- `ProductDetailBloc` - Individual product details
- `SearchBloc` - Search functionality

**Data Layer**:
- `ProductApi` - API endpoints
- `ProductRepository` - Data aggregation with caching
- Models: `Products`, `Categories`, `ProductReview`

### Map Feature (`features/Map/`)
**State Management**: BLoC
**Responsibilities**:
- GPS location tracking
- Google Maps integration
- Background tracking service
- Rest interval management

**Key Components**:
- `MapBloc` - Map state and events
- `GPSTaskHandler` - Background GPS service
- `RestAlarm` - Rest interval tracking

**Events**:
- `MapInitialized` - Map initialization
- `MapTrackingToggled` - Start/stop tracking
- `MapTaskDataReceived` - GPS data updates
- `MapRestAlarmDismissed` - Rest alert handling

### Chart Feature (`features/Chart/`)
**Responsibilities**:
- Data visualization
- Regional statistics
- Chart rendering

**Components**:
- `ChartScreen` - Chart display
- `MapViewer` - Map visualization
- `VietnamRegions` - Regional data model

### Setting Feature (`features/Setting/`)
**Responsibilities**:
- User preferences
- Application configuration
- Settings display and management

---

## Database

### Isar Database
**Purpose**: High-performance local NoSQL database

**Configuration**:
- Location: Application documents directory
- Database name: `my_app_isar`
- Schemas: `PurchasedItem`

**Entities**:
- `PurchasedItem` - Purchased product records with Isar annotations

**Advantages**:
- Fast query performance
- Realtime listening
- Transaction support
- Flutter optimization

### SQLite Database
**Purpose**: Relational data storage

**Service**: `SqfliteService`

**Use Cases**:
- Backup and synchronization
- Relational queries
- Complex data relationships

---

## State Management

### BLoC Pattern
Used for complex state management in Home and Map features

**Pattern Flow**:
```
Events → BLoC → States → UI Updates
```

**Example (ProductBloc)**:
```dart
BlocListener<ProductBloc, ProductState>(
  listener: (context, state) {
    // Handle state changes
  },
  child: BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      // Build UI based on state
    },
  ),
)
```

### Cubit Pattern
Simplified state management for Cart feature

**Pattern Flow**:
```
Method calls → Cubit → States → UI Updates
```

**Example (CartCubit)**:
```dart
cubit.addToCart(item);  // Direct method call
emit(CartLoaded(updatedItems));  // State emission
```

### State Classes
All BLoCs use equatable for state comparison and immutability

**State Patterns**:
- Initial/Loading/Loaded/Error pattern
- Immutable state objects
- CopyWith for state updates

---

## Networking

### Dio HTTP Client
**Configuration** (in `ProductApi`):
- Base URL setup
- Interceptors
- Request/response handling
- Error mapping

### Request Flow
```
UI → BLoC/Cubit → Repository → API → Dio → Backend
↓
Caching layer (optional)
↓
Data Models
↓
UI Update
```

### Error Handling
- DioException mapping
- Network error recovery
- Retry mechanisms
- User-friendly error messages

### Caching Strategy
**ProductRepository** implements multi-level caching:
- In-memory cache for all products
- Category-specific cache
- Banners cache
- Categories cache

**Cache Invalidation**:
- Manual refresh triggers
- Optional cache expiration
- Network-first approach

---

## Notifications & Services

### Firebase Cloud Messaging (FCM)
**Setup**:
- Firebase initialization in `main.dart`
- `FirebaseOptions` configuration
- Platform-specific setup (Android/iOS)

**Functionality**:
- Remote push notifications
- Token management
- Message listening
- Background message handling

### Local Notifications
**Service**: `NotificationService`
**Features**:
- Scheduled notifications
- Alarm notifications
- Foreground notifications

### Background Services
**Flutter Foreground Task**:
- Continuous background operations
- GPS tracking while app is backgrounded
- Persistent notification
- Wake lock management

**Alarm Service**:
- Rest interval alarms
- Driver fatigue prevention
- Scheduled alerts

---

## Dependencies

### Runtime Dependencies (Main)
```yaml
flutter_bloc: ^9.1.1          # State management
dio: ^5.0.0                   # HTTP client
go_router: ^14.0.0            # Routing
isar_community: ^3.3.2        # Database
sqflite: ^2.4.2+1             # SQLite
firebase_core: ^4.7.0         # Firebase
firebase_messaging: ^16.2.0   # FCM
google_maps_flutter: ^2.17.0  # Maps
geolocator: ^14.0.2           # GPS
flutter_map: ^8.3.0           # Map library
cached_network_image: ^3.2.0  # Image caching
shimmer: ^3.0.0               # Loading shimmer
flutter_local_notifications: ^21.0.0
permission_handler: ^12.0.0
get_it: ^9.2.1                # DI
injectable: ^3.0.0            # DI decorator
```

### Development Dependencies
```yaml
build_runner: ^2.4.9
isar_community_generator: ^3.3.2
json_serializable: ^6.8.0
injectable_generator: ^3.0.2
```

---

## Getting Started

### Prerequisites
- Flutter 3.11+ SDK installed
- Dart 3.11+ SDK
- Android Studio / Xcode
- Firebase project setup
- Google Maps API keys

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd my_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build
   # or for watch mode:
   flutter pub run build_runner watch
   ```

4. **Configure Firebase**
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`
   - Update `firebase_options.dart` with your config

5. **Configure Google Maps**
   - Add API keys to `lib/features/Map/api_key.dart`
   - Enable Maps APIs in Google Cloud Console
   - Update `android/app/src/main/AndroidManifest.xml`
   - Update `ios/Runner/GoogleService-Info.plist`

### Running the App

**Debug mode**:
```bash
flutter run
```

**Release mode**:
```bash
flutter run --release
```

**Specific device**:
```bash
flutter run -d <device-id>
```

### Code Generation

After modifying models or adding injectable services:

```bash
# Single build
flutter pub run build_runner build

# Watch mode (recommended for development)
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

### Project Structure Best Practices

1. **Feature-First Organization**: Each feature is self-contained
2. **Separation of Concerns**: Clear layers (UI → BLoC → Repository → API)
3. **Immutability**: All state objects are immutable
4. **Type Safety**: Strong typing throughout
5. **Dependency Injection**: No hardcoded dependencies

### Common Development Tasks

**Add a new feature**:
1. Create feature folder under `features/`
2. Create `bloc/`, `data/`, `models/`, `views/` subdirectories
3. Create BLoC with events and states
4. Create Repository if API calls needed
5. Create API client if backend integration needed
6. Add route in `AppRoutes`
7. Register in DI container

**Add a new API endpoint**:
1. Add method to `ProductApi`
2. Add repository method in `ProductRepository`
3. Create corresponding BLoC event/state
4. Handle in BLoC event handler
5. Update UI to use new state

**Add new local data**:
1. Create model with Isar annotations
2. Add schema to `IsarService`
3. Create CRUD methods
4. Use in repository

---

## Notes

- **Multi-platform**: Builds for Android, iOS, Web, Linux, macOS, Windows
- **Version**: 1.0.0+1
- **SDK Requirement**: Dart 3.11.0 or higher
- **State**: Active development with modern Flutter patterns
- **Code Generation**: Requires running build_runner for models and DI
- **Firebase**: Requires Firebase project setup for messaging
- **Maps**: Requires Google Maps API configuration

---

**Last Updated**: May 14, 2026

**Project Type**: Commercial E-Commerce Application with Geographic Features

**Status**: Active Development
