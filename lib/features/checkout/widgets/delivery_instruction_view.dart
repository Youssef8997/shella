import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:record/record.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class DeliveryInstructionView extends StatefulWidget {
  const DeliveryInstructionView({super.key});

  @override
  State<DeliveryInstructionView> createState() => _DeliveryInstructionViewState();
}

class _DeliveryInstructionViewState extends State<DeliveryInstructionView> {
  ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
      child: GetBuilder<CheckoutController>(
        builder: (orderController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                key: widget.key,
                controller: controller,
                title: Text('add_more_delivery_instruction'.tr, style: robotoMedium),
                trailing: Icon(orderController.isExpanded ? Icons.remove : Icons.add, size: 18),
                tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                onExpansionChanged: (value) => orderController.expandedUpdate(value),

                children: [

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppConstants.deliveryInstructionList.length,
                      itemBuilder: (context, index){
                      bool isSelected = orderController.selectedInstruction == index;
                    return InkWell(
                      onTap: () {
                        orderController.setInstruction(index);
                        if(controller.isExpanded) {
                          controller.collapse();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Icon(Icons.ac_unit, color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, size: 18),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Expanded(
                            child: Text(
                              AppConstants.deliveryInstructionList[index].tr,
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor),
                            ),
                          ),
                        ]),

                      ),
                    );
                  }),
                ],
              ),
            ),

            orderController.selectedInstruction != -1 ? Padding(
              padding:  EdgeInsets.symmetric(vertical: orderController.isExpanded ? Dimensions.paddingSizeSmall : 0),
              child: Row(children: [
                Text(
                  AppConstants.deliveryInstructionList[orderController.selectedInstruction].tr,
                  style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),
                ),

                InkWell(
                  onTap: ()=> orderController.setInstruction(-1),
                  child: const Icon(Icons.clear, size: 16),
                ),
              ])
            ) : const SizedBox(),

          ]);
        }
      ),
    );
  }
}
class DeliveryInstructionViewMedia extends StatefulWidget {
  const DeliveryInstructionViewMedia({super.key});

  @override
  State<DeliveryInstructionViewMedia> createState() => _DeliveryInstructionViewMediaState();
}

class _DeliveryInstructionViewMediaState extends State<DeliveryInstructionViewMedia> {
  ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
      child: GetBuilder<CheckoutController>(
          builder: (orderController) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  subtitle:Text("يمكنك اختيار طريقه واحده فقط",style: robotoRegular.copyWith(color: Colors.grey,fontSize: 12),),
                  key: widget.key,
                  controller: controller,
                  title: Text('add_more_delivery_instruction_media'.tr, style: robotoMedium),
                  trailing: Icon(orderController.isExpanded ? Icons.remove : Icons.add, size: 18),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  onExpansionChanged: (value) => orderController.expandedUpdate(value),

                  children: [
          GetBuilder<CheckoutController>(
            builder: (checkoutController) {
              return InkWell(
                onTap: () async {

                  ImagePicker image=ImagePicker();
                  checkoutController.setIntsructionFile(await image.pickMultipleMedia(limit: 2));
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).primaryColor),
                    image:Get.find<CheckoutController>().intsructionFile?.isNotEmpty==true? DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(

                        File(Get.find<CheckoutController>().intsructionFile![0].path),


                      )
                    ):null
                  ),

                  child: Get.find<CheckoutController>().intsructionFile?.isEmpty==true?null:Icon(Icons.image,size: 25,),
                ),
              );
            }
          ),

                    SizedBox(height: 10,),
                    /*SizedBox(
                        height: 100,
                        width: 100,
                        child: VoiceRecorder())*/
                  ],
                ),
              ),

              orderController.selectedInstruction != -1 ? Padding(
                  padding:  EdgeInsets.symmetric(vertical: orderController.isExpanded ? Dimensions.paddingSizeSmall : 0),
                  child: Row(children: [
                    Text(
                      AppConstants.deliveryInstructionList[orderController.selectedInstruction].tr,
                      style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),
                    ),

                    InkWell(
                      onTap: ()=> orderController.setInstruction(-1),
                      child: const Icon(Icons.clear, size: 16),
                    ),
                  ])
              ) : const SizedBox(),

            ]);
          }
      ),
    );
  }
}


/*
class VoiceRecorder extends StatefulWidget {
  @override
  _VoiceRecorderState createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  String? _filePath;

  Future<String> _generateFilePath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<void> _startRecording() async {
    try {
      final filePath = await _generateFilePath();
      bool hasPermission = await _audioRecorder.hasPermission();
      if (hasPermission) {
        await _audioRecorder.start(
          RecordConfig(

          ),
          path: filePath,
        );
        setState(() {
          _isRecording = true;
          _filePath = filePath;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Microphone permission denied")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to start recording: $e")),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Recording saved at: $_filePath")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to stop recording: $e")),
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _isRecording ? null : _startRecording,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _isRecording
                    ? Colors.red.withOpacity(0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: _isRecording
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                ),
              ),
              child: Icon(
                Icons.keyboard_voice,
                size: 25,
                color: _isRecording ? Colors.red : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_isRecording)
            ElevatedButton.icon(
              onPressed: _stopRecording,
              icon: Icon(Icons.stop),
              label: Text("Cancel Recording"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
              ),
            ),
        ],
      ),
    );
  }
}*/
