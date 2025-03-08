import 'package:flutter/material.dart';
import 'package:pagos_app/config/theme/app_theme.dart';
import 'package:pagos_app/routers/routes.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/services/local_storage.dart';
import 'package:pagos_app/services/registro_service.dart';
import 'package:pagos_app/services/statics._service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async{
  await LocalStorage.configurePrefs();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

       providers: [
        ChangeNotifierProvider(create: (_) => AuthService() ),
        ChangeNotifierProvider(create: (_) => RegistroService()),
        ChangeNotifierProvider(create: (_) => StaticsService())
        
      ],
      child: MaterialApp(
      
          theme: AppTheme().getTheme(),
           title: 'Pagos App',
           initialRoute: 'loading',
         
           routes: appRoutes,              
          // routerConfig: appRouterName,
           debugShowCheckedModeBanner: false,

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,           
      
          ],
      
         supportedLocales: const [
           Locale('es', ''), 
         
        ],
        
        ),
    );
    
  }
}
