// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TaskService extends TaskService {
  _$TaskService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TaskService;

  @override
  Future<Response<dynamic>> getAllTasks({
    int? projectId,
    String? query,
  }) {
    final Uri $url = Uri.parse('/projects/${projectId}/tasks${query}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTask(
    int? projectId,
    int id,
  ) {
    final Uri $url = Uri.parse('/projects/${projectId}/tasks/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postTask(int? projectId, Map<String, dynamic> body) {
    final Uri $url = Uri.parse('/projects/${projectId}/tasks');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteTask(
    int? projectId,
    int id,
  ) {
    final Uri $url = Uri.parse('/projects/${projectId}/tasks/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
