import 'package:demo/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constant/localization_keys.dart';
import '../../../core/routes/route_names.dart';
import '../bloc/product_detail_cubit.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen(this.productId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return ProductDetailScreenState();
  }
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    getProductDetail();
  }

  void getProductDetail() async {
    final ProductDetailCubit productListCubit =
        BlocProvider.of<ProductDetailCubit>(context);
    productListCubit.getProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationKeys();
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.productDetailTitle),
        ),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailInitial) {
              return showLoader();
            } else if (state is ProductDetailSuccess) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            RouteNames.productImageViewScreen,
                            arguments: state.productDetailResponse.image);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Image.network(
                          state.productDetailResponse.image,
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.productDetailResponse.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.productDetailResponse.description,
                      style: const TextStyle(color: greyColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Category: ${state.productDetailResponse.category.toString()}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Price: ${state.productDetailResponse.price.toString()}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBarIndicator(
                        rating: state.productDetailResponse.rating.rate,
                        itemCount: 5,
                        itemSize: 30.0,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: greenColor,
                            )),
                    const Spacer(),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: whiteColor,
                          backgroundColor: orangeColor, // foreground
                        ),
                        onPressed: () {
                          Share.share(state.productDetailResponse.title,
                              subject:
                                  state.productDetailResponse.price.toString());
                        },
                        child: Text(
                          localization.shareTitle,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return showLoader();
            }
          },
        ));
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
