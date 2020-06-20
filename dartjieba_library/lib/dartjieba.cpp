#include "dartjieba.hpp"

cppjieba::Jieba *global_jieba_handle;

void load(
    char *dictPath,
    char *modelPath,
    char *userDictPath,
    char *idfPath,
    char *stopWordsPath)
{
    delete global_jieba_handle;
    global_jieba_handle = new cppjieba::Jieba(dictPath,
                                              modelPath,
                                              userDictPath,
                                              idfPath,
                                              stopWordsPath);
}

char *cut(char *sentence, bool hmm)
{
    vector<string> words;

    global_jieba_handle->Cut(sentence, words, hmm);

    string tmp_result = "TODO";

    return strdup(tmp_result.c_str());
}

char *cutAll(char *sentence)
{
    vector<string> words;

    global_jieba_handle->CutAll(sentence, words);

    string tmp_result = "TODO";

    return strdup(tmp_result.c_str());
}

char *cutForSearch(char *sentence, bool hmm)
{
    vector<string> words;

    global_jieba_handle->CutAll(sentence, words, hmm);

    string tmp_result = "TODO";

    return strdup(tmp_result.c_str());
}

char *cutHMM(char *sentence)
{
    vector<string> words;

    global_jieba_handle->CutHMM(sentence, words, hmm);

    string tmp_result = "TODO";
    return strdup(tmp_result.c_str());
}
    
char *cutSmall(char *sentence, int32_t max_word_len)
{
    // int32_t to size_t
    size_t len = (max_word_len < 0) ? __SIZE_MAX__ : (size_t)((unsigned)max_word_len);

    vector<string> words;

    global_jieba_handle->CutSmall(sentence, words, len);

    string tmp_result = limonp::Join(words.begin(), words.end(), "/");
    // cout << tmp_result << endl;

    return strdup(tmp_result.c_str());
}

char *tag(char *sentence)
{
    // vector<string> words;

    // global_jieba_handle->Tag(sentence, words, hmm);

    string tmp_result = "TODO";
    return strdup(tmp_result.c_str());
}