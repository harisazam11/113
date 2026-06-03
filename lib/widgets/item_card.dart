// // import 'package:flutter/material.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:intl/intl.dart';
// // import '../models/item.dart';
// // import '../screens/item_detail_screen.dart';

// // class ItemCard extends StatelessWidget {
// //   final Item item;
// //   const ItemCard({super.key, required this.item});

// //   @override
// //   Widget build(BuildContext context) {
// //     final isLost = item.type == ItemType.lost;
// //     final badgeColor = isLost ? Colors.red : Colors.green;
// //     return Card(
// //       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //       child: InkWell(
// //         onTap: () => Navigator.of(context).push(MaterialPageRoute(
// //           builder: (_) => ItemDetailScreen(itemId: item.id),
// //         )),
// //         child: Padding(
// //           padding: const EdgeInsets.all(12),
// //           child: Row(children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: SizedBox(
// //                 width: 72, height: 72,
// //                 child: item.imageUrl != null
// //                     ? CachedNetworkImage(
// //                         imageUrl: item.imageUrl!, fit: BoxFit.cover,
// //                         placeholder: (_, __) => Container(color: Colors.grey[200]),
// //                         errorWidget: (_, __, ___) =>
// //                             const Icon(Icons.image_not_supported),
// //                       )
// //                     : Container(
// //                         color: Colors.grey[200],
// //                         child: const Icon(Icons.inventory_2_outlined),
// //                       ),
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //                 Row(children: [
// //                   Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
// //                     decoration: BoxDecoration(
// //                       color: badgeColor.withValues(alpha: .12),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Text(isLost ? 'LOST' : 'FOUND',
// //                         style: TextStyle(color: badgeColor, fontSize: 11,
// //                             fontWeight: FontWeight.bold)),
// //                   ),
// //                   const SizedBox(width: 6),
// //                   Text(item.category,
// //                       style: const TextStyle(fontSize: 11, color: Colors.grey)),
// //                 ]),
// //                 const SizedBox(height: 4),
// //                 Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(fontWeight: FontWeight.w600)),
// //                 const SizedBox(height: 2),
// //                 Text('${item.location} • ${DateFormat.MMMd().format(item.occurredAt)}',
// //                     style: const TextStyle(fontSize: 12, color: Colors.grey)),
// //               ]),
// //             ),
// //           ]),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:intl/intl.dart';
// import '../models/item.dart';
// import '../screens/item_detail_screen.dart';

// class ItemCard extends StatelessWidget {
//   final Item item;
//   const ItemCard({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final isLost = item.type == ItemType.lost;

//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => ItemDetailScreen(itemId: item.id),
//       )),
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade100),
//         ),
//         child: Row(
//           children: [
//             // Thumbnail
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 bottomLeft: Radius.circular(16),
//               ),
//               child: SizedBox(
//                 width: 90,
//                 height: 90,
//                 child: item.imageUrl != null
//                     ? CachedNetworkImage(
//                         imageUrl: item.imageUrl!,
//                         fit: BoxFit.cover,
//                         placeholder: (_, __) => _placeholder(isLost),
//                         errorWidget: (_, __, ___) => _placeholder(isLost),
//                       )
//                     : _placeholder(isLost),
//               ),
//             ),
//             // Content
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 3),
//                           decoration: BoxDecoration(
//                             color: isLost
//                                 ? const Color(0xFFFFEBEB)
//                                 : const Color(0xFFE8F5E9),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             isLost ? 'LOST' : 'FOUND',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w700,
//                               color: isLost
//                                   ? const Color(0xFFD32F2F)
//                                   : const Color(0xFF2E7D32),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             item.category,
//                             style: TextStyle(
//                                 fontSize: 11, color: Colors.grey[500]),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Text(
//                           DateFormat.MMMd().format(item.occurredAt),
//                           style: TextStyle(
//                               fontSize: 11, color: Colors.grey[400]),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       item.title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF1A1A2E),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on_outlined,
//                             size: 13, color: Colors.grey[400]),
//                         const SizedBox(width: 2),
//                         Expanded(
//                           child: Text(
//                             item.location,
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[500]),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: Icon(Icons.chevron_right,
//                   color: Colors.grey[300], size: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _placeholder(bool isLost) => Container(
//     color: isLost
//         ? const Color(0xFFFFF3F3)
//         : const Color(0xFFF0FFF4),
//     child: Icon(
//       Icons.inventory_2_outlined,
//       size: 32,
//       color: isLost
//           ? const Color(0xFFFFCDD2)
//           : const Color(0xFFA5D6A7),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';
import '../screens/item_detail_screen.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isLost = item.type == ItemType.lost;
    final badgeColor =
        isLost ? const Color(0xFFEF4444) : const Color(0xFF22C55E);
    final badgeBg = isLost
        ? const Color(0xFFFEF2F2)
        : const Color(0xFFF0FDF4);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(
            BorderSide(color: Color(0xFFE2E8F0))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ItemDetailScreen(itemId: item.id),
        )),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 76,
                height: 76,
                child: item.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: const Color(0xFFF1F5F9)),
                        errorWidget: (_, __, ___) => Container(
                          color: const Color(0xFFF1F5F9),
                          child: const Icon(Icons.image_not_supported_outlined,
                              color: Color(0xFF94A3B8)),
                        ),
                      )
                    : Container(
                        color: const Color(0xFFF1F5F9),
                        child: const Icon(Icons.inventory_2_outlined,
                            color: Color(0xFF94A3B8), size: 28),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isLost ? 'LOST' : 'FOUND',
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          item.category,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.location_on_outlined,
                          size: 13, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          '${item.location} • ${DateFormat.MMMd().format(item.occurredAt)}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: Color(0xFFCBD5E1), size: 20),
          ]),
        ),
      ),
    );
  }
}
