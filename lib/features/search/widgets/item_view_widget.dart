import 'package:sixam_mart/features/search/controllers/search_controller.dart' as search;
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/web_item_view.dart';

class ItemViewWidget extends StatelessWidget {
  final bool isItem;
  final ScrollController? scrollController;
  const ItemViewWidget({super.key, required this.isItem, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<search.SearchController>(builder: (searchController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: FooterView(
            child: Column(
              children: [
                SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: ResponsiveHelper.isDesktop(context) ? WebItemsView(
                      isStore: isItem, items: searchController.searchItemList, stores: searchController.searchStoreList,
                    ) : ItemsView(
                      isStore: isItem, items: searchController.searchItemList, stores: searchController.searchStoreList,
                    ),
                ),
                  if(searchController.haveMoreItem)
                  CircularProgressIndicator.adaptive()
              ],
            ),
          ),
        );
      }),
    );
  }
}
