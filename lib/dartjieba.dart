import 'dart:ffi';

import 'package:ffi/ffi.dart';

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

class DartJieba {
  final String dylibPath;
  final String dictPath;
  final String modelPath;
  final String userDictPath;
  final String idfPath;
  final String stopWordsPath;
  DynamicLibrary _dylib;

  DartJieba(this.dylibPath, this.dictPath, this.modelPath, this.userDictPath,
      this.idfPath, this.stopWordsPath) {
    final _dictPath = Utf8.toUtf8(dictPath);
    final _modelPath = Utf8.toUtf8(modelPath);
    final _userDictPath = Utf8.toUtf8(userDictPath);
    final _idfPath = Utf8.toUtf8(idfPath);
    final _stopWordsPath = Utf8.toUtf8(stopWordsPath);

    _dylib = DynamicLibrary.open(dylibPath);

    final DartJiebaLoad nativeLoad =
        _dylib.lookup<NativeFunction<dartjieba_load>>('load').asFunction();

    nativeLoad(_dictPath, _modelPath, _userDictPath, _idfPath, _stopWordsPath);

    free(_dictPath);
    free(_modelPath);
    free(_userDictPath);
    free(_idfPath);
    free(_stopWordsPath);
  }

  List<String> cutSmall(String sentence, int maxWordLength) {
    final DartJiebaCutSmall nativeCutSmall = _dylib
        .lookup<NativeFunction<dartjieba_cut_small>>('cutSmall')
        .asFunction();

    final _sentence = Utf8.toUtf8(sentence);
    final _result = Utf8.fromUtf8(nativeCutSmall(_sentence, maxWordLength));

    free(_sentence);

    final _list = _result.split('/');

    return _list;
  }
}
