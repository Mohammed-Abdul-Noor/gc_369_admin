
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:universal_html/html.dart' as html;

import 'details.dart';

var format = NumberFormat.simpleCurrency(locale: 'en_in');
class GeneratePdf {
  static downloadPdf(List<Details> invoices) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        pw.Container(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Container(
                          width: 120,
                          child: pw.Text('369 Global Club',
                              style: pw.TextStyle(
                                fontSize: 15,
                              )),
                        ),
                      ]),

                  pw.SizedBox(height: 30),

                  pw.Table(

                      tableWidth: TableWidth.max,
                      border: pw.TableBorder.all(width: 1, color: PdfColors.grey),

                      children:invoices.map((invoice){
                        return  pw.TableRow(children: [
                          pw.Container(
                              height: 20,
                              child: pw.Text('')),
                          pw.Container(
                              height: 20,
                              child: pw.Text(invoice.userId)),
                          pw.Container(
                              height: 20,
                              child: pw.Text(invoice.name)),
                          pw.Container(
                              height: 20,
                              child: pw.Text(invoice.mobilenumber)),
                          pw.Container(
                              height: 20,
                              child: pw.Text(invoice.join_date.toString())),
                        ]);
                      }).toList(),
                //       pw.TableRow(children: [
                //   pw.Container(
                //       color: PdfColors.blue,
                //       height: 20,
                //       child: pw.Text('Sl.no',
                //           style: pw.TextStyle(color: PdfColors.white))),
                //   pw.Container(
                //       color: PdfColors.blue,
                //       height: 20,
                //       child: pw.Text('User ID',
                //           style: pw.TextStyle(color: PdfColors.white))),
                //   pw.Container(
                //       color: PdfColors.blue,
                //       height: 20,
                //       child: pw.Text('Name',
                //           style: pw.TextStyle(color: PdfColors.white,))),
                //   pw.Container(
                //       color: PdfColors.blue,
                //       height: 20,
                //       child: pw.Text('Mobile Number',
                //           style: pw.TextStyle(color: PdfColors.white))),
                //   pw.Container(
                //       color: PdfColors.blue,
                //       height: 20,
                //       child: pw.Text('Join Date',
                //           style: pw.TextStyle(color: PdfColors.white))),
                //
                // ]),
                  ),

                  // Text('your return from information indicate that you are in a credit position, your credit amount will be carried forward for next filing',style: TextStyle(fontSize: 9,)),
                  // pw.SizedBox(height: 10),
                ])),
      ],
    ));

    //WEB DOWNLOAD

    var data = await pdf.save();
    Uint8List bytes = Uint8List.fromList(data);
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '360 Global Club.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);

    //android
    // return PdfApi.saveDocument(name: '${invoice.name}+feedetail.pdf', pdf: pdf);
  }
}