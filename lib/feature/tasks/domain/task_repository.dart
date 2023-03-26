abstract class TaskRepository {
  Future fetchTasks();

  Future fetchTask(String id);

  Future createTask(Map args);
}
