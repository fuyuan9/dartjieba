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

// void cut(){}
// void cutAll(){}
// void cutHMM(){}
// void cutForSearch(){}

const char *cutSmall(char *sentence, std::int32_t max_word_len)
{
    // uint32_t to size_t
    // size_t len = (max_word_len < 0) ? __SIZE_MAX__ : (size_t)((unsigned)max_word_len);
    size_t len = 3;

    std::vector<string> words;

    global_jieba_handle->CutSmall(sentence, words, len);

    std::string tmp_result = limonp::Join(words.begin(), words.end(), "/");
    cout << tmp_result << endl;

    return tmp_result.c_str();
}

// void tag(){}
// void extract(){}
// void insertWord(){}

// int main(){return 0;}
