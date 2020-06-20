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

    void load(char *dictPath, char *modelPath, char *userDictPath, char *idfPath, char *stopWordsPath);
    
    char *cut(char *sentence, bool hmm);
    
    char *cutAll(char *sentence);
    
    char *cutForSearch(char *sentence, bool hmm);
    
    char *cutHMM(char *sentence);
    
    char *cutSmall(char *sentence, int32_t max_word_len);

    char *tag(char *sentence);

#ifdef __cplusplus
}
#endif

#endif // DARTJIBA_SRC_DARTJIBA_H