class AddressModel {
  int? id;
  String? name;
  String? description;
  double? latitude;
  double? longitude;

  AddressModel({
    this.id,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
  }
}