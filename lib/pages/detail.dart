import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makepdfs/models/invoice.dart';
import 'package:makepdfs/pages/pdfexport/pdf/pdfexport.dart';
import 'package:makepdfs/pages/pdfexport/pdfpreview.dart';
import 'package:printing/printing.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

var  myservicenameController = TextEditingController();
var myservicecostController = TextEditingController();
var myservicedescriptionController = TextEditingController();
class DetailPage extends StatelessWidget {
  Invoice invoice;
  DetailPage({
    Key? key,
    required this.invoice,
  }) : super(key: key);
setState(invoice) {
  this.invoice=invoice;
return;
}
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
                          onTap:() {
                            List<LineItem> invoiceitems=invoice.get_items();
                            invoiceitems.remove(e);
                            invoice.set_items(invoiceitems);
                            setState(invoice);
                            (context as Element).reassemble();
                          },
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
            
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed:() => {
                  showDialog(
                     context:context,
                     builder: (BuildContext context) => _buildPopupDialog(context),)
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

  
  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                               (context as Element).reassemble();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(children: [
                                                Text("           שם:",
                                                  ),
                                          Container(child:TextField(controller: myservicenameController,decoration: new InputDecoration.collapsed(
    hintText: 'בניית גדר'
  ),),width: 70,)
                                              ])),
                                          Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(children: [
                                                Text("            תיאור:",
                                                    ),
                                      Container(
  decoration: const BoxDecoration(
    border: Border(
      top: BorderSide(color: Color(0xFFFFFFFF)),
      left: BorderSide(color: Color(0xFFFFFFFF)),
      right: BorderSide(),
      bottom: BorderSide(),
    ),
  ),
child:TextField(controller: myservicedescriptionController,decoration: new InputDecoration.collapsed(
    hintText: 'גדר בארוך 50 מטר'
  ),),width: 70,)
                                              ],
                                              ),
                                              ),
                                               Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(children: [
                                                Text("            עלות:",
                                                    ),
                                               Container(child:TextField(controller: myservicecostController,decoration: new InputDecoration.collapsed(
    hintText: '100.00'
  ),),width: 70,)
                                              ],),
                                      )],
                                      ),
                                    ],
                                  ),
                                ),
                               
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    child: Text("הוספת מפרט"),
                                    onPressed: () {
                                     List<LineItem> invoiceitems=invoice.get_items();
                                     invoiceitems.add(LineItem(myservicedescriptionController.text,
                                     double.parse(myservicecostController.text)));
                                     invoice.set_items(invoiceitems);
                                      setState(invoice);
                                      Navigator.of(context).pop;
                                      (context as Element).reassemble();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}
