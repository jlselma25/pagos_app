



import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart' if(dart.library.html) 'web.dart';




  Future<void> createPDF() async {

    
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString('Welcome', 
    PdfStandardFont(PdfFontFamily.helvetica, 30));

    // page.graphics.drawImage(
    //   PdfBitmap(await readImageData('goku.jpg')), 
    //   const Rect.fromLTWH(0, 100, 440, 400)
    //   );

    List<int> bytes = await document.save() ;
    
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');


  }

  Future<Uint8List> readImageData(String name) async {

    final data = await rootBundle.load('assets/goku.jpg');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  }



  


