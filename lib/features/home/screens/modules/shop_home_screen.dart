import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/home/widgets/brands_view_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/features/flash_sale/widgets/flash_sale_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/product_with_categories_view.dart';
import 'package:sixam_mart/features/home/widgets/views/featured_categories_view.dart';
import 'package:sixam_mart/features/home/widgets/views/popular_store_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/middle_section_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/promotional_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../../helper/route_helper.dart';
import '../../widgets/highlight_widget.dart';
import '../../widgets/views/store_wise_banner_view.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();
    return Get.find<SplashController>().module?.id==3?GetBuilder<CategoryController>(
      builder: (categoryController) {
        return categoryController.categoryList==null? Center(
          child: CircularProgressIndicator.adaptive(backgroundColor: Theme.of(context).primaryColor,),
        ):SizedBox(height: context.height,
          width: context.width,
          child: GridView.builder(padding: EdgeInsets.only(top: 10,bottom: 300),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            
            crossAxisCount: 3,


          ), itemBuilder: (context,index)=>InkWell(
            onTap: (){
              Get.find<CategoryController>().getCategoryItemList(Get.find<CategoryController>().categoryList![index].id.toString(), 1, 'all', false);

              Get.toNamed(RouteHelper.getCategoryItemRoute(
                Get.find<CategoryController>().categoryList![index].id, Get.find<CategoryController>().categoryList![index].name!,
              ));
            },
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: Get.find<CategoryController>().categoryList![index].imageFullUrl! ,
                  imageBuilder:(context,i,)=> Container(
                    width: context.width*.3,
                    height: context.height*.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: i,
                      ),
                      border: Border.all(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Text(Get.find<CategoryController>().categoryList![index].name!,style: robotoBold,textAlign: TextAlign.center,maxLines: 1,)
              ],
            ),
          ),itemCount:Get.find<CategoryController>().categoryList?.length??0 ,
          ),
        );
      }
    ):Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.shopModuleBannerBg),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          children: [
            BadWeatherWidget(),
            BannerView(isFeatured: false),
            SizedBox(height: 12),
          ],
        ),
      ),
      const CategoryView(),
      isLoggedIn ? const VisitAgainView() : const SizedBox(),
      const MostPopularItemView(isFood: false, isShop: true),
      const FlashSaleViewWidget(),
      const MiddleSectionBannerView(),
      const PopularStoreView(),
      const BrandsViewWidget(),
      const SpecialOfferView(isFood: false, isShop: true),
      const ProductWithCategoriesView(fromShop: true),
      const JustForYouView(),
      const FeaturedCategoriesView(),
      const HighlightWidget(),
      /* const StoreWiseBannerView(),*/
      const ItemThatYouLoveView(
        forShop: true,
      ),
      const NewOnMartView(isShop: true, isPharmacy: false),
      const PromotionalBannerView(),
    ]);
  }
}
