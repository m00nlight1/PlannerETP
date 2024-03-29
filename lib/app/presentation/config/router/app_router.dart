import 'package:planner_etp/feature/auth/presentation/sign_up_screen.dart';
import 'package:planner_etp/feature/dashboard/presentation/dashboard_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_object_log/add_object_log_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_simple_task/add_simple_task_screen.dart';
import 'package:planner_etp/feature/tasks/presentation/tasks/category_supervision_order/add_supervision_order_screen.dart';

final routes = {
  '/sign-up': (context) => SignUpScreen(),
  '/object-log': (context) => const AddObjectLogScreen(),
  '/supervision-order': (context) => const AddSupervisionOrderScreen(),
  '/simple-task': (context) => const AddSimpleTaskScreen(),
  '/dashboard': (context) => const DashboardScreen()
};
