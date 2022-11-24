// import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart' as mt;
import 'package:path_provider/path_provider.dart';
import 'package:makepdfs/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:intl/intl.dart'as ntl;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:locales/locales.dart'as lo;
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
  var oCcysymbol = ntl.NumberFormat.simpleCurrency(locale: 'iw_IL').currencySymbol;
  var oCcy =ntl.NumberFormat.currency(locale: 'iw_IL', name: "ISR", symbol:oCcysymbol, customPattern: "#,##0.00 "+oCcysymbol);
  // final oCcy = new ntl.NumberFormat("#,##0.00", "en_US");
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
                    Text(write_String("לכבוד "),style: TextStyle(fontSize: 14,font: Font.ttf(font),fontWeight: FontWeight.normal, )),
                     Directionality ( child:
                     Text(write_String(invoice.customer),style: TextStyle(fontSize: 14,font: Font.ttf(font),fontWeight: FontWeight.normal, )), textDirection: TextDirection.rtl,),
                     Text(write_String(invoice.address)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 250,
                  width: 300,
                  child: Image(imageLogo),
                )
              ],
            ),
                        
             Padding(
                      child:Column(children: [ 
                      //      Text(
                      //   write_String('א.ד דקדוקי התותחים לבנייה 2202'),
                      //   style: Theme.of(context).header4,
                      //   textAlign: TextAlign.center,
                      // ),
                        Text(
                        write_String('הצעת מחיר עבור עבודת בנייה/שיפוץ '),
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),],),
                      padding: EdgeInsets.all(20),
             
                    ),
          
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        write_String('הצעת מחיר '),
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                     Padding(
                      child: Text(
                        write_String('שלבי ביצוע '),
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
                        child: PaddedText(oCcy.format(e.cost),align: TextAlign.right),
                        flex: 1,
                      ) ,Expanded(
                        child: PaddedText( write_String(e.description),align: TextAlign.right),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                 
                TableRow(
                  children: [
                      PaddedText(oCcy.format((invoice.totalCost() * 0.1)),align: TextAlign.right),
                    PaddedText('מעמ', align: TextAlign.right),
                  
                  ],
                ),
                TableRow(
                  children: [PaddedText(oCcy.format((invoice.totalCost() * 1.1)),align: TextAlign.right)
                    ,PaddedText('סהכ', align: TextAlign.right), ],
                )
              ],
            ),
            // Padding(
            //   child: Text(
            //   write_String("תודה רבה לכם על האמונה בנו!"),
            //     style: Theme.of(context).header2,
            //   ),
            //   padding: EdgeInsets.all(20),
            // ),
             Container(height: 20),
            Text( write_String("נא לא להעביר את הצעת המחיר לאדם אחר או להשתמש בה ללא האישור של החברה")),
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
                     PaddedText(
                      invoice.phone,align: TextAlign.right
                    ),
                    PaddedText(write_String('מספר טלפון לקוח'),align: TextAlign.right),
                   
                  ],
                ),
                // TableRow(
                //   children: [
                //      PaddedText(
                //       'ADAM FAMILY TRUST',
                //     ),
                //     PaddedText(
                //       'Account Name',
                //     ),
                   
                //   ],
                // ),
                TableRow(
                  children: [
                   
                    PaddedText(oCcy.format((invoice.totalCost() * 1.1)),align: TextAlign.right),
                     PaddedText(
                      write_String('סה"כ לתשלום'),align: TextAlign.right
                    ),
                  ],
                )

              ],
            ),
             Container(height: 40),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText(write_String('חתימת מנכל חברה'),align: TextAlign.right),
                    PaddedText(write_String('חתימת לקוח'),align: TextAlign.right),
                   
                  ],
                ),
                
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                write_String('נא להקפיד על קריאת הצעת המחיר היטב ולשמור על הצעה זו.'),
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
