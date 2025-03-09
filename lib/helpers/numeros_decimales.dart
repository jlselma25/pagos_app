

String numerosDecimalet(double importe){

  String newImporte ='';
  final split = importe.toString().split('.'); 
  if (split.isNotEmpty){
    if (split.length > 1){
        newImporte =  '${split[0]},${split[1].padRight(2,'0')}';
    }else{
      newImporte =  '$importe,00' ;
    }
     
  }else{
     newImporte =  '$importe,00' ;
  }
  
 

  return  newImporte;

}