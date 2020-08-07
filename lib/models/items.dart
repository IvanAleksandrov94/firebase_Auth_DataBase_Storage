class Item {
  String id;
  String name;
  String soName;
  int age;
  Item(this.id, this.name, this.soName, this.age);
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "soName": soName,
      "age": age,
    };
  }

  Item.fromsnapshot(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    soName = data["soName"];
    age = data["age"];
  }
}
