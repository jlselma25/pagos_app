



import 'package:flutter/services.dart';
import 'package:pagos_app/domains/entities/registro.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart' if(dart.library.html) 'web.dart';




  Future<void> createPDF(List<Registro> lstRegistros) async {

    
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString('pagos_app', 
    PdfStandardFont(PdfFontFamily.helvetica, 20));

    // page.graphics.drawImage(
    //   PdfBitmap(await readImageData('goku.jpg')), 
    //   const Rect.fromLTWH(0, 100, 440, 400)    
    //   );

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica,14),
      cellPadding: PdfPaddings(left:5,right: 2,top:2,bottom: 2));


    grid.columns.add(count: 3);
    grid.headers.add(1);
   
    PdfGridRow header = grid.headers[0];

    header.cells[0].value = 'Fecha';
    header.cells[1].value = 'Nombre';
    header.cells[2].value = 'Importe';

    // PdfGridRow row = grid.rows.add();
    //   row.cells[0].value = '1';
    //   row.cells[1].value = 'jose';
    //   row.cells[2].value = 34;

    for (int i = 0; i < lstRegistros.length; i++) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = lstRegistros[i].fecha;
      row.cells[1].value = lstRegistros[i].nombre;
      row.cells[2].value = lstRegistros[i].importe.toString();
      row.cells[2].style.backgroundBrush = PdfBrushes.aliceBlue;
    }   

    grid.draw(page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));


    List<int> bytes = await document.save() ;
    
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');


  }

  Future<Uint8List> readImageData(String name) async {

    final data = await rootBundle.load('assets/goku.jpg');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  }



  


