import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/market.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class ProductsCarouselItemWidget extends StatelessWidget {
  final double marginLeft;
  // final Product product;
  final Market market;
  final String heroTag;
  //Market market;

  ProductsCarouselItemWidget(
      {Key key, this.heroTag, this.marginLeft, this.market})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: RouteArgument(id: market.id, heroTag: heroTag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + market.id,
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: this.marginLeft, end: 20),
                  width: 100,
                  height: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: market.image.url,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: market.deliveryFee > 0
                      ? Colors.red
                      : Theme.of(context).accentColor,
                ),
                alignment: AlignmentDirectional.topEnd,
                child: Helper.getPrice(
                  market.deliveryFee,
                  context,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin:
                  EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.market.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    market.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
