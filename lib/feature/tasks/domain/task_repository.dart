abstract class TaskRepository {
  Future fetchTasks();

  Future fetchTask(String id);

  Future deleteTask(String id);

  Future createTask(Map args);

  Future updateTask(String id, Map args);

  Future sentMessage(Map args);
}
