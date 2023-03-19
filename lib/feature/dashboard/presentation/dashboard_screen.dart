import 'package:flutter/material.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:planner_etp/feature/profile/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key, required this.userEntity}) : super(key: key);

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                )),
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: const Center(),
      // bottomNavigationBar: Container(
      //   color: const Color(0xff252525),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      //     child: GNav(
      //       backgroundColor: const Color(0xff252525),
      //       color: Colors.grey.shade700,
      //       activeColor: Colors.grey.shade700,
      //       tabBackgroundColor: Colors.grey.shade800,
      //       gap: 8,
      //       padding: const EdgeInsets.all(16),
      //       tabs: const [
      //         GButton(
      //           icon: Icons.insert_drive_file_rounded,
      //           iconColor: Color(0xff545454),
      //           iconActiveColor: Color(0xff0691db),
      //         ),
      //         GButton(
      //           icon: Icons.room,
      //           iconColor: Color(0xff545454),
      //           iconActiveColor: Color(0xff0691db),
      //         ),
      //         GButton(
      //           icon: Icons.assignment,
      //           iconColor: Color(0xff545454),
      //           iconActiveColor: Color(0xff0691db),
      //         ),
      //         GButton(
      //           icon: Icons.message_rounded,
      //           iconColor: Color(0xff545454),
      //           iconActiveColor: Color(0xff0691db),
      //         ),
      //         GButton(
      //           icon: Icons.account_circle,
      //           iconColor: Color(0xff545454),
      //           iconActiveColor: Color(0xff0691db),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
