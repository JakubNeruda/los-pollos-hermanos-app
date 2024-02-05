import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/menu_item_interface.dart';
import 'package:los_pollos_hermanos/models/product.dart';
import 'package:los_pollos_hermanos/pages/menu/product_page.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/util/image_util.dart';

import '../../models/category.dart';

class MenuItem extends StatelessWidget {
  final productService = GetIt.instance.get<GenericService<Product>>();
  final MenuWidget item;

  MenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => item.runtimeType == Category
                ? Scaffold(
                    appBar: AppBar(title: const Text("Choose product")),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 6 / 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return productBuilder(index);
                        },
                        itemCount: (item as Category).productIDs.length,
                      ),
                    ),
                  )
                : ProductPage(product: (item as Product)),
          ),
        ),
        child: itemColumn(),
      ),
    );
  }

  Widget productBuilder(int index) {
    return FutureBuilder<Product?>(
      future: productService.getItem((item as Category).productIDs[index]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return MenuItem(item: snapshot.data!);
      },
    );
  }

  Widget itemColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: Ink(
            color: Colors.white,
            child: buildImage(item.imageURL),
          ),
        ),
        Text(
          item.name,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
