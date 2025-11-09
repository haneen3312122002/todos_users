import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart remove_comments.dart /path/to/project');
    exit(1);
  }

  final rootPath = args[0];
  final rootDir = Directory(rootPath);

  if (!await rootDir.exists()) {
    print('Directory not found: $rootPath');
    exit(1);
  }

  print('Processing project at: $rootPath');

  await for (final entity
      in rootDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await _processDartFile(entity);
    }
  }

  print('Done.');
}

Future<void> _processDartFile(File file) async {
  final originalContent = await file.readAsString();
  final newContent = _removeLineComments(originalContent);

  if (newContent != originalContent) {
    await file.writeAsString(newContent);
    print('Updated: ${file.path}');
  }
}

String _removeLineComments(String content) {
  final buffer = StringBuffer();
  final lines = content.split('\n');

  for (final line in lines) {
    final trimmedLeft = line.trimLeft();
    final processedLine = _stripCommentFromLine(line);

    // سطر تعليق كامل يبدأ بـ //
    final isPureComment =
        trimmedLeft.startsWith('//') && processedLine.trim().isEmpty;

    if (!isPureComment) {
      buffer.writeln(processedLine);
    }
  }

  return buffer.toString();
}

/// يشيل التعليق اللي بـ نهاية السطر إذا كان يبدأ بـ //
/// ويحاول يتجنب إزالة // داخل سترنغ بسيط على نفس السطر.
String _stripCommentFromLine(String line) {
  bool inSingleQuotes = false; // '
  bool inDoubleQuotes = false; // "

  for (int i = 0; i < line.length - 1; i++) {
    final char = line[i];

    // تتبع إذا كنا داخل سترنغ بين ' '
    if (char == "'" && !inDoubleQuotes) {
      final prev = i > 0 ? line[i - 1] : '';
      if (prev != '\\') {
        inSingleQuotes = !inSingleQuotes;
      }
    }
    // تتبع إذا كنا داخل سترنغ بين " "
    else if (char == '"' && !inSingleQuotes) {
      final prev = i > 0 ? line[i - 1] : '';
      if (prev != '\\') {
        inDoubleQuotes = !inDoubleQuotes;
      }
    }

    // لقينا //
    if (!inSingleQuotes &&
        !inDoubleQuotes &&
        line[i] == '/' &&
        line[i + 1] == '/') {
      // نشيل كل شي من هون لآخر السطر (التعليق)
      final beforeComment = line.substring(0, i);
      // نشيل المسافات في نهاية السطر
      return beforeComment.replaceFirst(RegExp(r'\s+$'), '');
    }
  }

  // ما في تعليق // خارج سترنغ
  return line;
}
