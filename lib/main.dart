import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/controllers/todo_list_controller.dart';
import 'package:to_do_getx/pages/home_page.dart';
import 'package:to_do_getx/utils/Db.dart';
import 'package:to_do_getx/utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Db.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(
        () {
          Get.put(TodoListController());
        },
      ),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.homeRouter,
      getPages: [
        GetPage(
          name: AppRouter.homeRouter,
          page: () => HomePage(),
        ),
      ],
    );
  }
}
