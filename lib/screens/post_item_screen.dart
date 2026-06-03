// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/item.dart';
// import '../services/item_service.dart';
// import '../services/storage_service.dart';

// class PostItemScreen extends StatefulWidget {
//   final Item? existing;
//   const PostItemScreen({super.key, this.existing});
//   @override
//   State<PostItemScreen> createState() => _PostItemScreenState();
// }

// class _PostItemScreenState extends State<PostItemScreen> {
//   final _title = TextEditingController();
//   final _desc = TextEditingController();
//   final _location = TextEditingController();
//   final _phone = TextEditingController();
//   ItemType _type = ItemType.lost;
//   String _category = kCategories.first;
//   DateTime _occurred = DateTime.now();
//   File? _image;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     final e = widget.existing;
//     if (e != null) {
//       _title.text = e.title; _desc.text = e.description;
//       _location.text = e.location; _phone.text = e.posterPhone ?? '';
//       _type = e.type; _category = e.category; _occurred = e.occurredAt;
//     }
//   }

//   Future<void> _pickImage(ImageSource src) async {
//     final f = await ImagePicker().pickImage(source: src, imageQuality: 70);
//     if (f != null) setState(() => _image = File(f.path));
//   }

//   Future<void> _submit() async {
//     final user = FirebaseAuth.instance.currentUser!;
//     setState(() => _loading = true);
//     try {
//       String? imageUrl = widget.existing?.imageUrl;
//       if (_image != null) {
//         imageUrl = await StorageService.uploadItemImage(user.uid, _image!);
//       }
//       if (widget.existing == null) {
//         final item = Item(
//           id: '', posterId: user.uid,
//           posterName: user.displayName ?? 'Student',
//           posterEmail: user.email ?? '',
//           posterPhone: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
//           title: _title.text.trim(), description: _desc.text.trim(),
//           category: _category, type: _type, status: ItemStatus.active,
//           location: _location.text.trim(), imageUrl: imageUrl,
//           createdAt: DateTime.now(), occurredAt: _occurred,
//         );
//         await ItemService.create(item);
//       } else {
//         await ItemService.update(widget.existing!.id, {
//           'title': _title.text.trim(),
//           'description': _desc.text.trim(),
//           'category': _category, 'type': _type.name,
//           'location': _location.text.trim(),
//           'posterPhone': _phone.text.trim().isEmpty ? null : _phone.text.trim(),
//           'occurredAt': _occurred,
//           if (imageUrl != null) 'imageUrl': imageUrl,
//         });
//       }
//       if (mounted) Navigator.pop(context);
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.existing == null ? 'Post item' : 'Edit item')),
//       body: ListView(padding: const EdgeInsets.all(16), children: [
//         SegmentedButton<ItemType>(
//           segments: const [
//             ButtonSegment(value: ItemType.lost, label: Text('Lost')),
//             ButtonSegment(value: ItemType.found, label: Text('Found')),
//           ],
//           selected: {_type},
//           onSelectionChanged: (s) => setState(() => _type = s.first),
//         ),
//         const SizedBox(height: 12),
//         TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title')),
//         const SizedBox(height: 12),
//         TextField(controller: _desc, maxLines: 3,
//             decoration: const InputDecoration(labelText: 'Description')),
//         const SizedBox(height: 12),
//         DropdownButtonFormField<String>(
//           initialValue: _category,
//           decoration: const InputDecoration(labelText: 'Category'),
//           items: kCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//           onChanged: (v) => setState(() => _category = v!),
//         ),
//         const SizedBox(height: 12),
//         TextField(controller: _location,
//             decoration: const InputDecoration(labelText: 'Location')),
//         const SizedBox(height: 12),
//         TextField(controller: _phone,
//             decoration: const InputDecoration(
//               labelText: 'Contact phone (optional, used for Call/WhatsApp)')),
//         const SizedBox(height: 12),
//         Row(children: [
//           Expanded(child: OutlinedButton.icon(
//             onPressed: () => _pickImage(ImageSource.camera),
//             icon: const Icon(Icons.camera_alt), label: const Text('Camera'))),
//           const SizedBox(width: 8),
//           Expanded(child: OutlinedButton.icon(
//             onPressed: () => _pickImage(ImageSource.gallery),
//             icon: const Icon(Icons.photo_library), label: const Text('Gallery'))),
//         ]),
//         if (_image != null) Padding(
//           padding: const EdgeInsets.only(top: 12),
//           child: ClipRRect(borderRadius: BorderRadius.circular(8),
//               child: Image.file(_image!, height: 160, fit: BoxFit.cover)),
//         ),
//         const SizedBox(height: 24),
//         ElevatedButton(
//           onPressed: _loading ? null : _submit,
//           child: _loading
//               ? const SizedBox(height: 20, width: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
//               : Text(widget.existing == null ? 'Post item' : 'Save changes'),
//         ),
//       ]),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../services/storage_service.dart';

class PostItemScreen extends StatefulWidget {
  final Item? existing;
  const PostItemScreen({super.key, this.existing});
  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _location = TextEditingController();
  final _phone = TextEditingController();
  ItemType _type = ItemType.lost;
  String _category = kCategories.first;
  DateTime _occurred = DateTime.now();
  File? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _title.text = e.title;
      _desc.text = e.description;
      _location.text = e.location;
      _phone.text = e.posterPhone ?? '';
      _type = e.type;
      _category = e.category;
      _occurred = e.occurredAt;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _location.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource src) async {
    final f = await ImagePicker()
        .pickImage(source: src, imageQuality: 70);
    if (f != null) setState(() => _image = File(f.path));
  }

  Future<void> _submit() async {
    final user = FirebaseAuth.instance.currentUser!;
    setState(() => _loading = true);
    try {
      String? imageUrl = widget.existing?.imageUrl;
      if (_image != null) {
        imageUrl =
            await StorageService.uploadItemImage(user.uid, _image!);
      }
      if (widget.existing == null) {
        final item = Item(
          id: '',
          posterId: user.uid,
          posterName: user.displayName ?? 'Student',
          posterEmail: user.email ?? '',
          posterPhone: _phone.text.trim().isEmpty
              ? null
              : _phone.text.trim(),
          title: _title.text.trim(),
          description: _desc.text.trim(),
          category: _category,
          type: _type,
          status: ItemStatus.active,
          location: _location.text.trim(),
          imageUrl: imageUrl,
          createdAt: DateTime.now(),
          occurredAt: _occurred,
        );
        await ItemService.create(item);
      } else {
        await ItemService.update(widget.existing!.id, {
          'title': _title.text.trim(),
          'description': _desc.text.trim(),
          'category': _category,
          'type': _type.name,
          'location': _location.text.trim(),
          'posterPhone': _phone.text.trim().isEmpty
              ? null
              : _phone.text.trim(),
          'occurredAt': _occurred,
          if (imageUrl != null) 'imageUrl': imageUrl,
        });
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A6E),
        title: Text(
          isEdit ? 'Edit item' : 'Post item',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 4),

          // Type toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: const Border.fromBorderSide(
                  BorderSide(color: Color(0xFFE2E8F0))),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(children: [
              _TypeBtn(
                label: 'Lost',
                selected: _type == ItemType.lost,
                color: const Color(0xFFEF4444),
                onTap: () => setState(() => _type = ItemType.lost),
              ),
              const SizedBox(width: 6),
              _TypeBtn(
                label: 'Found',
                selected: _type == ItemType.found,
                color: const Color(0xFF22C55E),
                onTap: () => setState(() => _type = ItemType.found),
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _SectionLabel('Item details'),
          const SizedBox(height: 8),
          _FormCard(children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon:
                      Icon(Icons.title_rounded, size: 20)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined, size: 20),
                  alignLabelWithHint: true),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon:
                      Icon(Icons.category_outlined, size: 20)),
              items: kCategories
                  .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
          ]),
          const SizedBox(height: 16),

          _SectionLabel('Location & contact'),
          const SizedBox(height: 8),
          _FormCard(children: [
            TextField(
              controller: _location,
              decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on_outlined, size: 20)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact phone (optional)',
                hintText: 'Used for Call / WhatsApp',
                prefixIcon: Icon(Icons.phone_outlined, size: 20),
              ),
            ),
          ]),
          const SizedBox(height: 16),

          _SectionLabel('Photo'),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: _PhotoButton(
                icon: Icons.camera_alt_outlined,
                label: 'Camera',
                onTap: () => _pickImage(ImageSource.camera),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _PhotoButton(
                icon: Icons.photo_library_outlined,
                label: 'Gallery',
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ),
          ]),
          if (_image != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.file(_image!,
                  height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : Text(isEdit ? 'Save changes' : 'Post item'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF94A3B8),
        letterSpacing: 0.8,
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final List<Widget> children;
  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(
            BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children),
    );
  }
}

class _TypeBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _TypeBtn({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF94A3B8),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PhotoButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: const Border.fromBorderSide(
              BorderSide(color: Color(0xFFE2E8F0))),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF1A3A6E), size: 26),
            const SizedBox(height: 6),
            Text(label,
                style: const TextStyle(
                  color: Color(0xFF1A3A6E),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}
