import 'package:notes_tasks/modules/auth/data/models/auth_model.dart';

abstract class ILoginApiService {
  Future<AuthModel> login({required String username, required String password});
}
