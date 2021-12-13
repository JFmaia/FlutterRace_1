import 'package:tacaro/modules/create/repositories/create_repository.dart';
import 'package:tacaro/shared/services/app_database.dart';

class CreateRepositoryImpl implements CreateRepository {
  final AppDataBase database;
  CreateRepositoryImpl({
    required this.database,
  });

  //Pede ao banco de dados que crie um poduto no banco.
  @override
  Future<bool> create(
      {required String name,
      required String price,
      required String date}) async {
    final priceSanitize = double.parse(price.replaceAll("R\$", ""));
    final response = await database.create(table: "orders", data: {
      "name": name,
      "price": priceSanitize,
      "created": date,
    });
    return response;
  }
}
