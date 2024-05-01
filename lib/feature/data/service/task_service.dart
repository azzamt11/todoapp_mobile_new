import 'package:chopper/chopper.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "/projects")
abstract class TaskService extends ChopperService {

  @Get(path: "/{projectTitle}/tasks{query}")
  Future<Response> getAllTasks({@Path("projectTitle") String? projectTitle, @Path("query") String? query});

  @Get(path: "/{projectTitle}/tasks/{title}")
  Future<Response> getTask(@Path("projectTitle") String? projectTitle, @Path("title") String title);
  
  @Post(path: "/{projectTitle}/tasks")
  Future<Response> postTask(@Path("projectTitle") String? projectTitle);

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
