
class RasberryModel {
  String? username;
  Owner? owner;
  int? id;
  String? name;
  dynamic description;
  dynamic license;
  bool? history;
  bool? enabled;
  String? visibility;
  dynamic unitType;
  dynamic unitSymbol;
  String? lastValue;
  String? createdAt;
  String? updatedAt;
  dynamic wipperPinInfo;
  bool? statusNotify;
  int? statusTimeout;
  String? status;
  String? key;
  Group? group;
  List<Groups>? groups;
  List<FeedStatusChanges>? feedStatusChanges;

  RasberryModel(
      {this.username,
        this.owner,
        this.id,
        this.name,
        this.description,
        this.license,
        this.history,
        this.enabled,
        this.visibility,
        this.unitType,
        this.unitSymbol,
        this.lastValue,
        this.createdAt,
        this.updatedAt,
        this.wipperPinInfo,
        this.statusNotify,
        this.statusTimeout,
        this.status,
        this.key,
        this.group,
        this.groups,
        this.feedStatusChanges});



  RasberryModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    id = json['id'];
    name = json['name'];
    description = json['description'];
    license = json['license'];
    history = json['history'];
    enabled = json['enabled'];
    visibility = json['visibility'];
    unitType = json['unit_type'];
    unitSymbol = json['unit_symbol'];
    lastValue = json['last_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wipperPinInfo = json['wipper_pin_info'];
    statusNotify = json['status_notify'];
    statusTimeout = json['status_timeout'];
    status = json['status'];
    key = json['key'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
    if (json['feed_status_changes'] != null) {
      feedStatusChanges = <FeedStatusChanges>[];
      json['feed_status_changes'].forEach((v) {
        feedStatusChanges!.add(new FeedStatusChanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['license'] = this.license;
    data['history'] = this.history;
    data['enabled'] = this.enabled;
    data['visibility'] = this.visibility;
    data['unit_type'] = this.unitType;
    data['unit_symbol'] = this.unitSymbol;
    data['last_value'] = this.lastValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['wipper_pin_info'] = this.wipperPinInfo;
    data['status_notify'] = this.statusNotify;
    data['status_timeout'] = this.statusTimeout;
    data['status'] = this.status;
    data['key'] = this.key;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    // if (this.groups != null) {
    //   data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    // }
    if (this.feedStatusChanges != null) {
      data['feed_status_changes'] =
          this.feedStatusChanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? username;

  Owner({this.id, this.username});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class Group {
  int? id;
  String? key;
  String? name;
  int? userId;

  Group({this.id, this.key, this.name, this.userId});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    return data;
  }
}

class FeedStatusChanges {
  String? createdAt;
  String? fromStatus;
  String? toStatus;
  Null? emailSent;
  Null? emailSentTo;

  FeedStatusChanges(
      {this.createdAt,
        this.fromStatus,
        this.toStatus,
        this.emailSent,
        this.emailSentTo});

  FeedStatusChanges.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    fromStatus = json['from_status'];
    toStatus = json['to_status'];
    emailSent = json['email_sent'];
    emailSentTo = json['email_sent_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['from_status'] = this.fromStatus;
    data['to_status'] = this.toStatus;
    data['email_sent'] = this.emailSent;
    data['email_sent_to'] = this.emailSentTo;
    return data;
  }
}
class Groups {
  int? id;
  String? key;
  String? name;
  int? user_id;

  Groups(
      {this.id,
        this.user_id,
        this.name,
        this.key,
  });
  Groups.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  user_id = json['user_id'];
  name = json['name'];
  key = json['key'];
  }


}

