import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    final productBloc = context.read<ProductBloc>();
    final categoryBloc = context.read<CategoryBloc>();
    final bannerBloc = context.read<BannerBloc>();

    if (productBloc.state.products.isEmpty) {
      productBloc.add(FetchAllProducts());
    }
    if (categoryBloc.state.categories.isEmpty) {
      categoryBloc.add(FetchCategories()); 
    }
    if (bannerBloc.state is BannerInitial ||
        (bannerBloc.state is BannerLoaded)) {
      bannerBloc.add(FetchBanners());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            context
                .read<ProductRepository>()
                .clearCache(); 
            _fetchInitialData();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      NetworkWrapper(),
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
          BannerError() => const Center(child: Text("Lỗi load banner")),
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
        if (state.isLoading && state.products.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state.error != null && state.products.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text("Lỗi: ${state.error}"),
                  TextButton(
                    onPressed: () =>
                        context.read<ProductBloc>().add(RetryFetchProducts()),
                    child: const Text("Thử lại"),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverList.separated(
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    context.push('/product_detail/${state.products[index].id}'),
                child: ProductCard(product: state.products[index]),
              );
            },
          ),
        );
      },
    );
  }
}
