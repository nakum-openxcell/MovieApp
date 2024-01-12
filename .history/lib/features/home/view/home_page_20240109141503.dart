import 'package:flutter/material.dart';

import '../widgets/home_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.network(
                state.productModel[index].image.toString(),
                height: 100,
              ),
              const SizedBox(height: 10),
              Text(
                state.productModel[index].title.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '\$ ${state.productModel[index].price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '⭐️ ${state.productModel[index].rating?.rate.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          );
        },
        itemCount: state.productModel.length,
      ),
    );
  }
}
