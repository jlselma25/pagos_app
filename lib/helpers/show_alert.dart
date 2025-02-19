import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Future<void> showAlert(BuildContext context, String title, String subTitle) async{

    if (Platform.isAndroid){

        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(subTitle),
              actions: [
                MaterialButton(  
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)            
                  ),       
                  elevation: 5,
                  color:const Color(0xff615AAB),// Colors.blue,
                  onPressed:() =>  Navigator.of(context).pop('OK'),// Navigator.pop(context),
                  child: const Text('OK',style: TextStyle(color:Colors.white),),
                  )
              ],
             )
            
        );
    }
    else{

    showCupertinoDialog(
      context: context, 
      builder: (context) =>CupertinoAlertDialog(
              title: Text(title),
              content: Text(subTitle),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction:  true,
                  onPressed:() =>Navigator.pop(context),
                  child: const Text('OK')
                  )
              ],

      )
      
      );
    }



}

 Future<String?> showAlert2(BuildContext context, String message, String title) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          MaterialButton(  
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)            
                  ),       
                  elevation: 5,
                  color:const Color(0xff615AAB),// Colors.blue,
                  onPressed:() =>  Navigator.of(context).pop('OK'),// Navigator.pop(context),
                  child: const Text('OK',style: TextStyle(color:Colors.white),),
                  )
        ],
      ),
    );
  }