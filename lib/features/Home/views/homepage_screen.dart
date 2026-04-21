import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/network/network_cubit.dart';
import 'package:my_app/core/network/network_wrapper.dart';
import 'package:my_app/core/widgets/banner_widget.dart';
import 'package:my_app/core/widgets/category_widget.dart';
import 'package:my_app/features/Home/views/product_card.dart';
import 'package:my_app/core/widgets/search_bar.dart';
import 'package:my_app/core/widgets/shimmer.dart';
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Shop Demo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 70, 125, 203),
          ),
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: BlocListener<NetworkCubit, NetworkState>(
        listener: (BuildContext context, state) {
          if (state is NetworkConnected) {
            context.read<ProductBloc>().add(RetryFetchProducts());
            context.read<CategoryBloc>().add(RetryFetchCategories());
            context.read<BannerBloc>().add(RetryFetchBanners());
            if (Navigator.of(context).canPop()) Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                NetworkWrapper(),
                const SizedBox(height: 12),
                const MySearchBar(),
                const SizedBox(height: 12),
                const HomeBannerSection(),
                const SizedBox(height: 12),
                const HomeCategorySection(),
                const SizedBox(height: 12),
                const HomeProductSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          BannerError() => const Text("Lỗi banner"),
        };
      },
    );
  }
}

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

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        } else if (state.error != null) {
          return Text("Lỗi sản phẩm: ${state.error}");
        } else {
          return Stack(
            children: [
              ListView.separated(
                itemCount: state.products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.push(
                      '/product_detail/${state.products[index].id}',
                    ); // Navigate to product detail page
                  },
                  child: ProductCard(product: state.products[index]),
                ),
              ),
              if (state.isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withValues(alpha: 0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
