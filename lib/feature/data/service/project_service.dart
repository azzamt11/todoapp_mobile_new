import 'package:chopper/chopper.dart';

part 'project_service.chopper.dart';

@ChopperApi(baseUrl: "/projects")
abstract class ProjectService extends ChopperService {

  @Get()
  Future<Response> getAllProjects({String? query});

  @Get(path: "/{title}")
  Future<Response> getProject(@Path("title") String title);

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
