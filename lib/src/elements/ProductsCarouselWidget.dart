import 'package:flutter/material.dart';
import 'package:wekala/src/models/market.dart';

import '../elements/ProductsCarouselItemWidget.dart';
import '../elements/ProductsCarouselLoaderWidget.dart';
import '../models/product.dart';

class ProductsCarouselWidget extends StatefulWidget {
  //final List<Product> productsList;
  final String heroTag;
  final List<Market> marketsList;

  ProductsCarouselWidget({Key key, this.heroTag, this.marketsList})
      : super(key: key);

  @override
  _ProductsCarouselWidgetState createState() => _ProductsCarouselWidgetState();
}

class _ProductsCarouselWidgetState extends State<ProductsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.marketsList.isEmpty
        ? ProductsCarouselLoaderWidget()
        : Container(
            height: 210,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: widget.marketsList.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return ProductsCarouselItemWidget(
                  heroTag: widget.heroTag,
                  marginLeft: _marginLeft,
                  market: widget.marketsList.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
