import 'package:chopper/chopper.dart';

part 'task_service.chopper.dart';

@ChopperApi(baseUrl: "/tasks")
abstract class TaskService extends ChopperService {

  @Get(path: "{query}")
  Future<Response> getAllTasks({@Path("query") String? query});

  @Get(path: "/{title}")
  Future<Response> getTask(@Path("title") String title);

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
