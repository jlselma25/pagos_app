
import 'package:flutter/services.dart';
import 'package:pagos_app/domains/entities/registro.dart';
import 'package:pagos_app/helpers/numeros_decimales.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart' if(dart.library.html) 'web.dart';




  Future<void> createPDF(List<Registro> lstRegistros,String dateFrom, String dateTo) async {

    int y = 25;
    double yPosition = 20.0;
    PdfDocument document = PdfDocument();     
    PdfColor customColorHeader =  PdfColor(76, 127, 243);
    final page = document.pages.add();
    page.graphics.drawString('pagos_app', PdfStandardFont(PdfFontFamily.helvetica,  20),bounds:  Rect.fromLTWH(0, yPosition, 0, 0));
    yPosition += y;
    page.graphics.drawString('Listado de apuntes desde ${dateFrom.padLeft(10,'0')} hasta ${dateTo.padLeft(10,'0')}', PdfStandardFont(PdfFontFamily.helvetica,  20),bounds:  Rect.fromLTWH(0, yPosition, 0, 0));

   yPosition += y;

    // page.graphics.drawImage(
    //   PdfBitmap(await readImageData('goku.jpg')), 
    //   const Rect.fromLTWH(0, 100, 440, 400)    
    //   );

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica,14),              
      cellPadding: PdfPaddings(left:5,right: 2,top:2,bottom: 2));

   PdfGridCellStyle headerStyle = PdfGridCellStyle();
   headerStyle.borders.all = PdfPens.transparent;  
   headerStyle.textBrush = PdfBrushes.white ;
   headerStyle.backgroundBrush =  PdfSolidBrush(customColorHeader); 
 
    
    grid.columns.add(count: 3);
    grid.headers.add(1);
    
   
    PdfGridRow header = grid.headers[0];
 
    header.cells[0].value = 'Fecha';
    header.cells[0].style= headerStyle;
 
    header.cells[1].value = 'Concpeto';
    header.cells[1].style = headerStyle;
  //  header.cells[1].style.backgroundBrush =  PdfSolidBrush(customColorHeader);
   // header.cells[1].style.textBrush = PdfBrushes.white;
    header.cells[2].value = 'Importe';
    header.cells[2].style = headerStyle;

 for (int i = 0; i < lstRegistros.length; i++) {
    PdfGridRow row = grid.rows.add();      

    // Definir el color de fondo dependiendo de si la fila es par o impar
    PdfColor customColor = (i % 2 == 0) 
      ? PdfColor(206, 220, 251)  // Color azul claro para filas pares
      : PdfColor(249, 250, 253);  // Color blanco para filas impares

    // Establecer el estilo de cada celda por separado
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.backgroundBrush = PdfSolidBrush(customColor);  // Establecer el color de fondo para la celda
    cellStyle.textBrush = PdfBrushes.black;  // Establecer el color de texto (puedes cambiar esto si es necesario)

    // Asignar valores y estilos a cada celda individualmente
    row.cells[0].value = lstRegistros[i].fecha;
    row.cells[0].style = cellStyle;  // Asignar el estilo de la celda 0

    row.cells[1].value = lstRegistros[i].nombre;
    row.cells[1].style = cellStyle;  // Asignar el estilo de la celda 1

    row.cells[2].value =    numerosDecimalet(lstRegistros[i].importe).replaceAll('.',',').padLeft(10,' '); //lstRegistros[i].importe.toString().replaceAll('.',',').padLeft(10,' ');
    row.cells[2].style = cellStyle;  // Asignar el estilo de la celda 2

    // Establecer bordes personalizados para las celdas si es necesario
    row.cells[0].style.borders.top = PdfPens.transparent;  
    row.cells[0].style.borders.bottom = PdfPens.blue;
    row.cells[0].style.borders.left = PdfPens.blue;  
    row.cells[0].style.borders.right = PdfPens.transparent;

    row.cells[1].style.borders.top = PdfPens.transparent;
    row.cells[1].style.borders.bottom = PdfPens.transparent;
    row.cells[1].style.borders.left = PdfPens.transparent;  
    row.cells[1].style.borders.right = PdfPens.transparent;

    row.cells[2].style.borders.top = PdfPens.transparent;
    row.cells[2].style.borders.bottom = PdfPens.blue;
    row.cells[2].style.borders.left = PdfPens.transparent;  
    row.cells[2].style.borders.right = PdfPens.blue;
  }

    grid.draw(page: page, bounds: Rect.fromLTWH(0, yPosition + 10, 0, 0));


    List<int> bytes = await document.save() ;
    
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');


  }

  Future<Uint8List> readImageData(String name) async {

    final data = await rootBundle.load('assets/goku.jpg');

    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  }



  


