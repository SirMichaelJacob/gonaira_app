class Service {
  String? id;
  String? title;
  String? description;

  Service({
    this.id,
    this.title,
    this.description,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        id: json['id'], title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    return map;
  }
}
