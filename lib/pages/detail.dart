import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makepdfs/models/invoice.dart';
import 'package:makepdfs/pages/pdfexport/pdf/pdfexport.dart';
import 'package:makepdfs/pages/pdfexport/pdfpreview.dart';
import 'package:printing/printing.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
class DetailPage extends StatelessWidget {
  final Invoice invoice;
  const DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => PdfPreviewPage(invoice: invoice),
        //       ),
        //     );
        //     // rootBundle.
        //   },
        //   child: Icon(Icons.picture_as_pdf),
        // ),
        appBar: AppBar(
          title: Text(invoice.name),
        ),
        body: 
        Stack(
          children: [ ListView(
            children: [
               
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'לקוח',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          invoice.customer,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        'פירוט העבודה ',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      ...invoice.items.map(
                        (e) => ListTile(
                          title: Text(e.description),
                          trailing: Text(
                            e.cost.toStringAsFixed(2),
                          ),
                        ),
                      ),
                      
                      DefaultTextStyle.merge(
                        style: Theme.of(context).textTheme.headline4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('סה"כ'),
                            Text(
                              invoice.totalCost().toStringAsFixed(2),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Container(child:TextField(),width: 70,),
                leading:Container(child:TextField(),width: 70,),
                trailing:Container(child:TextField(),width: 70,),
              ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed:() => {
                      
                  }, child: 
                  Column(children: [ Text("הוספת פירוט חדש"),Icon(Icons.add),],))
                ],
              ),                        
            ],
          ),
          
              
               Row(
                  
                  children: [
 
        Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        
          onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PdfPreviewPage(invoice: invoice),
                  ),
                );
                // rootBundle.
          },
          child: Icon(Icons.picture_as_pdf),
      ),
    ),
                ],),
         
          
          ],
          
        ),

                
      ),
    );
  }
}
