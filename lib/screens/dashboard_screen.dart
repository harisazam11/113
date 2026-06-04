// import 'package:flutter/material.dart';
// import '../models/item.dart';
// import '../services/item_service.dart';
// import '../widgets/item_card.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: ListView(children: [
//         FutureBuilder(
//           future: ItemService.counts(),
//           builder: (context, snap) {
//             final lost = snap.data?.lost ?? 0;
//             final found = snap.data?.found ?? 0;
//             return Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(children: [
//                 _stat('Active Lost', lost, Colors.red),
//                 const SizedBox(width: 12),
//                 _stat('Active Found', found, Colors.green),
//               ]),
//             );
//           },
//         ),
//         const Padding(
//           padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
//           child: Text('Recent posts',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         ),
//         StreamBuilder<List<Item>>(
//           stream: ItemService.streamAll(),
//           builder: (context, snap) {
//             if (!snap.hasData) {
//               return const Padding(
//               padding: EdgeInsets.all(24),
//               child: Center(child: CircularProgressIndicator()));
//             }
//             final items = snap.data!.take(10).toList();
//             if (items.isEmpty) {
//               return const Padding(
//               padding: EdgeInsets.all(24),
//               child: Text('No posts yet.', textAlign: TextAlign.center));
//             }
//             return Column(children: items.map((i) => ItemCard(item: i)).toList());
//           },
//         ),
//         const SizedBox(height: 80),
//       ]),
//     );
//   }

//   Widget _stat(String label, int n, Color color) => Expanded(
//     child: Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(children: [
//           Text('$n', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
//           Text(label),
//         ]),
//       ),
//     ),
//   );
// }

// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import '../models/item.dart';
// // import '../services/item_service.dart';
// // import '../widgets/item_card.dart';
// // import 'browse_screen.dart';
// // import 'post_item_screen.dart';

// // const Color kNavy = Color(0xFF1B3A6B);
// // const Color kTeal = Color(0xFF0EA5A0);

// // class DashboardScreen extends StatelessWidget {
// //   const DashboardScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;
// //     final name = user?.displayName?.split(' ').first ?? 'Student';

// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF0F4F8),
// //       body: Column(
// //         children: [
// //           // Navy header
// //           Container(
// //             color: kNavy,
// //             padding: EdgeInsets.only(
// //               top: MediaQuery.of(context).padding.top + 16,
// //               left: 20, right: 20, bottom: 24,
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Hi, $name 👋',
// //                   style: const TextStyle(color: Colors.white70, fontSize: 14),
// //                 ),
// //                 const SizedBox(height: 4),
// //                 const Text(
// //                   "Find what's lost.\nReturn what's found.",
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.bold,
// //                     height: 1.3,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 16),
// //                 // Tappable search bar → Browse
// //                 GestureDetector(
// //                   onTap: () => Navigator.push(context,
// //                     MaterialPageRoute(builder: (_) => const BrowseScreen())),
// //                   child: Container(
// //                     height: 46,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withOpacity(0.15),
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: const Row(
// //                       children: [
// //                         SizedBox(width: 12),
// //                         Icon(Icons.search, color: Colors.white70, size: 20),
// //                         SizedBox(width: 8),
// //                         Text('Search items, locations...',
// //                             style: TextStyle(color: Colors.white60, fontSize: 14)),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView(
// //               children: [
// //                 // Stats row
// //                 FutureBuilder(
// //                   future: ItemService.counts(),
// //                   builder: (context, snap) {
// //                     final lost = snap.data?.lost ?? 0;
// //                     final found = snap.data?.found ?? 0;
// //                     return Padding(
// //                       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
// //                       child: Row(children: [
// //                         _statCard(context, 'Lost items', lost,
// //                           const Color(0xFFFFEBEB), const Color(0xFFE53935),
// //                           Icons.error_outline, ItemType.lost),
// //                         const SizedBox(width: 12),
// //                         _statCard(context, 'Found items', found,
// //                           const Color(0xFFE8F5E9), const Color(0xFF2E7D32),
// //                           Icons.check_circle_outline, ItemType.found),
// //                       ]),
// //                     );
// //                   },
// //                 ),
// //                 // Action cards
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
// //                   child: Row(children: [
// //                     _actionCard(context,
// //                       'Report lost', 'Something missing?',
// //                       Icons.inventory_2_outlined, kNavy, ItemType.lost),
// //                     const SizedBox(width: 12),
// //                     _actionCard(context,
// //                       'Post found', 'Help it get home',
// //                       Icons.inventory_outlined, kTeal, ItemType.found),
// //                   ]),
// //                 ),
// //                 // Recent posts header
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       const Text('Recent posts',
// //                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                       GestureDetector(
// //                         onTap: () => Navigator.push(context,
// //                           MaterialPageRoute(builder: (_) => const BrowseScreen())),
// //                         child: const Text('View all',
// //                           style: TextStyle(color: kNavy, fontSize: 14)),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 StreamBuilder<List<Item>>(
// //                   stream: ItemService.streamAll(),
// //                   builder: (context, snap) {
// //                     if (!snap.hasData) {
// //                       return const Padding(
// //                         padding: EdgeInsets.all(24),
// //                         child: Center(child: CircularProgressIndicator()));
// //                     }
// //                     final items = snap.data!.take(10).toList();
// //                     if (items.isEmpty) {
// //                       return _emptyState('No posts yet. Be the first!');
// //                     }
// //                     return Column(
// //                       children: items.map((i) => ItemCard(item: i)).toList());
// //                   },
// //                 ),
// //                 const SizedBox(height: 80),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _statCard(BuildContext context, String label, int count,
// //       Color bg, Color iconColor, IconData icon, ItemType type) =>
// //       Expanded(
// //         child: GestureDetector(
// //           onTap: () => Navigator.push(context,
// //             MaterialPageRoute(builder: (_) => BrowseScreen(initialType: type))),
// //           child: Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(16),
// //               border: Border.all(color: Colors.grey.shade100),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   width: 36, height: 36,
// //                   decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
// //                   child: Icon(icon, color: iconColor, size: 20),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 Text(label,
// //                   style: const TextStyle(fontSize: 13, color: Colors.grey)),
// //                 const SizedBox(height: 2),
// //                 Text('$count',
// //                   style: const TextStyle(
// //                     fontSize: 22, fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //           ),
// //         ),
// //       );

// //   Widget _actionCard(BuildContext context, String title, String subtitle,
// //       IconData icon, Color color, ItemType type) =>
// //       Expanded(
// //         child: GestureDetector(
// //           onTap: () => Navigator.push(context,
// //             MaterialPageRoute(
// //               builder: (_) => PostItemScreen(initialType: type))),
// //           child: Container(
// //             padding: const EdgeInsets.all(16),
// //             decoration: BoxDecoration(
// //               color: color,
// //               borderRadius: BorderRadius.circular(16),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Icon(icon, color: Colors.white, size: 28),
// //                 const SizedBox(height: 10),
// //                 Text(title,
// //                   style: const TextStyle(
// //                     color: Colors.white, fontSize: 15,
// //                     fontWeight: FontWeight.bold)),
// //                 const SizedBox(height: 2),
// //                 Text(subtitle,
// //                   style: const TextStyle(color: Colors.white70, fontSize: 12)),
// //               ],
// //             ),
// //           ),
// //         ),
// //       );

// //   Widget _emptyState(String message) => Container(
// //     margin: const EdgeInsets.symmetric(horizontal: 16),
// //     padding: const EdgeInsets.all(32),
// //     decoration: BoxDecoration(
// //       color: Colors.white,
// //       borderRadius: BorderRadius.circular(16),
// //       border: Border.all(color: Colors.grey.shade200),
// //     ),
// //     child: Column(children: [
// //       Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey[400]),
// //       const SizedBox(height: 12),
// //       Text(message,
// //         style: TextStyle(color: Colors.grey[500], fontSize: 14),
// //         textAlign: TextAlign.center),
// //     ]),
// //   );
// // }

import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../widgets/item_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        slivers: [
          // Custom SliverAppBar with gradient
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1A3A6E),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(20, 0, 16, 16),
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A3A6E), Color(0xFF2563EB)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 48, 20, 60),
                  child: Text(
                    'Welcome back 👋',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats cards
                FutureBuilder(
                  future: ItemService.counts(),
                  builder: (context, snap) {
                    final lost = snap.data?.lost ?? 0;
                    final found = snap.data?.found ?? 0;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: _StatCard(
                            label: 'Active Lost',
                            value: lost,
                            color: const Color(0xFFEF4444),
                            icon: Icons.search_off_rounded,
                            bgColor: const Color(0xFFFEF2F2),
                          )),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _StatCard(
                            label: 'Active Found',
                            value: found,
                            color: const Color(0xFF22C55E),
                            icon: Icons.check_circle_outline_rounded,
                            bgColor: const Color(0xFFF0FDF4),
                          )),
                        ],
                      ),
                    );
                  },
                ),

                // Section header
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 10),
                  child: Text(
                    'Recent posts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),

                // Items list
                StreamBuilder<List<Item>>(
                  stream: ItemService.streamAll(),
                  builder: (context, snap) {
                    if (!snap.hasData){
                      return const Padding(
                        padding: EdgeInsets.all(40),
                        child:
                            Center(child: CircularProgressIndicator()),
                      );
                    }
                    final items = snap.data!.take(10).toList();
                    if (items.isEmpty){
                      return const Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: Text(
                            'No posts yet.',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                        ),
                      );
                    }
                    return Column(
                        children: items.map((i) => ItemCard(item: i)).toList());
                  },
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final Color bgColor;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
