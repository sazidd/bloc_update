import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class PostModel extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostModel copyWith({
    int userId,
    int id,
    String title,
    String body,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  @override
  List<Object> get props => [userId, id, title, body];
}
