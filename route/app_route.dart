part of 'app_page.dart';

abstract class Route {
  Route._();

  static const login = _Paths.login;
}

abstract class _Paths {
  static const landing = '/landing';
  static const patient = '/patient';
  static const login = '/login';
  static const home = '/home';

}