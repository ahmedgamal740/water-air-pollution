// {
// "id": 148,
// "value": 220,
// "dateTime": "2022-06-16T12:20:11.1873642",
// "sensorName": "Gaz"
// }
class SensorModel {
  int? id;
  dynamic value;
  String? dateTime;
  String? sensorName;

  SensorModel(
      {
        this.id,
        this.value,
        this.dateTime,
        this.sensorName,
      });

  SensorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime = json['dateTime'];
    value = json['value'];
    sensorName = json['sensorName'];
  }


}
