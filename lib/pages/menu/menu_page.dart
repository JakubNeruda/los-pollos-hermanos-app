import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/category.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/widgets/menu/menu_item.dart';

class MenuPage extends StatelessWidget {
  final categoryService = GetIt.instance.get<GenericService<Category>>();
  final GlobalKey<NavigatorState> navigatorKey;

  MenuPage({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: categoryService.listStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data!;
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Menu Available.',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 8 / 7,
                  ),
                  itemBuilder: (BuildContext context, int index) => MenuItem(
                    item: items[index],
                  ),
                  itemCount: items.length,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
