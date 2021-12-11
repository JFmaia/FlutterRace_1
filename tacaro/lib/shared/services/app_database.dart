import 'package:tacaro/shared/services/supabase_database.dart';

abstract class AppDataBase {
  static final AppDataBase instance = SupabaseDataBase();
  void init();
  Future<bool> login({required String email, required String password});
  Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
  });
}
