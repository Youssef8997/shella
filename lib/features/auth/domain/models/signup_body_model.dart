class SignUpBodyModel {
  String? fName;
  String? lName;
  String? tName;
  String? phone;
  String? email;
  String? password;
  String? refCode;

  SignUpBodyModel({
    this.fName,
    this.lName,
    this.tName,
    this.phone,
    this.email = '',
    this.password,
    this.refCode = '',
  });

  SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    tName = json['t_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    refCode = json['ref_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['t_name'] = tName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['ref_code'] = refCode;
    return data;
  }
}
