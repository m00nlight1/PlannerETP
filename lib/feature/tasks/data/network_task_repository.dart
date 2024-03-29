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

  @override
  Future<Iterable> fetchStatuses() async {
    try {
      final response = await appApi.fetchStatuses();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Iterable> fetchTaskTypes() async {
    try {
      final response = await appApi.fetchTaskTypes();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Iterable> fetchIndustries() async {
    try {
      final response = await appApi.fetchIndustries();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String> createDocument(Map args) async {
    try {
      final response = await appApi.createDocument(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deleteDocument(String id) async {
    try {
      await appApi.deleteDocument(id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Iterable> fetchDocuments() async {
    try {
      final response = await appApi.fetchDocuments();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Iterable> fetchChats() async {
    try {
      final response = await appApi.fetchChats();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Iterable> fetchUsers() async {
    try {
      final response = await appApi.fetchUsers();
      return response.data;
    } catch (error) {
      rethrow;
    }
  }
}
