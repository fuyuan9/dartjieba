import 'dart:ffi';
import 'dart:async' show Future;
import 'dart:isolate' show Isolate;

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

/// Helper function for resolving to a non-relative, non-package URI.
Future<Uri> resolveUri(Uri uri) {
  if (uri.scheme == 'package') {
    return Isolate.resolvePackageUri(uri).then((resolvedUri) {
      if (resolvedUri == null) {
        throw ArgumentError.value(uri, 'uri', 'Unknown package');
      }
      return resolvedUri;
    });
  }
  return Future<Uri>.value(Uri.base.resolveUri(uri));
}

class DartJieba {
  String _dylibPath;
  String _dictPath;
  String _modelPath;
  String _userDictPath;
  String _idfPath;
  String _stopWordsPath;
  DynamicLibrary _dylib;

  Future<DartJieba> load({
    dylibPath,
    dictPath,
    modelPath,
    userDictPath,
    idfPath,
    stopWordsPath,
  }) async {
    if (dylibPath == null) {
      final Uri dylibUri =
          await resolveUri(Uri.parse('./dartjieba_library/libdartjieba.dylib'));
      this._dylibPath = dylibUri.path;
    } else {
      this._dylibPath = dylibPath;
    }
    print(this._dylibPath);

    if (dictPath == null) {
      final Uri dictUri = await resolveUri(
          Uri.parse('./dartjieba_library/dict/jieba.dict.utf8'));
      this._dictPath = dictUri.path;
    } else {}
    print(this._dictPath);

    if (modelPath == null) {
      final Uri modelUri = await resolveUri(
          Uri.parse('./dartjieba_library/dict/hmm_model.utf8'));
      this._modelPath = modelUri.path;
    } else {
      this._modelPath = modelPath;
    }
    print(this._modelPath);

    if (userDictPath == null) {
      final Uri userDictUri = await resolveUri(
          Uri.parse('./dartjieba_library/dict/user.dict.utf8'));
      this._userDictPath = userDictUri.path;
    } else {
      this._userDictPath = userDictPath;
    }
    print(this._userDictPath);

    if (idfPath == null) {
      final Uri idfUri =
          await resolveUri(Uri.parse('./dartjieba_library/dict/idf.utf8'));
      this._idfPath = idfUri.path;
    } else {
      this._idfPath = idfPath;
    }
    print(this._idfPath);

    if (stopWordsPath == null) {
      final Uri stopWordsUri = await resolveUri(
          Uri.parse('./dartjieba_library/dict/stop_words.utf8'));
      this._stopWordsPath = stopWordsUri.path;
    } else {
      this._stopWordsPath = stopWordsPath;
    }
    print(this._stopWordsPath);

    final dictPathPointer = Utf8.toUtf8(this._dictPath);
    final modelPathPointer = Utf8.toUtf8(this._modelPath);
    final userDictPathPointer = Utf8.toUtf8(this._userDictPath);
    final idfPathPointer = Utf8.toUtf8(this._idfPath);
    final stopWordsPathPointer = Utf8.toUtf8(this._stopWordsPath);

    this._dylib = DynamicLibrary.open(this._dylibPath);

    final DartJiebaLoad nativeLoad =
        _dylib.lookup<NativeFunction<dartjieba_load>>('load').asFunction();

    nativeLoad(dictPathPointer, modelPathPointer, userDictPathPointer,
        idfPathPointer, stopWordsPathPointer);

    free(dictPathPointer);
    free(modelPathPointer);
    free(userDictPathPointer);
    free(idfPathPointer);
    free(stopWordsPathPointer);

    return this;
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
