// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/item.dart';
// import '../services/item_service.dart';
// import '../widgets/item_card.dart';

// class MyPostsScreen extends StatelessWidget {
//   const MyPostsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     return Scaffold(
//       appBar: AppBar(title: const Text('My posts')),
//       body: StreamBuilder<List<Item>>(
//         stream: ItemService.streamMine(uid),
//         builder: (context, snap) {
//           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
//           final items = snap.data!;
//           if (items.isEmpty) return const Center(child: Text('You have no posts yet.'));
//           return ListView.builder(
//             padding: const EdgeInsets.only(bottom: 100),
//             itemCount: items.length,
//             itemBuilder: (_, i) => ItemCard(item: items[i]),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../widgets/item_card.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A6E),
        title: const Text(
          'My Posts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Item>>(
        stream: ItemService.streamMine(uid),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          final items = snap.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.post_add_rounded,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'You have no posts yet',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 100),
            itemCount: items.length,
            itemBuilder: (_, i) => ItemCard(item: items[i]),
          );
        },
      ),
    );
  }
}
