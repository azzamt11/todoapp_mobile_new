import 'package:chopper/chopper.dart';

part 'project_service.chopper.dart';

@ChopperApi(baseUrl: "/projects")
abstract class ProjectService extends ChopperService {

  @Get(path: "{query}")
  Future<Response> getAllProjects({@Path("query") String query});

  @Get(path: "/{id}")
  Future<Response> getProject(@Path("id") int id);

  static ProjectService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://fearless-enthusiasm-production.up.railway.app'),
        services: [
          _$ProjectService(),
        ],
        converter:JsonConverter(),
        interceptors: [HttpLoggingInterceptor()],
        errorConverter: JsonConverter());
    return _$ProjectService(client);
  }
}
