import 'package:chopper/chopper.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "/projects")
abstract class TaskService extends ChopperService {

  @Get(path: "/{projectId}/tasks{query}")
  Future<Response> getAllTasks({@Path("projectId") int? projectId, @Path("query") String query});

  @Get(path: "/{projectId}/tasks/{id}")
  Future<Response> getTask(@Path("projectId") int? projectId, @Path("id") int id);
  
  @Post(path: "/{projectId}/tasks")
  Future<Response> postTask(@Path("projectId") int? projectId);

  @Delete(path: "/{projectId}/tasks/{id}")
  Future<Response> deleteTask(@Path("projectId") int? projectId, @Path("id") int id);

  static TaskService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://fearless-enthusiasm-production.up.railway.app'),
        services: [
          _$TaskService(),
        ],
        converter:JsonConverter(),
        interceptors: [HttpLoggingInterceptor()],
        errorConverter: JsonConverter());
    return _$TaskService(client);
  }
}
