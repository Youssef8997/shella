class delevryManModels {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? identityNumber;
  String? identityType;
  String? identityImage;
  String? image;
  String? fcmToken;
  int? zoneId;
  String? createdAt;
  String? updatedAt;
  bool? status;
  int? active;
  int? earning;
  int? currentOrders;
  String? type;
  Null? storeId;
  String? applicationStatus;
  int? orderCount;
  int? assignedOrderCount;
  int? vehicleId;
  String? imageFullUrl;
  List<String>? identityImageFullUrl;
  LastLocation? lastLocation;
  List<Storage>? storage;

  delevryManModels(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.fcmToken,
        this.zoneId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.active,
        this.earning,
        this.currentOrders,
        this.type,
        this.storeId,
        this.applicationStatus,
        this.orderCount,
        this.assignedOrderCount,
        this.vehicleId,
        this.imageFullUrl,
        this.identityImageFullUrl,
        this.lastLocation,
        this.storage});

  delevryManModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    active = json['active'];
    earning = json['earning'];
    currentOrders = json['current_orders'];
    type = json['type'];
    storeId = json['store_id'];
    applicationStatus = json['application_status'];
    orderCount = json['order_count'];
    assignedOrderCount = json['assigned_order_count'];
    vehicleId = json['vehicle_id'];
    imageFullUrl = json['image_full_url'];
    identityImageFullUrl = json['identity_image_full_url'].cast<String>();
    lastLocation = json['last_location'] != null
        ? new LastLocation.fromJson(json['last_location'])
        : null;
    if (json['storage'] != null) {
      storage = <Storage>[];
      json['storage'].forEach((v) {
        storage!.add(new Storage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['zone_id'] = this.zoneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['active'] = this.active;
    data['earning'] = this.earning;
    data['current_orders'] = this.currentOrders;
    data['type'] = this.type;
    data['store_id'] = this.storeId;
    data['application_status'] = this.applicationStatus;
    data['order_count'] = this.orderCount;
    data['assigned_order_count'] = this.assignedOrderCount;
    data['vehicle_id'] = this.vehicleId;
    data['image_full_url'] = this.imageFullUrl;
    data['identity_image_full_url'] = this.identityImageFullUrl;
    if (this.lastLocation != null) {
      data['last_location'] = this.lastLocation!.toJson();
    }
    if (this.storage != null) {
      data['storage'] = this.storage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastLocation {
  int? id;
  Null? orderId;
  int? deliveryManId;
  String? time;
  String? longitude;
  String? latitude;
  String? location;
  String? createdAt;
  String? updatedAt;

  LastLocation(
      {this.id,
        this.orderId,
        this.deliveryManId,
        this.time,
        this.longitude,
        this.latitude,
        this.location,
        this.createdAt,
        this.updatedAt});

  LastLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    deliveryManId = json['delivery_man_id'];
    time = json['time'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['delivery_man_id'] = this.deliveryManId;
    data['time'] = this.time;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Storage {
  int? id;
  String? dataType;
  String? dataId;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Storage(
      {this.id,
        this.dataType,
        this.dataId,
        this.key,
        this.value,
        this.createdAt,
        this.updatedAt});

  Storage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataType = json['data_type'];
    dataId = json['data_id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['data_id'] = this.dataId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
