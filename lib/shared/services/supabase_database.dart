import 'package:supabase/supabase.dart';
import 'package:tacaro/shared/models/user_model.dart';
import 'package:tacaro/shared/services/app_database.dart';

class SupabaseDataBase implements AppDataBase {
  late final SupabaseClient client;

  SupabaseDataBase() {
    init();
  }
  final url = "https://osqcmhlnngsilsdyvcmp.supabase.co";
  final key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzOTI0MjM5MSwiZXhwIjoxOTU0ODE4MzkxfQ.Qb-Es3yMIt_GJrmm9BjwXLwGPqtDQN2P8qzTKr6tXDk";
  //Inicialização do banco de dados.
  @override
  void init() {
    client = SupabaseClient(
      url,
      key
    );
  }

  //Criando conta uma conta no supabase.
  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await client.auth.signUp(email, password);
    if (response.error == null) {
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
    if (response.error == null) {
      final user = await getUser(response.user!.id);
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
      final user = UserModel.fromMap(response.data[0]);
      return user;
    } else {
      throw Exception("Não foi possível buscar o usuário.");
    }
  }

  //Cria uma linha de produto no banco.
  @override
  Future<bool> create(
      {required String table, required Map<String, dynamic> data}) async {
    final response = await client.from(table).insert(data).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return true;
  }

  // Esse metodo busca no banco de dados todas as compras.
  @override
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final response =
        await client.from(table).select("*").order("created").execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return (response.data as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
