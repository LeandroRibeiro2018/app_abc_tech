// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//Criar classe assist
class Assist {
    int id;
    String title;
    String description;
  Assist({
    required this.id,
    required this.title,
    required this.description,
  });

  Assist copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Assist(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Assist.fromMap(Map<String, dynamic> map) {
    return Assist(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assist.fromJson(String source) => Assist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Assist(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant Assist other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
