class AllRecordModel {
  String? id;
  double? value;
  int? feedId;
  String? feedKey;
  String? createdAt;
  int? createdEpoch;
  String? expiration;

  AllRecordModel(
      {this.id,
        this.value,
        this.feedId,
        this.feedKey,
        this.createdAt,
        this.createdEpoch,
        this.expiration});

  AllRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = double.parse(json['value']);
    feedId = json['feed_id'];
    feedKey = json['feed_key'];
    createdAt = json['created_at'];
    createdEpoch = json['created_epoch'];
    expiration = json['expiration'];
  }
}
