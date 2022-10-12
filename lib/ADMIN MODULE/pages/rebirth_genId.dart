import 'package:flutter/material.dart';

import '../widgets/userApp.dart';

class RebirthGenIdPage extends StatelessWidget {
  const RebirthGenIdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            child: const Text('Copy'),
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
                          border: TableBorder.all(color: Colors.black.withOpacity(0.1)),
                          dataRowColor: MaterialStateProperty.resolveWith((Set states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.grey;
                            }
                            return Colors.white; // Use the default value.
                          }),
                          checkboxHorizontalMargin: Checkbox.width,
                          columnSpacing: 50.0,
                          dividerThickness: 3,
                          showCheckboxColumn: true,
                          horizontalMargin: 50,
                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                          columns: [
                            DataColumn(
                                numeric: true,
                                onSort: (columnIndex, ascending) => const Text(''),
                                label: (const Text('SI.No'))),
                            const DataColumn(label: Text('User ID')),
                            const DataColumn(label: Text('Name')),
                            const DataColumn(label: Text('Mobile')),
                            const DataColumn(label: Text('Club')),
                            const DataColumn(label: Text('Id Type')),
                            const DataColumn(label: Text('User Panel')),
                            const DataColumn(label: Text('View')),
                          ],
                          rows: [
                            DataRow(
                                cells: [
                              DataCell(Container(width: 10,child: const Text('1'),)),
                              DataCell(Container(width: 100,child: const Text('GCR168783'),)),
                              DataCell(Container(width: 100,child: const Text('Manikandan'),)),
                              DataCell(Container(width: 120,child: const Text('8943004055'),)),
                              DataCell(Container(width:0,child: const Text('0'))),
                              DataCell(Container(width:100,child: const Text('Gen ID'))),
                              DataCell(Container(
                                  height: 30,
                                  width: 90,
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
                                      child: const Text('Goto Panel')))),
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
                                      child: const Text('View')))),
                            ]),
                          //   DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),
                          //   DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),DataRow(cells: [
                          //     DataCell(Text('1')),
                          //     DataCell(Text('GCR168783')),
                          //     DataCell(Text('17-07-2022')),
                          //     DataCell(Text('0')),
                          //     DataCell(Text('250')),
                          //     DataCell(Text('Rebirth ID')),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.red,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('Goto Panel')))),
                          //     DataCell(Container(
                          //         height: 30,
                          //         width: 90,
                          //         decoration: BoxDecoration(
                          //             color: Colors.yellow,
                          //             borderRadius: BorderRadius.circular(3),
                          //             border: Border.all(
                          //                 color: Colors.black.withOpacity(0.3))),
                          //         alignment: Alignment.center,
                          //         child: InkWell(
                          //             onTap: () => Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => UserApp(),
                          //                 )),
                          //             child: Text('View')))),
                          //   ]),
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
