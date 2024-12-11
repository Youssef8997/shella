import 'dart:async';
import 'dart:io';

import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/helper/marker_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
// import 'dart:ui';
import 'dart:ui' as ui;
import 'package:image/image.dart' as ui_image;

import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/features/order/widgets/address_details_widget.dart';

import '../../../common/models/delivery_man_model.dart';
import '../../../helper/route_helper.dart';
import '../../chat/domain/models/conversation_model.dart';
import '../../notification/domain/models/notification_body_model.dart';

class MapParcelScreen extends StatefulWidget {
  final AddressModel address;
  final bool fromStore;
  final bool isFood;
  const MapParcelScreen(
      {super.key,
        required this.address,
        this.fromStore = false,
        this.isFood = false});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapParcelScreen> {
  late LatLng _latLng;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  delevryManModels ?delevery;
  @override
  void initState() {
    super.initState();

    _latLng = LatLng(double.parse(widget.address.latitude!),
        double.parse(widget.address.longitude!));
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'location'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<ParcelController>(
    builder: (parcelController){
          return Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: _latLng, zoom: 16),
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  indoorViewEnabled: true,

                  markers: _markers,
                  onMapCreated: (controller) => _mapController = controller,

                ),
                Positioned(
                  left: Dimensions.paddingSizeLarge,
                  right: Dimensions.paddingSizeLarge,
                  bottom: Dimensions.paddingSizeLarge,
                  child: InkWell(
                    onTap: () {
                      if (_mapController != null) {
                        _mapController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: _latLng, zoom: 17)));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              spreadRadius: 3,
                              blurRadius: 10)
                        ],
                      ),
                      child: widget.fromStore
                          ? Text(
                        widget.address.address!,
                        style: robotoMedium,
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(
                              widget.address.addressType == 'home'
                                  ? Icons.home_outlined
                                  : widget.address.addressType == 'office'
                                  ? Icons.work_outline
                                  : Icons.location_on,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                                width: Dimensions.paddingSizeSmall),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.address.addressType!.tr,
                                        style: robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color:
                                          Theme.of(context).disabledColor,
                                        )),
                                    const SizedBox(
                                        height:
                                        Dimensions.paddingSizeExtraSmall),
                                    AddressDetailsWidget(
                                        addressDetails: widget.address),
                                  ]),
                            ),
                          ]),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('- ${widget.address.contactPersonName}',
                                          style: robotoMedium.copyWith(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge,
                                          )),
                                    ],
                                  ),
                                  Text('- ${widget.address.contactPersonNumber}',
                                      style: robotoRegular),
                                ],
                              ),
Spacer(),                              if(delevery!=null)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("${delevery?.fName??''} ${delevery?.lName??''}",
                                            style: robotoMedium.copyWith(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: Dimensions.fontSizeLarge,
                                            )),
                                        IconButton(onPressed: (){
                                          showModalBottomSheet(context: context, builder: (context)=>Container(
                                            width: context.width,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(delevery?.imageFullUrl??"",)
                                                    )
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Text("${delevery?.fName} ${delevery?.lName}",style: robotoBold,),
                                                SizedBox(height: 10,),
                                                Text("عدد الطلبات:  ${delevery?.assignedOrderCount}",style: robotoBold,),
                                                SizedBox(height: 10,),
                                                Text("عدد ايام الضمان علي الخدمه :  3 ",style: robotoBold,),
                                                SizedBox(height: 10,),
                                                Text("${delevery?.zoneId}",style: robotoBold,),
                                                Text("عدد ايام الضمان علي الخدمه :  3 ",style: robotoBold,),
                                                Text("عدد سنوات الخبره :  ${delevery?.vehicleId} ",style: robotoBold,),

                                              ],
                                            ),
                                          ));
                                        }, icon: Icon(
                                          Icons.question_mark,
                                          color: Colors.black,
                                            size: 18,
                                        ))
                                      ],
                                    ),

                                    Text("عدد ايام الضمان علي الخدمه: 3 ",
                                        style: robotoMedium.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeLarge,
                                        )),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        }
      ),
    );
  }

  void _setMarker() async {
    BitmapDescriptor markerIcon =
    await MarkerHelper.convertAssetToBitmapDescriptor(
      width: widget.isFood ? 100 : 150,
      imagePath: widget.fromStore
          ? widget.isFood
          ? Images.restaurantMarker
          : Images.markerStore
          : Images.locationMarker,
    );
    BitmapDescriptor de = await MarkerHelper.convertAssetToBitmapDescriptor(
      width: widget.isFood ? 100 : 150,
      imagePath: Images.delivery,
    );

    _markers = <Marker>{};
    _markers.add(Marker(
      markerId: const MarkerId('marker'),
      position: _latLng,
      icon: markerIcon,
    ));
    for(int i=0;i< Get.find<ParcelController>().delevrys.length;i++){
      print(Get.find<ParcelController>().delevrys[i]);
      _markers.add(Marker(
        visible: true,
onTap: (){
          setState(() {
            delevery=Get.find<ParcelController>().delevrys[i];

          });
},
        markerId:  MarkerId(Get.find<ParcelController>().delevrys[i].id.toString()),
        position: LatLng(double.parse(Get.find<ParcelController>().delevrys[i].lastLocation?.latitude??"0.0"),double.parse( Get.find<ParcelController>().delevrys[i].lastLocation?.longitude??"0.0")),
        icon: de,

        infoWindow: InfoWindow(
onTap: (){

  Get.toNamed(RouteHelper.getChatRoute(
    notificationBody: NotificationBodyModel(deliverymanId: Get.find<ParcelController>().delevrys[i].id, orderId: int.parse("0")),
    user: User(id:  Get.find<ParcelController>().delevrys[i].id, fName: Get.find<ParcelController>().delevrys[i] .fName, lName: Get.find<ParcelController>().delevrys[i].lName, imageFullUrl:  Get.find<ParcelController>().delevrys[i].imageFullUrl),
  ));
},
          title: Get.find<ParcelController>().delevrys[i].fName,
          snippet: " عدد الطلبات :${Get.find<ParcelController>().delevrys[i].assignedOrderCount.toString()} "
        )
      ));
    }

    setState(() {});
  }
}
