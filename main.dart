import 'dart:io';
import 'dart:convert';

Future<List<String>> processDirectory(Directory dir) async {
  final results = <String>[];
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.contains("firebas") &&
        !entity.path.contains("freezed.dart") &&
        !entity.path.contains("cubit") &&
        !entity.path.contains("state") &&
        !entity.path.contains("date") &&
        !entity.path.contains(".g.dart")) {
      await processFile(entity, results);
    }
  }
  return results;
}

Future<void> processFile(File file, List<String> results) async {
  final content = await file.readAsString();
  final elements = <String>[];

  // Regex patterns to match text between quotes and braces
  final singleQuotePattern = RegExp(r"'(.*?)'");
  final doubleQuotePattern = RegExp(r'"(.*?)"');
  final bracePattern = RegExp(r'{(.*?)}');

  // Extract from single quotes
  singleQuotePattern.allMatches(content).forEach((match) {
    elements.add(match.group(1)!);
  });

  // Extract from double quotes
  doubleQuotePattern.allMatches(content).forEach((match) {
    elements.add(match.group(1)!);
  });

  // Extract from braces
  bracePattern.allMatches(content).forEach((match) {
    elements.add(match.group(1)!);
  });
  // Filter out elements that start with "package:", contain ",", "https:", or links, and also "super.", ".g.dart"
  elements.removeWhere((element) =>
      element.startsWith("package:") ||
      element.contains(",") ||
      element.contains("https:") ||
      element.contains("http:") ||
      element.contains("assets") ||
      element.contains("=====") ||
      element.contains("print") ||
      element.contains("page") ||
      element.contains("lIbelle") ||
      element.contains("Date") ||
      element.contains("super.") ||
      !element.isNotEmpty ||
      element.contains("freezed.dart") ||
      element.contains(".g.dart") ||
      element.contains(".") ||
      element.startsWith("dart:") ||
      element.contains("string") ||
      element.startsWith("required") ||
      element.contains("Error") ||
      element.startsWith("/"));

  if (elements.isNotEmpty) {
    results.addAll(elements);
  }
}

void main() async {
  final outputFile = File('text_elements_updated.json');

  // Process all .dart files in lib directory
  var scriptUri = Platform.script;

  // Convert the URI to a file path string
  var scriptPath = scriptUri
      .toFilePath(); // e.g., /Users/your_user/projects/my_dart_project/tool/my_script.dart

  // Get the directory containing the script
  var scriptDirectoryPath = Directory(scriptPath)
      .parent
      .path; // e.g., /Users/your_user/projects/my_dart_project/tool

  print('Script file is at: $scriptPath');
  print('Script directory is: $scriptDirectoryPath');
  print(
      'Parent of script directory is: ${Directory(scriptDirectoryPath).parent.path}'); // e.g., /Users/your_user/projects/my_dart_project

  // Example: Finding the 'lib' directory relative to the script's grandparent directory
  // (Assuming script is in project_root/tool/ and lib is in project_root/lib/)
  var projectRootPath = Directory(scriptDirectoryPath).parent.path;
  var libPath = '$projectRootPath/lib';
  print('Assumed lib path: $libPath');
  var results = await processDirectory(
    Directory('lib'),
  );

  // Write results to JSON file
  await outputFile.writeAsString(jsonEncode({'text_elements': results}));
  print('Text elements extracted to ${outputFile.path}');
}
