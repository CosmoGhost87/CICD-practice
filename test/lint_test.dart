import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Test #1: linters check.
///
/// Runs `flutter analyze` over the whole project and fails if any issue
/// (error, warning or lint) is reported according to analysis_options.yaml.
void main() {
  test('project passes flutter analyze (no linter issues)', () async {
    final result = await Process.run(
      'flutter',
      ['analyze', '--no-pub', '--fatal-infos', '.'],
      workingDirectory: Directory.current.path,
    );

    if (result.exitCode != 0) {
      fail(
        'flutter analyze found issues:\n'
        '${const LineSplitter().convert(result.stdout.toString()).join('\n')}\n'
        '${result.stderr}',
      );
    }
  }, timeout: const Timeout(Duration(minutes: 5)),);
}
