import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_apps/apps/controller/grid_style_controller.dart';
import 'package:demo_apps/apps/model/product_model.dart';
import 'package:demo_apps/apps/screen/detail_screen.dart';
import 'package:demo_apps/apps/service/product_service.dart';
import 'package:demo_apps/apps/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final TextEditingController _searchController = TextEditingController();
final _service = ProductService();
late Future<List<ProductModel>> _futureData = _service.readApi();
bool _gridstyle = true;

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    _gridstyle = context.watch<GridStyleController>().gridStyle;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: _buildSearchBar(),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onSubmitted: (value) {
        setState(() {
          _futureData = _service.searchData(_searchController.text.trim());
        });
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _futureData = _service.searchData(_searchController.text.trim());
            });
          },
          icon: Icon(Icons.search, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureData = _service.searchData(_searchController.text.trim());
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
                        _futureData = _service.searchData(
                          _searchController.text.trim(),
                        );
                      });
                    },
                    child: Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildGridView(snapshot.data);
            }

            return Center(child: CircularProgressIndicator());
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
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
}
