import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  void initState() {
    Get.find<AuthController>().getPacakages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(title: 'package'.tr),
        body: GetBuilder<AuthController>(builder: (authController) {
          return Column(
            children: [
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: ResponsiveHelper.isDesktop(context)
                            ? Dimensions.paddingSizeExtremeLarge
                            : Dimensions.paddingSizeLarge,
                        mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                            ? Dimensions.paddingSizeExtremeLarge
                            : 10,
                        // childAspectRatio: ResponsiveHelper.isDesktop(context) ? 5 : 4.5,
                        mainAxisExtent:
                            ResponsiveHelper.isDesktop(context) ? 130 : 100,
                        crossAxisCount:
                            ResponsiveHelper.isMobile(context) ? 1 : 2,
                      ),
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, i) => Container(
                            height: context.height * .13,
                            width: context.width,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                    blurRadius: 14,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      Get.find<LocalizationController>().locale.languageCode=="en"? authController
                                          .package[i].enName:authController
                                          .package[i].name,
                                      style: robotoBold.copyWith(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                          Container(
                                            width: context.width,
                                            height: context.height * .3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.all(25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                 Get.find<LocalizationController>().locale.languageCode=="en"? authController
                                                     .package[i].enName:authController
                                                      .package[i].name,
                                                  style: robotoBlack,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "${"price".tr}: ${authController.package[i].price}",
                                                  style: robotoBold.copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "هل تريد الاشتراك في هذه الباقه".tr,
                                                  style: robotoBold.copyWith(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: ElevatedButton(
                                                      onPressed: () {
                                                        if(Get.find<ProfileController>().userInfoModel?.km==0||Get.find<ProfileController>().userInfoModel?.km==null){
                                                          Get.toNamed(RouteHelper.getPaymentRoute('0', 0, '', 0, false, '', guestId: '',subscriptionUrl: "${AppConstants.baseUrl}/payment-mobile/package/${authController.package[i].id}?user_id=${Get.find<ProfileController>().userInfoModel!.id}"));
                                                        }else{
                                                          Get.back();
                                                          GetSnackBar(titleText: Text("عفوا لا يمكنك الاشتراك",style: robotoBlack.copyWith(color: Colors.white,fontSize: 16),),message: "لديك رصيد متبقي ${Get.find<ProfileController>().userInfoModel?.km} ك/م ",backgroundColor: Theme.of(context).primaryColor,duration: Duration(seconds: 2),).show();
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                      child: Text(
                                                        "yes".tr,
                                                        style:
                                                            robotoBold.copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child:
                                                                Text("no".tr))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          "subscribe".tr,
                                          style: robotoBold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${"price".tr}:${authController.package[i].price}",
                                  style: robotoBold.copyWith(
                                      fontSize: 16, color: Colors.white),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                      itemCount: Get.find<AuthController>().package.length)),
            ],
          );
        }));
  }
}
