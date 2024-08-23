import 'package:tacaro/shared/models/order_model.dart';

abstract class FeedRepository {
  Future<List<OrderModel>> getAll();
}
