import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/item_widget.dart';

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  @override
  void initState() {
  Get.find<ProfileController>().getItemStatic();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'my_static'.tr),
      body: GetBuilder<ProfileController>(
        builder: (profile){
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text("إحصائيات خدمه قيدها ", style: robotoBold.copyWith(fontSize: 18,color: Colors.black),),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(16),
                width: context.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow:const [
                     BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0,
                      offset: Offset(0,4),
                      blurRadius: 10,

                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("المبلغ المقدم لك من قيدها",style: robotoBold.copyWith(color: Colors.white,fontSize: 14),),
                        Spacer(),
                        Text("المبلغ المتاح لشراء",style: robotoBold.copyWith(color: Colors.white,fontSize: 14),),
                      ],
                    ),
SizedBox(height: 10,),
Row(
  children: [
    Image.asset(
      "assets/image/wallet.png",
      height: 50,
      width: 50,
    ),
    SizedBox(width: 10,),
    Text("${profile.userInfoModel!.amountAydha} ${"SAR".tr}",style: robotoBlack.copyWith(color: Colors.white),),
Spacer(),
    Text("${profile.userInfoModel!.walletBalance} ${"SAR".tr}",style: robotoBlack.copyWith(color: Colors.white),),

  ],
),
                    
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("المنتجات الاكثر شراء", style: robotoBold.copyWith(fontSize: 18,color: Colors.black),),
              SizedBox(height: 20,),

              for(int i=0;i<profile.item.length;i++)
            SizedBox(
              width: context.width,
              height: context.height*.15,
              child: ItemWidget(
                isStore: false, item:  profile.item[i], isFeatured: false,
                store:  null, index: i, length: profile.item.length, isCampaign: false,
                inStore: false,
              ),
            ),

            ],
          );
        },
      ),
    );
  }
}
