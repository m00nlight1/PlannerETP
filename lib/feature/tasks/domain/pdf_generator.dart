import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:planner_etp/feature/tasks/domain/task/task_entity.dart';
import 'package:printing/printing.dart';

class PdfGenerator {
  String? logo;
  String? pdfPath;

  Future<Uint8List> generatePdf(TaskEntity taskEntity) async {
    final pdf = Document();

    final font = await PdfGoogleFonts.robotoCondensedRegular();
    final boldFont = await PdfGoogleFonts.robotoCondensedBold();

    logo = await rootBundle.loadString('assets/svg/etp-logo.svg');

    pdf.addPage(MultiPage(
      build: (context) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgImage(
                  svg: logo!,
                  height: 80,
                  width: 80,
                ),
                SizedBox(width: 20),
                Text('ЭКСПЕРТ\nТЕХНОЛОГИЯ\nПРОЕКТ',
                    style: TextStyle(
                        font: boldFont, color: PdfColor.fromHex('0d74ba'))),
              ],
            ),
            //qr
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Создано пользователем
            Row(
              children: [
                Text('Создано пользователем:',
                    style: TextStyle(font: boldFont)),
                SizedBox(width: 10),
                Text(
                    '${taskEntity.user?.username ?? ""} (${taskEntity.user?.email})',
                    style: TextStyle(font: font)),
              ],
            ),
            //от
            Row(
              children: [
                Text('от ', style: TextStyle(font: boldFont)),
                SizedBox(width: 10),
                Text(
                    '${taskEntity.createdAt.toString().split(" ")[0]} ${taskEntity.createdAt.hour}:${taskEntity.createdAt.minute}',
                    style: TextStyle(font: font)),
              ],
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Категория
                Row(
                  children: [
                    Text('Форма:', style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.category?.name ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Название
                Row(
                  children: [
                    Text('Заголовок:', style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.title, style: TextStyle(font: font)),
                  ],
                ),
                SizedBox(height: 0.5 * PdfPageFormat.cm),
                //Компания исполнитель
                Row(
                  children: [
                    Text(taskEntity.contractorCompany != null ? 'Компания исполнитель:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.contractorCompany ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Ответственный мастер
                Row(
                  children: [
                    Text(taskEntity.responsibleMaster != null ? 'Ответственный мастер:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.responsibleMaster ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Представитель
                Row(
                  children: [
                    Text(taskEntity.representative != null ?'Представитель:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.representative ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Уровень оснащения
                Row(
                  children: [
                    Text(taskEntity.equipmentLevel != null ? 'Уровень оснащения:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.equipmentLevel ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Уровень персонала
                Row(
                  children: [
                    Text(taskEntity.staffLevel != null ?'Уровень персонала:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.staffLevel ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Отрасль
                Row(
                  children: [
                    Text(taskEntity.industry != null ?'Отрасль:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.industry?.name ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Тип предписания
                Row(
                  children: [
                    Text(taskEntity.taskType != null ? 'Тип предписания:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.taskType?.name ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
                //Расходы
                Row(
                  children: [
                    Text(taskEntity.expenses != null ?'Расходы:' : "",
                        style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.expenses ?? "",
                        style: TextStyle(font: font)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Начало работ
                Row(
                  children: [
                    Text('Начало работ:', style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.startOfWork.toString().split(".")[0],
                        style: TextStyle(font: font)),
                  ],
                ),
                //Окончание работ
                Row(
                  children: [
                    Text('Окончание работ:', style: TextStyle(font: boldFont)),
                    SizedBox(width: 10),
                    Text(taskEntity.endOfWork.toString().split(".")[0],
                        style: TextStyle(font: font)),
                  ],
                ),
              ],
            ),
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Описание:', style: TextStyle(font: boldFont)),
            SizedBox(height: 10),
            Text(
              taskEntity.content ?? "",
              style: TextStyle(font: font),
            ),

          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskEntity.resultsOfTheWork != null ? 'Результаты работ:' : "", style: TextStyle(font: boldFont)),
            SizedBox(height: 10),
            Text(
              taskEntity.resultsOfTheWork ?? "",
              style: TextStyle(font: font),
            ),

          ],
        ),
      ],
    ));

    return pdf.save();
  }

}
