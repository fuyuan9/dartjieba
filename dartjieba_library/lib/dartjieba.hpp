#ifndef DARTJIBA_SRC_DARTJIBA_H
#define DARTJIBA_SRC_DARTJIBA_H

#include "cppjieba/Jieba.hpp"
#include "utils.hpp"

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
    const char *cutSmall(char *sentence, std::int32_t max_word_len);
    // void tag();
    // void extract();
    // void insertWord();

#ifdef __cplusplus
}
#endif

#endif // DARTJIBA_SRC_DARTJIBA_H