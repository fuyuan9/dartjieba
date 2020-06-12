#ifndef DARTJIBA_SRC_DARTJIBA_H
#define DARTJIBA_SRC_DARTJIBA_H

#include <string>
#include <vector>
#include "cppjieba/Jieba.hpp"

using namespace std;

#ifdef __cplusplus
extern "C"
{
#endif

    void load(char *dictPath,
              char *modelPath,
              char *userDictPath,
              char *idfPath,
              char *stopWordsPath);
    // void cut();
    // void cutAll();
    // void cutHMM();
    // void cutForSearch();
    char *cutSmall(char *sentence, std::int32_t max_word_len);
    // void tag();
    // void extract();
    // void insertWord();

#ifdef __cplusplus
}
#endif

#endif // DARTJIBA_SRC_DARTJIBA_H