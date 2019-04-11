class Tag {
  int id;
  String name;
  int count;
  int type;
  bool ambiguous;

  Tag({this.id, this.name, this.count, this.type, this.ambiguous});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    type = json['type'];
    ambiguous = json['ambiguous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['type'] = this.type;
    data['ambiguous'] = this.ambiguous;
    return data;
  }
}