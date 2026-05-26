import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_apps/apps/model/product_model.dart';
import 'package:demo_apps/apps/theme/color.dart';
import 'package:demo_apps/apps/utils/utils_url.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(this.item);

  ProductModel item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  EdgeInsets _getResponsivePadding(BuildContext context) {
    return _isTablet(context) ? EdgeInsets.all(20.0) : EdgeInsets.all(12.0);
  }

  double _getCarouselAspectRatio(BuildContext context) {
    return _isTablet(context) ? 4 / 3 : 2 / 2;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    return _isTablet(context) ? baseSize * 1.2 : baseSize;
  }

  final _urlUtil = UtilsUrl();

  @override
  Widget build(BuildContext context) {
    ProductModel item = this.widget.item;
    bool isTablet = _isTablet(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "Detail Screen",
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isTablet ? _buildTabletLayout(item) : _buildPhoneLayout(item),
    );
  }

  Widget _buildPhoneLayout(ProductModel item) {
    return ListView(
      padding: _getResponsivePadding(context),
      children: [
        _buildSlideShow(),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: item.images[0],
            fit: BoxFit.cover,
            width: double.maxFinite,
            placeholder: (_, _) => Container(color: Colors.grey),
            errorWidget: (_, _, _) => Container(color: Colors.red),
          ),
        ),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: FaIcon(FontAwesomeIcons.dollarSign),
            title: Text(
              "USD ${item.price.toStringAsFixed(2)}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 16),
                fontWeight: FontWeight.bold,
                color: Colors.green.shade600,
              ),
            ),
          ),
        ),
        Card(
          child: FilledButton.icon(
            onPressed: () {
              _urlUtil.openUrl("tel:+85510558541");
            },
            icon: FaIcon(FontAwesomeIcons.phone),
            label: Text("Contact here"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: _getResponsiveFontSize(context, 14)),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text(
              item.category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: _getResponsiveFontSize(context, 14)),
            ),
          ),
        ),
        SizedBox(height: 8),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF8E977D),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
          label: Text(
            "ADD TO CART",
            style: TextStyle(fontSize: _getResponsiveFontSize(context, 14)),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(ProductModel item) {
    return SingleChildScrollView(
      padding: _getResponsivePadding(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildSlideShow(),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.images[0],
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    placeholder: (_, _) => Container(color: Colors.grey),
                    errorWidget: (_, _, _) => Container(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 18),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "USD ${item.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 20),
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 14),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.description,
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.category_outlined),
                    title: Text(
                      item.category.name,
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF8E977D),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    minimumSize: Size(double.maxFinite, 56),
                  ),
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.white,
                  ),
                  label: Text(
                    "ADD TO CART",
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideShow() {
    List<String> images = this.widget.item.images;

    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        aspectRatio: _getCarouselAspectRatio(context),
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
      itemCount: images.length,
      itemBuilder: (context, index, viewIndex) {
        final item = images[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: item,
              fit: BoxFit.cover,
              width: double.maxFinite,
              placeholder: (_, _) => Container(color: Colors.grey),
              errorWidget: (_, _, _) => Container(color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
