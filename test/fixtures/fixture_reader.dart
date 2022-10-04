import 'dart:io';

String fixture(String name, [String folderName = 'auth']) =>
    File('test/fixtures/$folderName/$name.json').readAsStringSync();
