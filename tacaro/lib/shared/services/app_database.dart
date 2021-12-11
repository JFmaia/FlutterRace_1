import 'package:tacaro/modules/models/user_model.dart';
import 'package:tacaro/shared/services/supabase_database.dart';

abstract class AppDataBase {
  static final AppDataBase instance = SupabaseDataBase();
  void init();
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String name,
  });
}
