import 'package:shelf_router/shelf_router.dart';

abstract class RyuoController {
  /// Registers the routes and handlers available in this [RyuoController] to
  /// the [router].
  void attachRoutes(Router router);
}
