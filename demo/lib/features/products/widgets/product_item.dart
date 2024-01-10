import 'package:demo/features/products/models/product_list_response.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';

class ProductItem extends StatelessWidget {
  final ProductListResponse productItem;

  const ProductItem({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(RouteNames.productDetailScreen,
              arguments: productItem.id);
        },
        contentPadding: const EdgeInsets.all(8),
        title: Text(productItem.title),
        subtitle: Text(
          productItem.description.toString(),
          maxLines: 2,
        ),
        leading: Image.network(
          productItem.image,
          width: 100,
        ),
        trailing: Text(productItem.price.toString()),
      ),
    );
  }
}
