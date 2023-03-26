abstract class TaskRepository {
  Future fetchTasks();

  Future createTask(Map args);
}
