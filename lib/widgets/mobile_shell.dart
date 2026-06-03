// import 'package:flutter/material.dart';
// import '../screens/dashboard_screen.dart';
// import '../screens/browse_screen.dart';
// import '../screens/post_item_screen.dart';
// import '../screens/my_posts_screen.dart';
// import '../screens/profile_screen.dart';

// class MobileShell extends StatefulWidget {
//   const MobileShell({super.key});
//   @override
//   State<MobileShell> createState() => _MobileShellState();
// }

// class _MobileShellState extends State<MobileShell> {
//   int _index = 0;
//   final _pages = const [
//     DashboardScreen(), BrowseScreen(), SizedBox(), MyPostsScreen(), ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _index == 2 ? const SizedBox() : _pages[_index],
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => const PostItemScreen()),
//         ),
//         icon: const Icon(Icons.add),
//         label: const Text('Post'),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _navBtn(Icons.home, 'Home', 0),
//             _navBtn(Icons.search, 'Browse', 1),
//             const SizedBox(width: 40),
//             _navBtn(Icons.list_alt, 'My Posts', 3),
//             _navBtn(Icons.person, 'Profile', 4),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _navBtn(IconData icon, String label, int i) {
//     final selected = _index == i;
//     final color = selected ? Theme.of(context).colorScheme.primary : Colors.grey;
//     return InkWell(
//       onTap: () => setState(() => _index = i),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Icon(icon, color: color, size: 22),
//           Text(label, style: TextStyle(color: color, fontSize: 11)),
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/browse_screen.dart';
import '../screens/post_item_screen.dart';
import '../screens/my_posts_screen.dart';
import '../screens/profile_screen.dart';

class MobileShell extends StatefulWidget {
  const MobileShell({super.key});
  @override
  State<MobileShell> createState() => _MobileShellState();
}

class _MobileShellState extends State<MobileShell> {
  int _index = 0;
  final _pages = const [
    DashboardScreen(),
    BrowseScreen(),
    SizedBox(),
    MyPostsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _index == 2 ? const SizedBox() : _pages[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PostItemScreen()),
        ),
        backgroundColor: const Color(0xFF1A3A6E),
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBtn(
                  icon: Icons.home_rounded,
                  outlinedIcon: Icons.home_outlined,
                  label: 'Home',
                  index: 0,
                  current: _index,
                  onTap: () => setState(() => _index = 0)),
              _NavBtn(
                  icon: Icons.search_rounded,
                  outlinedIcon: Icons.search,
                  label: 'Browse',
                  index: 1,
                  current: _index,
                  onTap: () => setState(() => _index = 1)),
              const SizedBox(width: 48), // FAB gap
              _NavBtn(
                  icon: Icons.list_alt_rounded,
                  outlinedIcon: Icons.list_alt_outlined,
                  label: 'My Posts',
                  index: 3,
                  current: _index,
                  onTap: () => setState(() => _index = 3)),
              _NavBtn(
                  icon: Icons.person_rounded,
                  outlinedIcon: Icons.person_outline_rounded,
                  label: 'Profile',
                  index: 4,
                  current: _index,
                  onTap: () => setState(() => _index = 4)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final IconData outlinedIcon;
  final String label;
  final int index;
  final int current;
  final VoidCallback onTap;

  const _NavBtn({
    required this.icon,
    required this.outlinedIcon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = current == index;
    const activeColor = Color(0xFF1A3A6E);
    const inactiveColor = Color(0xFF94A3B8);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? icon : outlinedIcon,
              color: selected ? activeColor : inactiveColor,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: selected ? activeColor : inactiveColor,
                fontSize: 10,
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
