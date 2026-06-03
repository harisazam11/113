import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class ItemService {
  static final _col = FirebaseFirestore.instance.collection('items');

  static Stream<List<Item>> streamAll({
    ItemType? type, String? category, String? query,
  }) {
    Query q = _col.orderBy('createdAt', descending: true);
    if (type != null) q = q.where('type', isEqualTo: type.name);
    if (category != null && category.isNotEmpty) {
      q = q.where('category', isEqualTo: category);
    }
    return q.snapshots().map((s) {
      var items = s.docs.map(Item.fromDoc).toList();
      if (query != null && query.trim().isNotEmpty) {
        final lower = query.toLowerCase();
        items = items.where((i) =>
          i.title.toLowerCase().contains(lower) ||
          i.description.toLowerCase().contains(lower) ||
          i.location.toLowerCase().contains(lower)).toList();
      }
      return items;
    });
  }

  static Stream<List<Item>> streamMine(String uid) =>
      _col.where('posterId', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((s) => s.docs.map(Item.fromDoc).toList());

  static Future<String> create(Item item) async {
    final ref = await _col.add(item.toMap());
    return ref.id;
  }

  static Future<void> update(String id, Map<String, dynamic> data) =>
      _col.doc(id).update(data);

  static Future<void> delete(String id) => _col.doc(id).delete();

  static Future<Item> fetch(String id) async =>
      Item.fromDoc(await _col.doc(id).get());

  static Future<({int lost, int found})> counts() async {
    final lost = await _col
        .where('type', isEqualTo: 'lost')
        .where('status', isEqualTo: 'active').count().get();
    final found = await _col
        .where('type', isEqualTo: 'found')
        .where('status', isEqualTo: 'active').count().get();
    return (lost: lost.count ?? 0, found: found.count ?? 0);
  }
}
