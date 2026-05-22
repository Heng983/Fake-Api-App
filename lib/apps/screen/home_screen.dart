// import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_apps/apps/controller/grid_style_controller.dart';
import 'package:demo_apps/apps/screen/detail_screen.dart';
import 'package:demo_apps/apps/theme/color.dart';
import 'package:demo_apps/apps/model/product_model.dart';
import 'package:demo_apps/apps/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _showIcon = false;
  final _scroller = ScrollController();
  bool _gridstyle = true;

  final _service = ProductService();
  late Future<List<ProductModel>> _futureData = _service.readApi();

  @override
  void initState() {
    super.initState();
    _scroller.addListener(() {
      if (_scroller.position.pixels < 500) {
        setState(() {
          _showIcon = false;
        });
      } else {
        setState(() {
          _showIcon = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gridstyle = context.watch<GridStyleController>().gridStyle;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _showIcon ? _buildFloatingActionButton() : null,
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Colors.blueGrey,
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: Icon(Icons.arrow_circle_up_sharp, color: Colors.white),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Products App",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    );
  }

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _service.readApi();
          });
        },
        child: FutureBuilder<List<ProductModel>?>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${snapshot.error.toString()}"),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _futureData = _service.readApi();
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildGridView(snapshot.data);
            } else {
              return _buildLoading();
            }
          },
        ),
      ),
    );
  }

  Widget _buildGridView(List<ProductModel>? items) {
    if (items == null) {
      return Icon(Icons.library_books_outlined);
    }

    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      controller: _scroller,
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // crossAxisCount: _gridstyle ? 2 : 1,
        // childAspectRatio: _gridstyle ? 2 / 3 : 2 / 2,
        crossAxisCount: _gridstyle ? (isTablet || isLandscape ? 3 : 2) : 1,
        childAspectRatio: _gridstyle ? 2 / 3 : 2 / 2,
      ),
      itemBuilder: (context, index) {
        ProductModel item = items[index];

        return InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => DetailScreen(item)));
          },
          child: Card(
            color: AppColors.cardColor,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.images[0],
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      placeholder: (_, _) => Container(color: Colors.grey),
                      errorWidget: (_, _, _) => Container(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "USD ${item.price.toStringAsFixed(2)}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double screenWidth = MediaQuery.of(context).size.width;
    return Skeletonizer(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 1200 ? (screenWidth - 1200) / 2 : 8,
          vertical: 8,
        ),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: _gridstyle ? 2 : 1,
          // childAspectRatio: _gridstyle ? 2 / 3 : 2 / 2,
          crossAxisCount: _gridstyle ? (isTablet || isLandscape ? 3 : 2) : 1,
          childAspectRatio: _gridstyle ? 2 / 3 : 2 / 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.cardColor,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("", maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("", maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
