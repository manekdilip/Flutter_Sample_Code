import 'package:demo/core/routes/route_names.dart';
import 'package:demo/features/products/bloc/product_list_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/localization_keys.dart';
import '../widgets/product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductListScreenState();
  }
}

class ProductListScreenState extends State<ProductList> {
  late ProductListCubit productListCubit;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  void getProductList() async {
    final ProductListCubit productListCubit =
        BlocProvider.of<ProductListCubit>(context);
    productListCubit.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationKeys();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(localization.productListTitle),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'English', 'Français', 'German'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          builder: (context, state) {
            if (state is ProductListInitial) {
              return showLoader();
            } else if (state is ProductListSuccess) {
              return ListView.builder(
                itemCount: state.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductItem(
                    productItem: state.productList[index],
                  );
                },
              );
            } else {
              return showLoader();
            }
          },
        ));
  }

  void handleClick(String value) {
    switch (value) {
      case 'English':
        changeLanguage("en");
        break;
      case 'Français':
        changeLanguage("fr");
        break;
      case 'German':
        changeLanguage("de");
        break;
    }
  }

  void changeLanguage(String locale) {
    context.setLocale(Locale(locale));
    Intl.defaultLocale = locale;
    Navigator.of(context).pushReplacementNamed(RouteNames.productListScreen);
  }

  Widget showLoader() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const CircularProgressIndicator(),
    );
  }
}
