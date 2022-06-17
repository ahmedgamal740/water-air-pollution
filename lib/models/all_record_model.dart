
class AllRecordModel {
  int? id;
  dynamic value;
  //int? feedId;
  String? dateTime;
  String? sensorName;
  // int? createdEpoch;
  // String? expiration;

  AllRecordModel(
      {this.id,
        this.value,
        this.dateTime,
        this.sensorName,
      });

  AllRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    dateTime = json['dateTime'];
    sensorName = json['sensorName'];
    // createdAt = json['created_at'];
    // createdEpoch = json['created_epoch'];
    // expiration = json['expiration'];
  }
}
