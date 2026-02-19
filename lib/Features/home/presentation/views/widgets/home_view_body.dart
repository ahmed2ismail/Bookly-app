import 'package:bookly_app/Core/utils/assets.dart';
import 'package:bookly_app/Core/utils/styles.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          FuturedBooksListView(),
          SizedBox(height: 50),
          Text('Best Seller', style: Styles.textStyle18),
          SizedBox(height: 20),
          BestSellerListViewItem(),
        ],
      ),
    );
  }
}

class BestSellerListViewItem extends StatelessWidget {
  const BestSellerListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 2.5 / 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                image: const DecorationImage(
                  image: AssetImage(AssetsData.testImage),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                // width: MediaQuery.of(context).size.width * 0.5,
                width: 200,
                child: Text(
                  'Harry Potter and the Goblet of Fire',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'J.K. Rowling',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '19.99 \$',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.star, color: Colors.amber),
                      ),
                      const Text('4.8', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 5),
                      Text(
                        '[2390]',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
