import 'package:flutter/material.dart';

import '../widgets/userApp.dart';

class PaymentRequestPage extends StatelessWidget {
  const PaymentRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Total Users',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total User',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child:const  Text('Copy'),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child: const Text('CSV'),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child: const Text('Excel'),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child: const Text('PDF'),
                          ),
                          const Spacer(),
                          const Text('Search'),
                          const SizedBox(width: 7),
                          Container(
                            height: 20,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: DataTable(
                        dataRowHeight: h*0.5,

                          border: TableBorder.all(color: Colors.black.withOpacity(0.1)),
                          dataRowColor: MaterialStateProperty.resolveWith((Set states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.grey;
                            }
                            return Colors.white; // Use the default value.
                          }),
                          checkboxHorizontalMargin: Checkbox.width,
                          columnSpacing: 50,
                          dividerThickness: 3,
                          showCheckboxColumn: true,
                          horizontalMargin: 50,
                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                          columns: [
                            DataColumn(
                                numeric: true,
                                onSort: (columnIndex, ascending) => const Text(''),
                                label: const Text('SI.No')),
                            const DataColumn(label: Text('User ID')),
                            const DataColumn(label: Text('Date')),
                            const DataColumn(label: Text('Proof')),
                            const DataColumn(label: Text('Transaction ID')),
                            const DataColumn(label: Text('Amount')),
                            const DataColumn(label: Text('Details')),
                            const DataColumn(label: Text('Send amount')),
                            const DataColumn(label: Text('Remove')),
                          ],
                          rows: [
                            DataRow(cells: [
                              const DataCell(Text('1')),
                              const DataCell(Text('GCR168783')),
                              const DataCell(Text('17-07-2022')),
                              DataCell(Container(
                                height:h*0.5,
                                width:w*0.2 ,
                                child: const Image(fit:BoxFit.fill,
                                    image: NetworkImage('https://miro.medium.com/max/1400/1*1LAC-yi-AB1txZ6Q4iYkAA.png'),),
                              )),
                              const DataCell(Text('250')),
                              const DataCell(Text('250')),
                              const DataCell(Text('sdfgh')),
                              DataCell(Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const UserApp(),
                                          )),
                                      child: const Text('View')))),
                              DataCell(Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const UserApp(),
                                          )),
                                      child: const Text('remove')))),
                            ]),
                          ]),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
