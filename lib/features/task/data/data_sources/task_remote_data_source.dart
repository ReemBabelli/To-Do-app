import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/features/task/data/models/task_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../main.dart';

abstract class TaskRemoteDataSource {
  Future<Unit> addTask(TaskModel taskModel);

  Future<Unit> updateTask(TaskModel taskModel);

  Future<Unit> doTask(String taskId, bool isDone);

  Future<Unit> deleteTask(String taskId);

  Future<List<TaskModel>> getAllTasks(String categoryId);

  Future<List<TaskModel>> getTodayTasks(String userId);

  Future<int> countTasksEndedToday(String userId);

  Future<int> countTasksToday(String userId);

  Future<double> showTodayProductivity(String userId);

  Future<int> countTasksEndedThisMonth(String userId);

  Future<int> countTasksThisMonth(String userId);

  Future<double> showProductivityOfTheMonth(String userId);
}

class TaskRemoteDataSourceImp implements TaskRemoteDataSource {
  final databases = Databases(client);

  @override
  Future<Unit> addTask(TaskModel taskModel) async {
    try {
      await databases.createDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          documentId: ID.unique(),
          data: taskModel.toJson());
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteTask(String taskId) async {
    try {
      await databases.deleteDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          documentId: taskId);
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> updateTask(TaskModel taskModel) async {
    try {
      await databases.updateDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          documentId: taskModel.taskId!,
          data: taskModel.toJson());
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> doTask(String taskId, bool isDone) async {
    try {
      await databases.updateDocument(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          documentId: taskId,
          data: {'isDone': isDone});
      return unit;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks(String categoryId) async {
    try {
      DocumentList response = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [Query.equal('categoryId', categoryId)]);
      List<TaskModel> taskModels = response.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      if(taskModels[0].taskName != null)
      {
        return taskModels;
      }else{
        throw EmptyCacheException();
      }
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<List<TaskModel>> getTodayTasks(String userId) async {
    try {
      DocumentList response = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [
            Query.equal('userId', userId),
            Query.equal(
                'taskDate', DateFormat('yyyy-MM-dd').format(DateTime.now()))
          ]);
      List<TaskModel> taskModels = response.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      if(taskModels[0].taskName != null)
      {
        return taskModels;
      }else{
        throw EmptyCacheException();
      }
    } catch (e) {
      throw EmptyCacheException();
    }
  }

  @override
  Future<int> countTasksEndedToday(String userId) async {
    try {
      DocumentList done = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [
            Query.equal('userId', userId),
            Query.equal('isDone', true),
            Query.equal(
                'taskDate', DateFormat('yyyy-MM-dd').format(DateTime.now())),
          ]);
      List<TaskModel> doneList = done.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      int doneNum = doneList.length;
      return doneNum;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> countTasksToday(String userId) async {
    try {
      DocumentList tasks = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [
            Query.equal('userId', userId),
            Query.equal(
                'taskDate', DateFormat('yyyy-MM-dd').format(DateTime.now())),
          ]);
      List<TaskModel> tasksList = tasks.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      int tasksNum = tasksList.length;
      if (tasksNum > 0){
        return tasksNum;
      }
      return 1;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double> showTodayProductivity(String userId) async {
    try {
      double productivity =
          (await countTasksEndedToday(userId) / await countTasksToday(userId)) *
              100;
      String productivityStr =
          productivity.toStringAsFixed(1); //round one decimal point
      return double.parse(productivityStr);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> countTasksEndedThisMonth(String userId) async {
    try {
      DocumentList done = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [
            Query.equal('userId', userId),
            Query.equal('isDone', true),
            Query.startsWith(
                'taskDate', DateFormat('yyyy-MM').format(DateTime.now())),
          ]);
      List<TaskModel> doneList = done.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      int doneNum = doneList.length;
      return doneNum;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> countTasksThisMonth(String userId) async {
    try {
      DocumentList tasks = await databases.listDocuments(
          databaseId: '6526bcf9dc82afeb08da',
          collectionId: '6526bd3242068ea76f53',
          queries: [
            Query.equal('userId', userId),
            Query.startsWith(
                'taskDate', DateFormat('yyyy-MM').format(DateTime.now())),
          ]);
      List<TaskModel> tasksList = tasks.documents
          .map<TaskModel>((doc) => TaskModel.fromJson(doc.data, doc.$id))
          .toList();
      int tasksNum = tasksList.length;
      if(tasksNum > 0){
        return tasksNum;
      }
      return 1;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<double> showProductivityOfTheMonth(String userId) async {
    try {
      double productivity =
          (await countTasksEndedThisMonth(userId) / await countTasksThisMonth(userId)) *
              100;
      String productivityStr =
      productivity.toStringAsFixed(1); //round one decimal point
      return double.parse(productivityStr);
    } catch (e) {
      rethrow;
    }
  }
}
