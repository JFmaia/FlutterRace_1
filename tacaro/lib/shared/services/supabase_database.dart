import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';
import 'package:tacaro/shared/services/app_database.dart';

class SupabaseDataBase implements AppDataBase {
  late final SupabaseClient client;

  SupabaseDataBase() {
    init();
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment("SUPABASEURL"),
      const String.fromEnvironment("SUPABASEKEY"),
    );
    if (!kReleaseMode) {
      // ignore: avoid_print
      print("Database inicializado");
      // ignore: avoid_print
      print("URL: ${client.supabaseUrl}, KEY: ${client.supabaseKey}");
    }
  }

  @override
  Future<bool> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await client.auth.signUp(email, password);
    return response.error == null;
  }

  @override
  Future<bool> login({required String email, required String password}) async {
    final response = await client.auth.signIn(email: email, password: password);
    return response.error == null;
  }
}
