import 'dart:ffi' as ffi;

typedef dartjieba_func = ffi.Void Function();
typedef DartJiebaFunc = void Function();

main() {
  var path = "./dartjieba_library/libdartjieba.dylib";
  final dylib = ffi.DynamicLibrary.open(path);
  final DartJiebaFunc cutSmall =
      dylib.lookup<ffi.NativeFunction<dartjieba_func>>('cutSmall').asFunction();
  cutSmall();
}
