abstract class TaskRepository {
  Future fetchTasks();

  Future fetchTask(String id);

  Future deleteTask(String id);

  Future createTask(Map args);
}
