import 'dart:convert';

import 'package:ryuo/ryuo.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserController implements RyuoController {
  Future<Response> greet(Request req) async {
    final name = req.params['name'];
    final text = 'Hello $name';
    return Response.ok(json.encode({'message': text}));
  }

  @override
  void attachRoutes(Router router) {
    router.get('/<name>', greet);
  }
}
