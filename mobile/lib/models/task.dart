class Task{
  final String title;
  final String description;
  final String skills;
  final int capacity;
  final int remainingCapacity;
  final String organisationId;
  final List<String> studentIds;

  Task({this.title, this.description, this.skills, this.capacity, this.remainingCapacity, this.organisationId, this.studentIds});

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      title: json['title'],
      description: json['description'],
      skills: json['skills'],
      capacity: json['capacity'],
      remainingCapacity: json['remainingCapacity'] ?? 0,
      organisationId: json['organisationId'] ?? "",
      studentIds: json["studentIds"] ?? [],
    );
  }

}