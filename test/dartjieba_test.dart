import 'package:dartjieba/dartjieba.dart';
import 'package:test/test.dart';

void main() {
  test('dartjieba do work', () async {
    final DartJieba jieba = DartJieba();
    await jieba.load();
    List<String> concreteValue = jieba.cutSmall('南京市长江大桥', 3);
    final List<String> expectValue = ["南京市", "长江", "大桥"];
    expect(expectValue, concreteValue);
  });
}
