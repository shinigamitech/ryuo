import 'dart:io';

import 'package:example/user.controller.dart';
import 'package:ryuo/ryuo.dart';

void main() {
  final c = UserController();

  Ryou()
    ..addController(c)
    ..listen(InternetAddress.anyIPv4, 8080).then<void>(
      (s) => print('Listenning on port ${s.port}'),
    );
}
