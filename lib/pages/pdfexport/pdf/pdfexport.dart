// import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart' as mt;
import 'package:path_provider/path_provider.dart';
import 'package:makepdfs/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show FontLoader, rootBundle;
write_String(String input){
return input.split('').reversed.join();
}

Future<Uint8List> makePdf(Invoice invoice) async {
  final pdf = Document();
// var custom = FontLoader('VarelaRound');
// custom.addFont(loadFont("assets/VarelaRound-Regular.ttf"));
 final font = await rootBundle.load("assets/varelaRoundregular.ttf");
    final ttf = Font.ttf(font);
    pdf.theme?.copyWith(defaultTextStyle: TextStyle(font: Font.ttf(font)));

// await custom.load();
  // const TextStyle(font: 'VarelaRound')
  final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  TextDirection? rtl=TextDirection.rtl as TextDirection?;
var input = "חליל דעיבס ";
  pdf.addPage(
    Page(
      pageTheme: PageTheme(

        textDirection: TextDirection.rtl, theme:  ThemeData.withFont(
          base: ttf,
          bold: ttf,
          italic: ttf,
          boldItalic: ttf,
          fontFallback: [ttf],
        ),
        pageFormat:PdfPageFormat.a4,

        ),
      //  theme: ThemeData.withFont(
      //     base: ttf,
      //   ),
      // textDirection: TextDirection.rtl,
      build: (context) {
        return 
        Directionality (
          textDirection: TextDirection.rtl,
          child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
               
                     Directionality ( child:Text(write_String("חליל דעיבס "),style: TextStyle(fontSize: 20,font: Font.ttf(font),fontWeight: FontWeight.normal, )), textDirection: TextDirection.rtl,),
                     Text(invoice.address),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    PaddedText('TAX', align: TextAlign.right),
                    PaddedText('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                TableRow(
                  children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')],
                )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text("Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),
                    PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                // style: TextStyle( font: )
              ),
            )
          ],
        )
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
