// import 'package:flutter/material.dart';
// import '../models/item.dart';
// import '../services/item_service.dart';
// import '../widgets/item_card.dart';

// class BrowseScreen extends StatefulWidget {
//   const BrowseScreen({super.key});
//   @override
//   State<BrowseScreen> createState() => _BrowseScreenState();
// }

// class _BrowseScreenState extends State<BrowseScreen> {
//   ItemType? _type;
//   String? _category;
//   String _query = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Browse items')),
//       body: Column(children: [
//         Padding(
//           padding: const EdgeInsets.all(12),
//           child: TextField(
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.search), hintText: 'Search...'),
//             onChanged: (v) => setState(() => _query = v),
//           ),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(children: [
//             ChoiceChip(label: const Text('All'), selected: _type == null,
//               onSelected: (_) => setState(() => _type = null)),
//             const SizedBox(width: 6),
//             ChoiceChip(label: const Text('Lost'), selected: _type == ItemType.lost,
//               onSelected: (_) => setState(() => _type = ItemType.lost)),
//             const SizedBox(width: 6),
//             ChoiceChip(label: const Text('Found'), selected: _type == ItemType.found,
//               onSelected: (_) => setState(() => _type = ItemType.found)),
//             const SizedBox(width: 12),
//             DropdownButton<String?>(
//               value: _category, hint: const Text('Category'),
//               items: [const DropdownMenuItem(value: null, child: Text('All categories')),
//                 ...kCategories.map((c) =>
//                   DropdownMenuItem(value: c, child: Text(c)))],
//               onChanged: (v) => setState(() => _category = v),
//             ),
//           ]),
//         ),
//         Expanded(
//           child: StreamBuilder<List<Item>>(
//             stream: ItemService.streamAll(type: _type, category: _category, query: _query),
//             builder: (context, snap) {
//               if (!snap.hasData) return const Center(child: CircularProgressIndicator());
//               final items = snap.data!;
//               if (items.isEmpty) return const Center(child: Text('No items match.'));
//               return ListView.builder(
//                 padding: const EdgeInsets.only(bottom: 100),
//                 itemCount: items.length,
//                 itemBuilder: (_, i) => ItemCard(item: items[i]),
//               );
//             },
//           ),
//         ),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../widgets/item_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  ItemType? _type;
  String? _category;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF1A3A6E),
            title: const Text(
              'Browse items',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(64),
              child: Container(
                color: const Color(0xFF1A3A6E),
                padding:
                    const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14),
                    prefixIcon: Icon(Icons.search,
                        color: Colors.white.withValues(alpha: 0.7)),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.4)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _type == null,
                      onTap: () => setState(() => _type = null),
                      selectedColor: const Color(0xFF1A3A6E),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Lost',
                      selected: _type == ItemType.lost,
                      onTap: () => setState(() => _type = ItemType.lost),
                      selectedColor: const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Found',
                      selected: _type == ItemType.found,
                      onTap: () => setState(() => _type = ItemType.found),
                      selectedColor: const Color(0xFF22C55E),
                    ),
                    const SizedBox(width: 12),
                    _CategoryDropdown(
                      value: _category,
                      onChanged: (v) => setState(() => _category = v),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<List<Item>>(
            stream: ItemService.streamAll(
                type: _type, category: _category, query: _query),
            builder: (context, snap) {
              if (!snap.hasData){
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              }
              final items = snap.data!;
              if (items.isEmpty){
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 56, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        const Text(
                          'No items match',
                          style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => ItemCard(item: items[i]),
                    childCount: items.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? selectedColor : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? selectedColor
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF64748B),
            fontSize: 13,
            fontWeight:
                selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const _CategoryDropdown(
      {required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: const Border.fromBorderSide(
            BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: value,
          hint: const Text(
            'Category',
            style:
                TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF0F172A),
              fontFamily: 'Roboto'),
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          items: [
            const DropdownMenuItem(
                value: null,
                child: Text('All categories',
                    style: TextStyle(fontSize: 13))),
            ...kCategories.map((c) => DropdownMenuItem(
                value: c,
                child: Text(c, style: const TextStyle(fontSize: 13)))),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
