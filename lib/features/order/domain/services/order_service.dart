import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/order/domain/models/order_cancellation_body.dart';
import 'package:sixam_mart/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart/features/order/domain/models/order_model.dart';
import 'package:sixam_mart/features/order/domain/repositories/order_repository_interface.dart';
import 'package:sixam_mart/features/order/domain/services/order_service_interface.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';

import '../../../checkout/widgets/payment_failed_dialog.dart';

class OrderService implements OrderServiceInterface {
  final OrderRepositoryInterface orderRepositoryInterface;
  OrderService({required this.orderRepositoryInterface});

  @override
  Future<PaginatedOrderModel?> getRunningOrderList(
      int offset, bool fromDashboard) async {
    return await orderRepositoryInterface.getList(
        isRunningOrder: true, offset: offset, fromDashboard: fromDashboard);
  }

  @override
  Future<PaginatedOrderModel?> getHistoryOrderList(int offset) async {
    return await orderRepositoryInterface.getList(
        isHistoryOrder: true, offset: offset);
  }

  @override
  Future<List<OrderDetailsModel>?> getOrderDetails(
      String orderID, String? guestId) async {
    return await orderRepositoryInterface.get(orderID, guestId: guestId);
  }

  @override
  Future<List<CancellationData>?> getCancelReasons() async {
    return await orderRepositoryInterface.getList(isCancelReasons: true);
  }

  @override
  Future<List<String?>?> getRefundReasons() async {
    return await orderRepositoryInterface.getList(isRefundReasons: true);
  }

  @override
  Future<void> submitRefundRequest(
      int selectedReasonIndex,
      List<String?>? refundReasons,
      String note,
      String? orderId,
      XFile? refundImage) async {
    if (selectedReasonIndex == 0) {
      showCustomSnackBar('please_select_reason'.tr);
    } else {
      Map<String, String> body = {};
      body.addAll(<String, String>{
        'customer_reason': refundReasons![selectedReasonIndex]!,
        'order_id': orderId!,
        'customer_note': note,
      });
      Response response =
          await orderRepositoryInterface.submitRefundRequest(body, refundImage);
      if (response.statusCode == 200) {
        showCustomSnackBar(response.body['message'], isError: false);
        Get.offAllNamed(RouteHelper.getInitialRoute());
      }
    }
  }

  @override
  Future<Response> trackOrder(String? orderID, String? guestId,
      {String? contactNumber}) async {
    return await orderRepositoryInterface.trackOrder(orderID, guestId,
        contactNumber: contactNumber);
  }

  @override
  Future<bool> cancelOrder(String orderID, String? reason) async {
    return await orderRepositoryInterface.cancelOrder(orderID, reason);
  }

  @override
  OrderModel? prepareOrderModel(
      PaginatedOrderModel? runningOrderModel, int? orderID) {
    OrderModel? orderModel;
    if (runningOrderModel != null) {
      for (OrderModel order in runningOrderModel.orders!) {
        if (order.id == orderID) {
          orderModel = order;
          break;
        }
      }
    }
    return orderModel;
  }

  @override
  Future<bool> switchToCOD(String? orderID) async {
    bool isSuccess = false;
    Response response = await orderRepositoryInterface.switchToCOD(orderID);
    if (response.statusCode == 200) {
      isSuccess = true;
      await Get.offAllNamed(RouteHelper.getInitialRoute());
      showCustomSnackBar(response.body['message'], isError: false);
    }
    return isSuccess;
  }

  @override
  Future<void> paymentRedirect(
      {required String url,
      required bool canRedirect,
      required String? contactNumber,
      required Function onClose,
      required final String? addFundUrl,
      required final String? subscriptionUrl,
      required final String orderID,
      int? storeId}) async {
    bool forOrder = (addFundUrl == '' &&
        addFundUrl!.isEmpty &&
        subscriptionUrl == '' &&
        subscriptionUrl!.isEmpty);
    bool forSubscription = (subscriptionUrl != null &&
        subscriptionUrl.isNotEmpty &&
        addFundUrl == '' &&
        addFundUrl!.isEmpty);

    if (canRedirect) {
      bool isSuccess = forSubscription
          ? url.contains('success')
          : url.contains('success');
      bool isFailed = forSubscription
          ? url.contains('fail')
          : url.contains('fail');
      bool isCancel = forSubscription
          ? url.contains('fail')
          : url.contains('fail');
      if (isSuccess || isFailed || isCancel) {
        canRedirect = false;
        onClose();
      }

      if (forOrder) {
        if (isSuccess) {
          Get.offNamed(
              RouteHelper.getOrderSuccessRoute(orderID, contactNumber));
        } else if (isFailed || isCancel) {
        await  Get.find<OrderController>().trackOrder(orderID.toString(), null, false,
              contactNumber: "");
          Get.dialog(PaymentFailedDialog(
            orderID: orderID,
            orderAmount: Get.find<OrderController>().trackModel?.orderAmount,
            maxCodOrderAmount: 100,
            orderType:Get.find<OrderController>().trackModel?.orderType,
            isCashOnDelivery: true,
          ));
        }
      } else {
        if (isSuccess || isFailed || isCancel) {
          if (Get.currentRoute.contains(RouteHelper.payment)) {
            Get.back();
          }
          if (forSubscription) {
            Get.find<HomeController>()
                .saveRegistrationSuccessfulSharedPref(true);
            Get.find<HomeController>().saveIsStoreRegistrationSharedPref(true);
            Get.offAllNamed(RouteHelper.getSubscriptionSuccessRoute(
                status: isSuccess
                    ? 'success'
                    : isFailed
                        ? 'fail'
                        : 'cancel',
                fromSubscription: true,
                storeId: storeId));
          } else {
            Get.back();
            Get.toNamed(RouteHelper.getWalletRoute(
                fundStatus: isSuccess
                    ? 'success'
                    : isFailed
                        ? 'fail'
                        : 'cancel',
                token: UniqueKey().toString()));
          }
        }
      }
    }
  }

  @override
  Future<Response> acceptRequest(String? requestId) async {
    Response response = await orderRepositoryInterface.acceptRequest(requestId);
    return response;
  }
}
