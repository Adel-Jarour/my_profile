import 'package:get/get.dart';
import 'package:my_profile/view/screens/home/home_binding.dart';
import 'package:my_profile/view/screens/home/home_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = <GetPage>[
    GetPage<HomeBinding>(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
