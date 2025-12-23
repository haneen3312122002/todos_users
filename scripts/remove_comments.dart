import 'dart:io';

void main() async {
  final projectDir = Directory.current;

  print('🔍 Cleaning comments in project: ${projectDir.path}');

  await for (final entity
      in projectDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await _cleanFile(entity);
    }
  }

  print('\n✅ Done! All // comments removed from .dart files.');
}

Future<void> _cleanFile(File file) async {
  final lines = await file.readAsLines();

  final cleanedLines = lines.map((line) {
    final trimmed = line.trimLeft();


    if (trimmed.startsWith('//')) {
      return '';
    }

    return line;
  }).toList();

  await file.writeAsString(cleanedLines.join('\n'));

  print('🧹 Cleaned: ${file.path}');
}