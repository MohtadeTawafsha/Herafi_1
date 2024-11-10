import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:herafi/global/constants.dart';
import 'package:herafi/presentation/pages/register_role.dart';
import 'package:herafi/presentation/routes/app_routes.dart';
import 'package:herafi/presentation/routes/initialPage.dart';
import 'package:herafi/presentation/themes/theme.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await supabase.Supabase.initialize(
    url: 'https://lnvastxceyhstrmvhgvo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxudmFzdHhjZXloc3RybXZoZ3ZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc2MDcyMjEsImV4cCI6MjA0MzE4MzIyMX0.DAK3TRleQoejxAJ5lWd_2TbdqhuBIYNfV5QRZLSvdBE',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    handleStatus();
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context,widget) {
        return GetMaterialApp(
          theme: themeData,
          debugShowCheckedModeBanner: false,
          locale: Locale("ar"),
          getPages: AppRoutes.pages,
          title: constants.appName,
          initialRoute: AppRoutes.waitingPage,
        );
      }
    );
  }

  void handleStatus(){
    CombineLatestStream.combine2<User?, List<ConnectivityResult>, List<dynamic>>(
      FirebaseAuth.instance.authStateChanges(),
      Connectivity().onConnectivityChanged,
          (User? user, List<ConnectivityResult> connectivity) {
        return [user, connectivity]; // This returns a list of the user and connectivity result.
      },
    ).listen(
          (snapshot){
        initialPage().handleInitialPage(snapshot);},
    );
  }
}
