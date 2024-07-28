class ToDoModel {
  String name;
  bool isDone;
  ToDoModel({required this.name, required this.isDone});

  // to json
  Map<String, dynamic> toJson() => {"name": name, "isDone": isDone};

  // from json
  factory ToDoModel.fromJson(Map<String, dynamic> json) =>
      ToDoModel(name: json['name'], isDone: json['isDone']);
}
