import 'dart:io';

import 'package:ryuo/src/framework/controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

class Ryou {
  Ryou._internal();

  /// Singleton [Ryou] object.
  factory Ryou() => _instance ??= Ryou._internal();

  final _router = Router();

  static Ryou? _instance;

  void addController(RyuoController controller) {
    controller.attachRoutes(_router);
  }

  Future<HttpServer> listen(
    Object address,
    int port, {
    SecurityContext? securityContext,
    List<Middleware> middlewares = const [],
    int backlog = 0,
    bool shared = false,
  }) async {
    var pipeline = Pipeline();
    for (final m in middlewares) {
      pipeline = pipeline.addMiddleware(m);
    }
    final handler = pipeline.addMiddleware(logRequests()).addHandler(_router);

    final server = await (securityContext == null
        ? HttpServer.bind(address, port, backlog: backlog, shared: shared)
        : HttpServer.bindSecure(
            address,
            port,
            securityContext,
            backlog: backlog,
            shared: shared,
          ));
    serveRequests(server, handler);
    return server;
  }
}
