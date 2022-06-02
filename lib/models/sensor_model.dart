class SensorModel {
  String? id;
  int? feedId;
  double? value;
  dynamic location;
  String? createdAt;
  String? updatedAt;
  String? expiration;
  dynamic lat;
  dynamic lon;
  dynamic ele;

  SensorModel(
      {this.id,
        this.feedId,
        this.value,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.expiration,
        this.lat,
        this.lon,
        this.ele});

  SensorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedId = json['feed_id'];
    value = double.parse(json['value']);
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiration = json['expiration'];
    lat = json['lat'];
    lon = json['lon'];
    ele = json['ele'];
  }


}
