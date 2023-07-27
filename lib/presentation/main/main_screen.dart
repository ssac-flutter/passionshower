import 'package:flutter/material.dart';
import 'package:passionshower/presentation/like/like_view_model.dart';
import 'package:passionshower/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLiked = false; // Track whether the quote is liked or not

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainScreenViewModel>();
    final likeViewModel = context.watch<LikeScreenViewModel>();

    return Scaffold(
      body: PageView.builder(
        itemCount: viewModel.quotes.length,
        itemBuilder: (BuildContext context, int index) {
          final quote = viewModel.quotes[index];
          return InkWell(
            onTap: () {
              setState(() {
                _isLiked = !_isLiked; // Toggle the like status on each tap
              });

              if (_isLiked) {
                likeViewModel.likeQuote(quote); // Like the quote
              } else {
                likeViewModel.unlikeQuote(quote); // Unlike the quote
              }
            },
            child: Stack(
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          quote.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          quote.author,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          quote.job,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Icon(
                    _isLiked ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 32,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
