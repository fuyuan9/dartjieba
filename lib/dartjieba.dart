import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart';
import 'package:path/path.dart' show dirname, join;

typedef dartjieba_load = Void Function(
    Pointer<Utf8> dictPath,
    Pointer<Utf8> modelPath,
    Pointer<Utf8> userDictPath,
    Pointer<Utf8> idfPath,
    Pointer<Utf8> stopWordsPath);
typedef DartJiebaLoad = void Function(
    Pointer<Utf8> dictPath,
    Pointer<Utf8> modelPath,
    Pointer<Utf8> userDictPath,
    Pointer<Utf8> idfPath,
    Pointer<Utf8> stopWordsPath);

typedef dartjieba_cut_small = Pointer<Utf8> Function(
    Pointer<Utf8> sentence, Int32 maxWordLength);
typedef DartJiebaCutSmall = Pointer<Utf8> Function(
    Pointer<Utf8> sentence, int maxWordLength);

final basePath = Platform.script.path;
final dylibPath =
    join(dirname(basePath), '../dartjieba_library/libdartjieba.dylib');
final dylib = DynamicLibrary.open(dylibPath);
final DartJiebaLoad nativeLoad =
    dylib.lookup<NativeFunction<dartjieba_load>>('load').asFunction();
final DartJiebaCutSmall nativeCutSmall =
    dylib.lookup<NativeFunction<dartjieba_cut_small>>('cutSmall').asFunction();

class DartJieba {
  DartJieba() {
    final dictPath = Utf8.toUtf8(
        join(dirname(basePath), '../dartjieba_library/dict/jieba.dict.utf8'));
    final modelPath = Utf8.toUtf8(
        join(dirname(basePath), '../dartjieba_library/dict/hmm_model.utf8'));
    final userDictPath = Utf8.toUtf8(
        join(dirname(basePath), '../dartjieba_library/dict/user.dict.utf8'));
    final idfPath = Utf8.toUtf8(
        join(dirname(basePath), '../dartjieba_library/dict/idf.utf8'));
    final stopWordsPath = Utf8.toUtf8(
        join(dirname(basePath), '../dartjieba_library/dict/stop_words.utf8'));

    nativeLoad(dictPath, modelPath, userDictPath, idfPath, stopWordsPath);

    free(dictPath);
    free(modelPath);
    free(userDictPath);
    free(idfPath);
    free(stopWordsPath);
  }
  List<String> cutSmall(String sentence, int maxWordLength) {
    final _sentence = Utf8.toUtf8(sentence);
    final _result = Utf8.fromUtf8(nativeCutSmall(_sentence, maxWordLength));

    free(_sentence);

    final _list = _result.split('/');

    return _list;
  }
}

main() {
  List<String> value = DartJieba().cutSmall('南京市长江大桥', 3);
  print(value.join(', '));
}
