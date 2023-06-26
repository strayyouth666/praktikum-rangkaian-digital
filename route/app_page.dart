import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smartcare_web/medscreen/patient_screen.dart';
import '../praktikan_screen/home_screen.dart';
import '../medscreen/landing_screen.dart';
import '../praktikan_screen/login_screen.dart';

part 'app_route.dart';

class AppPage {
  AppPage._();
  static const initial = Route.login;

  static final route = [
    GetPage(
      name: _Paths.landing,
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: _Paths.patient,
      page: () => const PatientScreen(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
    ),
  ];
}
