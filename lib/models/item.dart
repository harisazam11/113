import 'package:cloud_firestore/cloud_firestore.dart';

enum ItemType { lost, found }
enum ItemStatus { active, returned, closed }

const List<String> kCategories = [
  'Electronics', 'ID Card', 'Books', 'Bags', 'Clothing',
  'Keys', 'Wallet', 'Stationery', 'Accessories', 'Other',
];

class Item {
  final String id;
  final String posterId;
  final String posterName;
  final String posterEmail;
  final String? posterPhone;
  final String title;
  final String description;
  final String category;
  final ItemType type;
  final ItemStatus status;
  final String location;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime occurredAt;

  Item({
    required this.id,
    required this.posterId,
    required this.posterName,
    required this.posterEmail,
    this.posterPhone,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.status,
    required this.location,
    this.imageUrl,
    required this.createdAt,
    required this.occurredAt,
  });

  factory Item.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      posterId: d['posterId'] ?? '',
      posterName: d['posterName'] ?? '',
      posterEmail: d['posterEmail'] ?? '',
      posterPhone: d['posterPhone'],
      title: d['title'] ?? '',
      description: d['description'] ?? '',
      category: d['category'] ?? 'Other',
      type: ItemType.values.firstWhere((e) => e.name == (d['type'] ?? 'lost'),
          orElse: () => ItemType.lost),
      status: ItemStatus.values.firstWhere((e) => e.name == (d['status'] ?? 'active'),
          orElse: () => ItemStatus.active),
      location: d['location'] ?? '',
      imageUrl: d['imageUrl'],
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      occurredAt: (d['occurredAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'posterId': posterId,
        'posterName': posterName,
        'posterEmail': posterEmail,
        'posterPhone': posterPhone,
        'title': title,
        'description': description,
        'category': category,
        'type': type.name,
        'status': status.name,
        'location': location,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
        'occurredAt': Timestamp.fromDate(occurredAt),
      };
}
