import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:planner_etp/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:planner_etp/feature/profile/presentation/profile_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/chats/all_chats_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/documents/all_documents_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/all_tasks_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.userEntity}) : super(key: key);
  final UserEntity userEntity;

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();

}

class _DashboardScreenState extends State<DashboardScreen>{
  int _currentIndex = 0;

  final tabs = [
    const AllTasksScreen(),
    const AllDocumentsScreen(),
    const AllChatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        color: const Color(0xff252525),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xff252525),
            color: Colors.grey.shade700,
            activeColor: Colors.grey.shade700,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: const EdgeInsets.all(16),
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.assignment,
                iconColor: Color(0xff545454),
                iconActiveColor: Color(0xff0691db),
              ),
              GButton(
                icon: Icons.folder,
                iconColor: Color(0xff545454),
                iconActiveColor: Color(0xff0691db),
              ),
              GButton(
                icon: Icons.message,
                iconColor: Color(0xff545454),
                iconActiveColor: Color(0xff0691db),
              ),
              GButton(
                icon: Icons.account_circle,
                iconColor: Color(0xff545454),
                iconActiveColor: Color(0xff0691db),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
