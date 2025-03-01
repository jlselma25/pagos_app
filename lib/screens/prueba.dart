import 'package:flutter/material.dart';

import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:provider/provider.dart';


class PruebaScreen extends StatelessWidget {
  const PruebaScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final authService = Provider.of<AuthService>(context, listen: false);
   


    return Scaffold(
     floatingActionButton: FloatingActionButton(
      onPressed: () async {

      final id = await  authService.getId();
      final token = await authService.getToken();
     
      

      showAlert2(context, id .toString() +'token ' +  token , 'Preuba');
      }
      )
      
      
     
        
    
    
    );
  }
}