import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rand = Random();

  Future<void> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('task/$fileName').putFile(file);
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<String> downloadImage(String fileName) async {
    String downloadUrl = await storage.ref('task/$fileName').getDownloadURL();
    return downloadUrl;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));

  Future<Uint8List> generatePdf(TaskEntity taskEntity) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(taskEntity),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(taskEntity),
        buildInvoice(taskEntity),
        // Divider(),
        // buildTotal(invoice),
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    // pdf.addPage(
    //   Page(build: (context) {
    //     return Column(
    //       children: [],
    //     );
    //   }),
    // );

    return pdf.save();
  }

  static Widget buildHeader(TaskEntity taskEntity) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: taskEntity.title,
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     buildCustomerAddress(invoice.customer),
      //     buildInvoiceInfo(invoice.info),
      //   ],
      // ),
    ],
  );

  static Widget buildTitle(TaskEntity taskEntity) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text(taskEntity.title),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static Widget buildInvoice(TaskEntity taskEntity) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Начало работ: ${taskEntity.startOfWork.toString()}'),
    ],
  );
}
