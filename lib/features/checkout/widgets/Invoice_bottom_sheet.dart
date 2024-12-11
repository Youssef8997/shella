import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../common/widgets/custom_snackbar.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../util/styles.dart';
import '../controllers/checkout_controller.dart';

class InvoiceBottomSheet extends StatefulWidget {
  const InvoiceBottomSheet({super.key});

  @override
  State<InvoiceBottomSheet> createState() => _InvoiceBottomSheetState();
}

class _InvoiceBottomSheetState extends State<InvoiceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: ListView(
            children: [
      Center(
        child:Container(
          width: context.width*.3,
          height: 2,
          color: Colors.black,
        ),
      ),
              SizedBox(height: 10,),
              CheckboxListTile(value: checkoutController.isFirstOrder, onChanged: (value){
                checkoutController.toggleFirstOrder();
              },title: Text("isThisFirstOrderInInvoice".tr,style: robotoMedium,textAlign: TextAlign.start,),),
              if(!checkoutController.isFirstOrder)
Text("اذا لديك فاتوره جاريه تريد اضافه له هذا الطلب اكتب رقم الفاتوره",style: robotoBold.copyWith(color: Colors.grey,fontSize: 12),textAlign: TextAlign.start,),
                SizedBox(height: 10,),
                if(!checkoutController.isFirstOrder)
                CustomTextField(
                  labelText: "order_id".tr,
                  inputType: TextInputType.number,

                  onChanged: (value){
                    checkoutController.idOfMainOrder=value;
                  },
                ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){

                if(checkoutController.isFirstOrder==false&&(checkoutController.idOfMainOrder==""||checkoutController.idOfMainOrder==null)){
                  checkoutController.toggleAddInvoice();
                }else if(checkoutController.isFirstOrder==false&&(checkoutController.idOfMainOrder!=""||checkoutController.idOfMainOrder!=null)){
                  if(checkoutController.checkIFOrderFound(checkoutController.idOfMainOrder!)){
                    Navigator.pop(context);

                  }else {

                    checkoutController.toggleAddInvoice();

                    Navigator.pop(context);
                    checkoutController.idOfMainOrder=null;

                    showCustomSnackBar(
                        'ليس لديك فاتوره بهذا الرقم');
                  }

                }else{
                  Navigator.pop(context);

                }
              },style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                foregroundColor: MaterialStatePropertyAll(Theme.of(context).cardColor),
fixedSize: MaterialStatePropertyAll(Size(context.width*.3,40))
              ), child: Text("confirm".tr,style: robotoBold.copyWith(color: Colors.white,),),)
            ],
          ),
        );
      }
    );
  }
}
