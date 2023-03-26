import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/domain/app_api.dart';
import 'package:planner_etp/feature/tasks/domain/task_repository.dart';

@Injectable(as: TaskRepository)
class NetworkTaskRepository implements TaskRepository {
  final AppApi appApi;

  NetworkTaskRepository(this.appApi);

  @override
  Future<Iterable> fetchTasks() async {
    try {
      final response = await appApi.fetchTasks();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String> createTask(Map args) async {
    try {
      final response = await appApi.createTask(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }
}
