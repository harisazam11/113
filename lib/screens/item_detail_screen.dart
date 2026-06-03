// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:intl/intl.dart';
// import '../models/item.dart';
// import '../services/item_service.dart';
// import 'post_item_screen.dart';

// class ItemDetailScreen extends StatelessWidget {
//   final String itemId;
//   const ItemDetailScreen({super.key, required this.itemId});

//   Future<void> _launch(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) await launchUrl(uri);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     return Scaffold(
//       appBar: AppBar(title: const Text('Item details')),
//       body: FutureBuilder<Item>(
//         future: ItemService.fetch(itemId),
//         builder: (context, snap) {
//           if (!snap.hasData) return const Center(child: CircularProgressIndicator());
//           final item = snap.data!;
//           final isOwner = item.posterId == uid;
//           return ListView(children: [
//             if (item.imageUrl != null) CachedNetworkImage(
//               imageUrl: item.imageUrl!, height: 240, fit: BoxFit.cover),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Row(children: [
//                   Chip(label: Text(item.type.name.toUpperCase()),
//                     backgroundColor: item.type == ItemType.lost
//                         ? Colors.red[50] : Colors.green[50]),
//                   const SizedBox(width: 6),
//                   Chip(label: Text('Status: ${item.status.name}')),
//                 ]),
//                 const SizedBox(height: 8),
//                 Text(item.title, style: const TextStyle(
//                   fontSize: 22, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Text('${item.category} • ${item.location}'),
//                 const SizedBox(height: 4),
//                 Text('When: ${DateFormat.yMMMd().format(item.occurredAt)}',
//                     style: const TextStyle(color: Colors.grey)),
//                 const Divider(height: 32),
//                 Text(item.description),
//                 const Divider(height: 32),
//                 Text('Posted by ${item.posterName}',
//                     style: const TextStyle(fontWeight: FontWeight.w600)),
//                 Text(item.posterEmail, style: const TextStyle(color: Colors.grey)),
//                 const SizedBox(height: 16),
//                 if (!isOwner) Wrap(spacing: 8, children: [
//                   if (item.posterPhone != null) ...[
//                     ElevatedButton.icon(
//                       onPressed: () => _launch('tel:${item.posterPhone}'),
//                       icon: const Icon(Icons.call), label: const Text('Call')),
//                     ElevatedButton.icon(
//                       onPressed: () => _launch(
//                         'https://wa.me/${item.posterPhone!.replaceAll(RegExp(r'[^0-9]'), '')}'),
//                       icon: const Icon(Icons.message), label: const Text('WhatsApp')),
//                   ],
//                   ElevatedButton.icon(
//                     onPressed: () => _launch('mailto:${item.posterEmail}'),
//                     icon: const Icon(Icons.email), label: const Text('Email')),
//                 ]),
//                 if (isOwner) Column(crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 8),
//                     OutlinedButton.icon(
//                       icon: const Icon(Icons.edit), label: const Text('Edit'),
//                       onPressed: () => Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (_) =>
//                             PostItemScreen(existing: item))),
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(spacing: 8, children: ItemStatus.values.map((s) =>
//                       ChoiceChip(
//                         label: Text(s.name),
//                         selected: item.status == s,
//                         onSelected: (_) async {
//                           await ItemService.update(item.id, {'status': s.name});
//                           if (context.mounted) Navigator.pop(context);
//                         },
//                       )).toList()),
//                     const SizedBox(height: 8),
//                     OutlinedButton.icon(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       label: const Text('Delete', style: TextStyle(color: Colors.red)),
//                       onPressed: () async {
//                         await ItemService.delete(item.id);
//                         if (context.mounted) Navigator.pop(context);
//                       },
//                     ),
//                   ]),
//               ]),
//             ),
//           ]);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import 'post_item_screen.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  const ItemDetailScreen({super.key, required this.itemId});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: FutureBuilder<Item>(
        future: ItemService.fetch(itemId),
        builder: (context, snap) {
          if (!snap.hasData)
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          final item = snap.data!;
          final isOwner = item.posterId == uid;
          final isLost = item.type == ItemType.lost;
          final typeColor =
              isLost ? const Color(0xFFEF4444) : const Color(0xFF22C55E);
          final typeBg =
              isLost ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: item.imageUrl != null ? 280 : 120,
                pinned: true,
                backgroundColor: const Color(0xFF1A3A6E),
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'Item details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                flexibleSpace: item.imageUrl != null
                    ? FlexibleSpaceBar(
                        background: CachedNetworkImage(
                          imageUrl: item.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                              color: const Color(0xFF1A3A6E)),
                          errorWidget: (_, __, ___) => Container(
                              color: const Color(0xFF1A3A6E),
                              child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.white38,
                                  size: 48)),
                        ),
                      )
                    : null,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badges row
                      Row(children: [
                        _Badge(
                          label: item.type.name.toUpperCase(),
                          color: typeColor,
                          bg: typeBg,
                        ),
                        const SizedBox(width: 8),
                        _Badge(
                          label: item.status.name,
                          color: const Color(0xFF64748B),
                          bg: const Color(0xFFF1F5F9),
                        ),
                      ]),
                      const SizedBox(height: 14),

                      // Title
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Meta info
                      _MetaRow(
                          icon: Icons.category_outlined,
                          text: item.category),
                      const SizedBox(height: 4),
                      _MetaRow(
                          icon: Icons.location_on_outlined,
                          text: item.location),
                      const SizedBox(height: 4),
                      _MetaRow(
                          icon: Icons.calendar_today_outlined,
                          text: DateFormat.yMMMd()
                              .format(item.occurredAt)),
                      const SizedBox(height: 20),

                      // Description
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: const Border.fromBorderSide(
                              BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        child: Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF334155),
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Poster info
                      const Text(
                        'POSTED BY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: const Border.fromBorderSide(
                              BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        child: Row(children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor:
                                const Color(0xFF1A3A6E).withOpacity(0.1),
                            child: const Icon(Icons.person_rounded,
                                color: Color(0xFF1A3A6E), size: 22),
                          ),
                          const SizedBox(width: 12),
                          Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.posterName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  item.posterEmail,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ]),
                        ]),
                      ),
                      const SizedBox(height: 20),

                      // Contact buttons (non-owner)
                      if (!isOwner && item.posterPhone != null ||
                          !isOwner) ...[
                        const Text(
                          'CONTACT',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (!isOwner)
                          Wrap(spacing: 10, runSpacing: 10, children: [
                            if (item.posterPhone != null) ...[
                              _ContactBtn(
                                icon: Icons.call_rounded,
                                label: 'Call',
                                color: const Color(0xFF22C55E),
                                bg: const Color(0xFFF0FDF4),
                                onTap: () =>
                                    _launch('tel:${item.posterPhone}'),
                              ),
                              _ContactBtn(
                                icon: Icons.message_rounded,
                                label: 'WhatsApp',
                                color: const Color(0xFF25D366),
                                bg: const Color(0xFFF0FDF4),
                                onTap: () => _launch(
                                    'https://wa.me/${item.posterPhone!.replaceAll(RegExp(r'[^0-9]'), '')}'),
                              ),
                            ],
                            _ContactBtn(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              color: const Color(0xFF1A3A6E),
                              bg: const Color(0xFFEFF6FF),
                              onTap: () => _launch(
                                  'mailto:${item.posterEmail}'),
                            ),
                          ]),
                        const SizedBox(height: 20),
                      ],

                      // Owner controls
                      if (isOwner) ...[
                        const Text(
                          'MANAGE POST',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Status chips
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: const Border.fromBorderSide(
                                BorderSide(color: Color(0xFFE2E8F0))),
                          ),
                          child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Change status',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                    spacing: 8,
                                    children: ItemStatus.values
                                        .map((s) => ChoiceChip(
                                              label: Text(s.name),
                                              selected: item.status == s,
                                              selectedColor:
                                                  const Color(0xFF1A3A6E),
                                              labelStyle: TextStyle(
                                                color: item.status == s
                                                    ? Colors.white
                                                    : const Color(
                                                        0xFF64748B),
                                                fontSize: 13,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                              onSelected: (_) async {
                                                await ItemService.update(
                                                    item.id,
                                                    {'status': s.name});
                                                if (context.mounted)
                                                  Navigator.pop(context);
                                              },
                                            ))
                                        .toList()),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 18),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1A3A6E),
                                side: const BorderSide(
                                    color: Color(0xFF1A3A6E)),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                                minimumSize:
                                    const Size.fromHeight(48),
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => PostItemScreen(
                                            existing: item)),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.delete_outline,
                                  size: 18),
                              label: const Text('Delete'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    const Color(0xFFEF4444),
                                side: const BorderSide(
                                    color: Color(0xFFEF4444)),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                                minimumSize:
                                    const Size.fromHeight(48),
                              ),
                              onPressed: () async {
                                await ItemService.delete(item.id);
                                if (context.mounted)
                                  Navigator.pop(context);
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(height: 40),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _Badge(
      {required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: color, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 15, color: const Color(0xFF94A3B8)),
      const SizedBox(width: 6),
      Flexible(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 13, color: Color(0xFF64748B)),
        ),
      ),
    ]);
  }
}

class _ContactBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _ContactBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ]),
      ),
    );
  }
}
