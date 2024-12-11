class PackagesModel {
  final int id;
  final String name;
  final String enName;
  final int km;
  final double price;

  PackagesModel(
      {required this.id,
      required this.name,
      required this.km,
      required this.enName,
      required this.price});
  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
      id: json["id"],
      price: double.parse(json["price"].toString()),
      name: json["name"],
      enName: json["en_name"],
      km: json["km"]);
}
