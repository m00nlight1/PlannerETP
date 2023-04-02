import 'package:injectable/injectable.dart';
import 'package:planner_etp/app/domain/app_api.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
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

  @override
  Future<TaskEntity> fetchTask(String id) async {
    try {
      final response = await appApi.fetchTask(id);
      return TaskEntity.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deleteTask(String id) async {
    try {
      await appApi.deleteTask(id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> updateTask(String id, Map args) async {
    try {
      final response = await appApi.updateTask(id, args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> sentMessage(Map args) async {
    try {
      final response = await appApi.sentMessage(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Iterable> getTaskChat(String id) async {
    try {
      final response = await appApi.getTaskChat(id);
      return response.data;
    } catch (_) {
      rethrow;
    }
  }
}
