import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/catalog_seed.dart';
import '../../../domain/entities/athlete_index_result.dart';
import '../../../domain/entities/category_score.dart';
import '../../../domain/entities/cohort.dart';
import '../../../domain/entities/gender.dart';
import '../../../domain/entities/user_profile.dart';
import '../../history/application/history_controller.dart';

class _Labels {
  final bool ru;
  const _Labels(this.ru);
  String get title => ru ? 'Отчёт атлета' : 'Athlete report';
  String get generated => ru ? 'Сформирован' : 'Generated';
  String get cohort => ru ? 'Когорта' : 'Cohort';
  String get index => ru ? 'Индекс атлета' : 'Athlete Index';
  String get forecast => ru ? 'прогноз' : 'forecast';
  String get categories => ru ? 'Категории' : 'Categories';
  String get records => ru ? 'Личные рекорды' : 'Personal records';
  String get score => ru ? 'Балл' : 'Score';
  String get disclaimer => ru
      ? 'Приложение не заменяет медицинскую консультацию.'
      : 'The app does not replace medical advice.';
}

/// Формирует брендированный A4-отчёт: индекс, радар, категории, рекорды
/// (ТЗ разд. 4.15).
Future<Uint8List> buildAthleteReportPdf({
  required String languageCode,
  required UserProfile profile,
  required Cohort cohort,
  required AthleteIndexResult index,
  required Map<String, CategoryScore> categoryScores,
  required List<PersonalRecord> records,
  required DateTime now,
}) async {
  final ru = languageCode == 'ru';
  final l = _Labels(ru);
  final regular =
      pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
  final bold =
      pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'));
  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );

  final ordered = [...Catalog.categories]
    ..sort((a, b) => a.radarOrder.compareTo(b.radarOrder));
  final radarValues = [
    for (final c in ordered) categoryScores[c.slug]?.score ?? 0.0,
  ];

  String d(DateTime x) => '${x.day.toString().padLeft(2, '0')}.'
      '${x.month.toString().padLeft(2, '0')}.${x.year}';
  final genderLabel = switch (cohort.gender) {
    Gender.male => ru ? 'муж' : 'male',
    Gender.female => ru ? 'жен' : 'female',
    Gender.unspecified => ru ? 'н/у' : 'n/a',
  };

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(l.title,
                  style:
                      pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
              pw.Text('${l.generated}: ${d(now)}',
                  style: const pw.TextStyle(
                      fontSize: 10, color: PdfColors.grey700)),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text('${l.cohort}: $genderLabel, ${cohort.ageBracket.label}',
              style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
          pw.Divider(),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(l.index, style: const pw.TextStyle(fontSize: 12)),
                  pw.Text(index.value.round().toString(),
                      style: pw.TextStyle(
                          fontSize: 48, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                    '${index.level.label}'
                    '${index.isForecast ? ' · ${l.forecast} ${index.assessedCategories}/${index.totalCategories}' : ''}',
                    style: const pw.TextStyle(
                        fontSize: 12, color: PdfColors.blue800),
                  ),
                ],
              ),
              pw.Spacer(),
              _radar(radarValues),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text(l.categories,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 6),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            children: [
              for (final c in ordered)
                pw.TableRow(children: [
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(c.name.forLanguage(languageCode))),
                  pw.Padding(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Text(
                          categoryScores[c.slug] == null
                              ? '—'
                              : categoryScores[c.slug]!.score.round().toString(),
                          textAlign: pw.TextAlign.right)),
                ]),
            ],
          ),
          if (records.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            pw.Text(l.records,
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 6),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              children: [
                for (final r in records)
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                            Catalog.exerciseById(r.exerciseId)
                                    ?.name
                                    .forLanguage(languageCode) ??
                                r.exerciseId)),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(d(r.date))),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('${l.score}: ${r.score.round()}',
                            textAlign: pw.TextAlign.right)),
                  ]),
              ],
            ),
          ],
          pw.Spacer(),
          pw.Divider(),
          pw.Text(l.disclaimer,
              style:
                  const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
        ],
      ),
    ),
  );

  return doc.save();
}

/// Радар 8 качеств, нарисованный вручную в PDF (ТЗ разд. 2.2).
pw.Widget _radar(List<double> values) {
  const dim = 200.0;
  return pw.SizedBox(
    width: dim,
    height: dim,
    child: pw.CustomPaint(
      size: const PdfPoint(dim, dim),
      painter: (canvas, size) {
        final n = values.length;
        final cx = size.x / 2;
        final cy = size.y / 2;
        final radius = min(cx, cy) * 0.82;
        double ax(int i, double frac) =>
            cx + radius * frac * cos(-pi / 2 + 2 * pi * i / n);
        double ay(int i, double frac) =>
            cy + radius * frac * sin(-pi / 2 + 2 * pi * i / n);

        canvas
          ..setStrokeColor(PdfColors.grey400)
          ..setLineWidth(0.5);
        for (final frac in [0.25, 0.5, 0.75, 1.0]) {
          for (var i = 0; i < n; i++) {
            canvas.moveTo(ax(i, frac), ay(i, frac));
            canvas.lineTo(ax((i + 1) % n, frac), ay((i + 1) % n, frac));
          }
        }
        for (var i = 0; i < n; i++) {
          canvas.moveTo(cx, cy);
          canvas.lineTo(ax(i, 1), ay(i, 1));
        }
        canvas.strokePath();

        for (var i = 0; i < n; i++) {
          final frac = (values[i] / 100).clamp(0.0, 1.0);
          if (i == 0) {
            canvas.moveTo(ax(i, frac), ay(i, frac));
          } else {
            canvas.lineTo(ax(i, frac), ay(i, frac));
          }
        }
        canvas
          ..closePath()
          ..setFillColor(PdfColors.blue200)
          ..setStrokeColor(PdfColors.blue700)
          ..setLineWidth(1.5)
          ..fillAndStrokePath();
      },
    ),
  );
}
