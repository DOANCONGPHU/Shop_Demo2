import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Home/bloc/search/bloc/search_bloc.dart';
import 'package:my_app/features/Home/widgets/product_card.dart';

class SearchResult extends StatefulWidget {
  final String query;
  const SearchResult({super.key, required this.query});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
    context.read<SearchBloc>().add(FetchSearchResults(widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Kết quả tìm kiếm cho "${widget.query}"',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 125, 203),
          ),
        ),
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return switch (state) {
              SearchLoading() ||
              SearchInitial() => const Center(child: CircularProgressIndicator()),
              SearchError(:final message) => Center(child: Text(message)),
              SearchLoaded(:final results) =>
                results.isEmpty
                    ? const Center(
                        child: Text(
                          "404 - Not Found",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Marker Felt',
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: results.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final product = results[index];
                          return ProductCard(product: product);
                        },
                      ),
            };
          },
        ),
      ),
    );
  }
}
