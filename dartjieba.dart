import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef dartjieba_load_func = Void Function(
    Pointer<Utf8> dictPath,
    Pointer<Utf8> modelPath,
    Pointer<Utf8> userDictPath,
    Pointer<Utf8> idfPath,
    Pointer<Utf8> stopWordsPath);
typedef DartJiebaLoadFunc = void Function(
    Pointer<Utf8> dictPath,
    Pointer<Utf8> modelPath,
    Pointer<Utf8> userDictPath,
    Pointer<Utf8> idfPath,
    Pointer<Utf8> stopWordsPath);

typedef dartjieba_cut_small_func = Pointer<Utf8> Function(
    Pointer<Utf8> sentence, Int32 maxWordLength);
typedef DartJiebaCutSmallFunc = Pointer<Utf8> Function(
    Pointer<Utf8> sentence, int maxWordLength);

main() {
  var path = "./dartjieba_library/libdartjieba.dylib";
  final dylib = DynamicLibrary.open(path);

  final DartJiebaLoadFunc dartJiebaLoadFunc =
      dylib.lookup<NativeFunction<dartjieba_load_func>>('load').asFunction();

  final Pointer<Utf8> dictPath = Utf8.toUtf8(
      "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/jieba.dict.utf8");
  final Pointer<Utf8> modelPath = Utf8.toUtf8(
      "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/hmm_model.utf8");
  final Pointer<Utf8> userDictPath = Utf8.toUtf8(
      "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/user.dict.utf8");
  final Pointer<Utf8> idfPath = Utf8.toUtf8(
      "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/idf.utf8");
  final Pointer<Utf8> stopWordsPath = Utf8.toUtf8(
      "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/stop_words.utf8");

  dartJiebaLoadFunc(dictPath, modelPath, userDictPath, idfPath, stopWordsPath);

  final DartJiebaCutSmallFunc dartJiebaCutSmallFunc = dylib
      .lookup<NativeFunction<dartjieba_cut_small_func>>('cutSmall')
      .asFunction();

  final Pointer<Utf8> sentence = Utf8.toUtf8("南京市长江大桥");
  final int maxWordLength = 3;
  final resultPointer = dartJiebaCutSmallFunc(sentence, maxWordLength);
  final result = Utf8.fromUtf8(resultPointer);
  print('$result');

  free(dictPath);
  free(modelPath);
  free(userDictPath);
  free(idfPath);
  free(stopWordsPath);
  free(sentence);
  // free(resultPointer);
}
