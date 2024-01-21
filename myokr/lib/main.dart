import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myokr/firebase_options.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_adapter.g.dart';
import 'package:myokr/model/local_storage/result_edit_hive_model/results_hive_model.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_adapter.g.dart';
import 'package:myokr/model/local_storage/result_hive_model/results_hive_model.dart';
import 'package:myokr/provider/firebase/add_objectives_provider.dart';
import 'package:myokr/provider/firebase/company_provider.dart';
import 'package:myokr/provider/firebase/department_provider.dart';
import 'package:myokr/provider/firebase/edit_objectives_provider.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/provider/firebase/period_provider.dart';
import 'package:myokr/provider/firebase/result_provider.dart';
import 'package:myokr/provider/firebase/user_provider.dart';
import 'package:myokr/provider/local_storage/edit_objectives.dart';
import 'package:myokr/provider/local_storage/raw_objectives.dart';
import 'package:myokr/provider/menu_provider.dart';
import 'package:myokr/provider/my_widget_provider.dart';
import 'package:myokr/provider/tab_control_manager_provider.dart';
import 'package:myokr/screen/add_okr/add_okr_screen.dart';
import 'package:myokr/screen/homepage.dart';
import 'package:myokr/screen/login_page/login_screen.dart';
import 'package:myokr/screen/manager_company/manager_company_screen.dart';
import 'package:myokr/screen/my_okr/my_okr_screen.dart';
import 'package:myokr/screen/register_page/register_screen.dart';
import 'package:myokr/service/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ResultsAdapter());
  Hive.registerAdapter(ResultsEditAdapter());
  await Hive.openBox<ResultsEditHiveModel>('resultsEdit');
  await Hive.openBox('objectiveEdit');
  await Hive.openBox<ResultsHiveModel>('results');
  await Hive.openBox('objective');
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
          ),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => AddOjectivesProvider()),
          ChangeNotifierProvider(create: (_) => AddRawObjectiveProvider()),
          ChangeNotifierProvider(create: (_) => PeriodProvider()),
          ChangeNotifierProvider(create: (_) => ObjectivesProvider()),
          ChangeNotifierProvider(create: (_) => ResultProvider()),
          ChangeNotifierProvider(create: (_) => EditObjectiveProvider()),
          ChangeNotifierProvider(create: (_) => MyWidgetProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => EditObjeciveRawProvider()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
          ChangeNotifierProvider(create: (_) => DepartmentProvider()),
          ChangeNotifierProvider(create: (_) => TabControlManager()),
          StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null,
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            // home: CategoriesScreen(),
            routes: {
              '/': (ctx) => LoginScreen(),
              MyOkrScreen.routeName: (ctx) => const MyOkrScreen(),
              AddOrkScreen.routeName: (ctx) => const AddOrkScreen(),
              RegisterScreen.routename:(context) => const RegisterScreen(),
            },
            onGenerateRoute: (settings) {
              print(settings.arguments);
              // return MaterialPageRoute(builder: (context) => CategoriesScreen());
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              );
            }));
  }
}
