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


    final isPureComment =
        trimmedLeft.startsWith('//') && processedLine.trim().isEmpty;

    if (!isPureComment) {
      buffer.writeln(processedLine);
    }
  }

  return buffer.toString();
}



String _stripCommentFromLine(String line) {
  bool inSingleQuotes = false; // '
  bool inDoubleQuotes = false; // "

  for (int i = 0; i < line.length - 1; i++) {
    final char = line[i];


    if (char == "'" && !inDoubleQuotes) {
      final prev = i > 0 ? line[i - 1] : '';
      if (prev != '\\') {
        inSingleQuotes = !inSingleQuotes;
      }
    }

    else if (char == '"' && !inSingleQuotes) {
      final prev = i > 0 ? line[i - 1] : '';
      if (prev != '\\') {
        inDoubleQuotes = !inDoubleQuotes;
      }
    }


    if (!inSingleQuotes &&
        !inDoubleQuotes &&
        line[i] == '/' &&
        line[i + 1] == '/') {

      final beforeComment = line.substring(0, i);

      return beforeComment.replaceFirst(RegExp(r'\s+$'), '');
    }
  }


  return line;
}