class NoteModel {
  final String id;
  final String title;
  final String subtitle;
  final String createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.createdAt = '',
  });

  // Create a NoteModel instance from a Map (Firestore document)
  factory NoteModel.fromJson(Map<String, dynamic> json, String id) {
    return NoteModel(
      id: json['id'] ?? id,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now().toString(),
    );
  }


  // Convert a NoteModel instance to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'createdAt': createdAt,
    };
  }

  
}