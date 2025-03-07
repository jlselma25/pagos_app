

String numerosDecimalet(double importe){

  String newImporte ='';
  final split = importe.toString().split('.');

  if (split.length == 2){

     if ( split[1].length == 1 ){
        newImporte =  '${split[0]},${split[1].padRight(2,'0')}';
    }  

  }else{
      newImporte =  '${split[0]},${split[1].padRight(2,'0')}';
  }

  return  newImporte;

}