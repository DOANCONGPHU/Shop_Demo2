import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/di/injection.dart';
import 'package:my_app/core/network/network_cubit.dart';
import 'package:my_app/core/network/network_wrapper.dart';
import 'package:my_app/core/widgets/banner_widget.dart';
import 'package:my_app/core/widgets/category_widget.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
import 'package:my_app/features/Home/data/product_repository.dart';
import 'package:my_app/features/Home/widgets/product_card.dart';
import 'package:my_app/core/widgets/search_bar.dart';
import 'package:my_app/core/widgets/shimmer.dart';
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart';
import 'package:my_app/features/Home/bloc/product/product_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

void _fetchInitialData() {
  context.read<ProductBloc>().add(FetchAllProducts());
  context.read<CategoryBloc>().add(FetchCategories());
  context.read<BannerBloc>().add(FetchBanners());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Shop Demo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 125, 203),
          ),
        ),
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkConnected) {
            final productState = context.read<ProductBloc>().state;
            if (productState.error != null && productState.products.isEmpty) {
              context.read<ProductBloc>().add(RetryFetchProducts());
              context.read<CategoryBloc>().add(RetryFetchCategories());
              context.read<BannerBloc>().add(RetryFetchBanners());
            }
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            getIt<ProductRepository>().clearCache();
            _fetchInitialData();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const NetworkWrapper(),
                      const MySearchBar(),
                      const SizedBox(height: 12),
                      const HomeBannerSection(),
                      const SizedBox(height: 12),
                      const HomeCategorySection(),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const HomeProductSection(),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- BANNER SECTION ---
class HomeBannerSection extends StatelessWidget {
  const HomeBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerBloc, BannerState>(
      listener: (context, state) {
        if (state is BannerError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        
      },
      builder: (context, state) {
        return switch (state) {
          BannerInitial() || BannerLoading() => const ShimmerBanner(),
          BannerLoaded(banners: var data) => BannerWidget(
            bannerImages: data.map((b) => b.thumbnail).toList(),
          ),
          BannerError(message: var message) => Center(child: Text(message)),
        };
      },
    );
  }
}

// --- CATEGORY SECTION ---
class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (p, c) =>
          p.categories != c.categories || p.selectedId != c.selectedId,
      builder: (context, state) {
        return SizedBox(
          height: 30,
          child: CategoryWidget(
            categories: state.categories,
            selectedCategoryId: state.selectedId,
          ),
        );
      },
    );
  }
}


// --- PRODUCT SECTION  ---

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.products != current.products ||
          previous.isLoading != current.isLoading ||
          previous.error != current.error,
      builder: (context, state) {
        // Loading
        if (state.isLoading && state.products.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              key: ValueKey('loading'), 
              padding: EdgeInsets.all(100),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // Lỗi
        if (state.error != null && state.products.isEmpty) {
          return SliverToBoxAdapter(
            child: Container(
              key: const ValueKey('error'),
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Lỗi: ${state.error}"),
                  TextButton(
                    onPressed: () => context.read<ProductBloc>().add(RetryFetchProducts()),
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            ),
          );
        }

        // Loaded 
        return SliverPadding(
          key: ValueKey(state.products.hashCode), 
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: AnimationLimiter( 
            child: SliverList.separated(
              itemCount: state.products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 50), 
                  child: SlideAnimation( 
                    verticalOffset: 50.0,
                    child: FadeInAnimation( 
                      child: InkWell(
                        onTap: () => context.push('/product_detail/${product.id}'),
                        child: ProductCard(product: product),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}