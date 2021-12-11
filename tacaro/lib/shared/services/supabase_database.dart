import 'package:supabase/supabase.dart';
import 'package:tacaro/modules/models/user_model.dart';
import 'package:tacaro/shared/services/app_database.dart';

class SupabaseDataBase implements AppDataBase {
  late final SupabaseClient client;

  SupabaseDataBase() {
    init();
  }

  //Inicialização do banco de dados.
  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment("SUPABASEURL"),
      const String.fromEnvironment("SUPABASEKEY"),
    );
  }

  //Criando conta uma conta no supabase.
  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await client.auth.signUp(email, password);
    if (response.error != null) {
      final user = UserModel(
        email: email,
        id: response.user!.id,
        name: name,
      );
      await createUser(user);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possível criar conta");
    }
  }

  //Função que executa o login para entrada no app.
  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await client.auth.signIn(email: email, password: password);
    if (response.error != null) {
      final user = UserModel.fromMap(response.user!.toJson());
      return user;
    } else {
      throw Exception(
          response.error?.message ?? "Não foi possível fazer login!");
    }
  }

  //Função que cria um usuário no banco de dados do supabase.
  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.from("users").insert(user.toMap()).execute();
    if (response.error == null) {
      return user;
    } else {
      throw Exception("Não foi possível cadastrar o usuário.");
    }
  }

  //Função que busca um usuario especifico no banco de dados.
  @override
  Future<UserModel> getUser(String id) async {
    final response =
        await client.from("users").select().filter("id", "eq", id).execute();
    if (response.error == null) {
      final user = UserModel.fromMap(response.data);
      return user;
    } else {
      throw Exception("Não foi possível buscar o usuário.");
    }
  }
}
