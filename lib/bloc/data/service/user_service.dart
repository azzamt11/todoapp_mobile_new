import 'package:chopper/chopper.dart';
import 'package:code/bloc/data/model/user_details.dart';
part 'user_service.chopper.dart';

@ChopperApi(baseUrl: "/user")
abstract class UserService extends ChopperService {

  @Get()
  Future<Response> getAllUsers();

  @Get(path: "/{id}")
  Future<Response> getUserDetails(@Path("id") int id);

  static UserService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://649be9260480757192371c84.mockapi.io/test/v1/api'),
        services: [
          _$UserService(),
        ],
        converter:JsonConverter(),
        interceptors: [HttpLoggingInterceptor()],
        errorConverter: JsonConverter());
    return _$UserService(client);
  }
}
