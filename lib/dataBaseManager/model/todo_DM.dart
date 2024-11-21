class TodoDM{
  static const String collectionName = 'todo';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  TodoDM({required this.id, required this.title, required this.description, required this.dateTime, required this.isDone});
  TodoDM copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isDone,
  }) {
    return TodoDM(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toFireStore()=>{
    'id': id,
    'title': title,
    'description' : description,
    'dateTime' : dateTime,
    'isDone' : isDone,
  };

  TodoDM.fromFireStore(Map<String, dynamic> data): this(
    id : data['id'],
    title : data['title'],
    description : data['description'],
    dateTime : data['dateTime'].toDate(),
    isDone : data['isDone'],
  );
}