import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/order/domain/models/order_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';

class OrderBannerViewWidget extends StatelessWidget {
  final OrderModel order;
  final bool ongoing;
  final bool parcel;
  final bool prescriptionOrder;
  final OrderController orderController;
  const OrderBannerViewWidget({super.key, required this.order, required this.ongoing, required this.parcel, required this.prescriptionOrder, required this.orderController, });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        order.orderStatus=="pending"? "assets/image/pending.gif":order.orderStatus=="processing"?order.moduleType=="ecommerce"?"assets/image/تحضير طلبات الماركت.gif":"assets/image/تحضير الطلبات.gif":order.orderStatus=="handover"?"assets/image/الطلب في الطريق.gif":"assets/image/تم التوصيل.gif",
        height: 140, width: double.infinity,

      )
    ]);
  }
}
