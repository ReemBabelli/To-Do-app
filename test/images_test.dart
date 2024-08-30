import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.m1).existsSync(), isTrue);
    expect(File(Images.m10).existsSync(), isTrue);
    expect(File(Images.m11).existsSync(), isTrue);
    expect(File(Images.m12).existsSync(), isTrue);
    expect(File(Images.m13).existsSync(), isTrue);
    expect(File(Images.m14).existsSync(), isTrue);
    expect(File(Images.m15).existsSync(), isTrue);
    expect(File(Images.m16).existsSync(), isTrue);
    expect(File(Images.m17).existsSync(), isTrue);
    expect(File(Images.m18).existsSync(), isTrue);
    expect(File(Images.m19).existsSync(), isTrue);
    expect(File(Images.m2).existsSync(), isTrue);
    expect(File(Images.m20).existsSync(), isTrue);
    expect(File(Images.m21).existsSync(), isTrue);
    expect(File(Images.m22).existsSync(), isTrue);
    expect(File(Images.m23).existsSync(), isTrue);
    expect(File(Images.m24).existsSync(), isTrue);
    expect(File(Images.m25).existsSync(), isTrue);
    expect(File(Images.m3).existsSync(), isTrue);
    expect(File(Images.m4).existsSync(), isTrue);
    expect(File(Images.m5).existsSync(), isTrue);
    expect(File(Images.m6).existsSync(), isTrue);
    expect(File(Images.m7).existsSync(), isTrue);
    expect(File(Images.m8).existsSync(), isTrue);
    expect(File(Images.m9).existsSync(), isTrue);
  });
}
