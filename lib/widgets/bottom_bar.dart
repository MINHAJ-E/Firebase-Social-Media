// import 'package:firebsesample/controller/bottom_provider.dart';
// import 'package:firebsesample/services/auth.dart';
// import 'package:firebsesample/view/search_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'your_provider_file.dart'; // Import the file where BottomProvider is defined

// class BottomBar extends StatelessWidget {
//   const BottomBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomProvider>(
//       builder: (context, provider, _) {
//         return Scaffold(
//           body: _pages[provider.selectedindex],
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: Colors.transparent,
//             currentIndex: provider.selectedindex,
//             type: BottomNavigationBarType.fixed,
//             onTap: (index) {
//               // Use the provider to update the selected index
//               context.read<BottomProvider>().pageNavigator(index);
//             },
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.home_filled), label: 'Home'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.search), label: 'Search'),
//               // BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Chart'),
//               // BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Stopwatch'),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// final List<Widget> _pages = [
//   const AuthPage(),
//   const SearchScreen(),
// ];
