import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/wallet/controllers/wallet_controller.dart';

import '../../../common/widgets/custom_text_field.dart';

class ConvertMoneyBottomsheet extends StatefulWidget {
  const ConvertMoneyBottomsheet({super.key});

  @override
  State<ConvertMoneyBottomsheet> createState() => _ConvertMoneyBottomsheetState();
}

class _ConvertMoneyBottomsheetState extends State<ConvertMoneyBottomsheet> {
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController myOtp=TextEditingController();
  TextEditingController otpUser=TextEditingController();
  TextEditingController money=TextEditingController();
  bool isRequested=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: context.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView(
        children: [
          Center(
            child: Container(
              height: 1,
              width: context.width*.5,
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          if(!isRequested)
            Column(
            children: [
              SizedBox(height: 20,),
              Text(" اكتب رقم الهاتف مصحوب بكود البلد لصاحب الحساب الذي تريد التحويل له"),
              SizedBox(height: 20,),
              CustomTextField(
              controller:phoneNumber ,

              ),
              SizedBox(height: 20,),
              Center(child: ElevatedButton(onPressed: (){
                setState(() {
                  isRequested=true;

                });
                Get.find<WalletController>().requestExchange(phoneNumber.text);
              }, child: Text("طلب الكود"))),
            ],
          ),
          if(isRequested)
Column(
  children: [
    SizedBox(height: 20,),

    Text("سيصل الكود اليكم عن طريق الاشعارات"),
    SizedBox(height: 20,),

    CustomTextField(
      controller:money ,
      showTitle: true,

      titleText: "اكتب المبلغ الذي تريد تحويلو",
      prefixIcon: Icons.monetization_on,
    ),
    SizedBox(height: 20,),

    CustomTextField(
      controller:myOtp ,
      showTitle: true,

      titleText: "الكود الخاص بك",
      prefixIcon: Icons.qr_code,
    ),
    SizedBox(height: 20,),
    CustomTextField(
      controller:otpUser ,
      showTitle: true,
      titleText: "الكود الخاص بالحساب المحول له",
      prefixIcon: Icons.qr_code,

    ),
    SizedBox(height: 20,),

    Center(child: ElevatedButton(onPressed: ()async{
      await Get.find<WalletController>().Exchange(phoneNumber.text,myOtp.text,otpUser.text,money.text);
      Get.back();



    }, child: Text("تحويل المبلغ"))),


  ],
)
        ],
      ),
    );
  }
}
