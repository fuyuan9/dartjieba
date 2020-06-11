#include "dartjieba.hpp"

// const char *const DICT_PATH = "../dict/jieba.dict.utf8";
// const char *const HMM_PATH = "../dict/hmm_model.utf8";
// const char *const USER_DICT_PATH = "../dict/user.dict.utf8";
// const char *const IDF_PATH = "../dict/idf.utf8";
// const char *const STOP_WORD_PATH = "../dict/stop_words.utf8";

const char *const DICT_PATH = "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/jieba.dict.utf8";
const char *const HMM_PATH = "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/hmm_model.utf8";
const char *const USER_DICT_PATH = "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/user.dict.utf8";
const char *const IDF_PATH = "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/idf.utf8";
const char *const STOP_WORD_PATH = "/Users/kotafukuhara/Playgrounds/dartjieba/dartjieba_library/dict/stop_words.utf8";

cppjieba::Jieba *global_jieba_handle = new cppjieba::Jieba(DICT_PATH,
                                                           HMM_PATH,
                                                           USER_DICT_PATH,
                                                           IDF_PATH,
                                                           STOP_WORD_PATH);

// void cutSmall(const string &sentence, vector<string> &words, size_t max_word_len)
// {
//     global_jieba_handle->CutSmall(sentence, words, max_word_len);
//     cout << limonp::Join(words.begin(), words.end(), "/") << endl;
// }

void cutSmall()
{
    string sentence = "南京市长江大桥";
    vector<string> words;
    size_t max_word_len = 3;
    global_jieba_handle->CutSmall(sentence, words, max_word_len);
    cout << limonp::Join(words.begin(), words.end(), "/") << endl;

    // TODO: 引数を参照渡しではなくす
    // TODO: 配列として返す
}

// int main(int argc, char **argv)
// {
//     // string sentence = "南京市长江大桥";
//     // vector<string> words;
//     // size_t max_word_len = 3;
//     // cutSmall(sentence, words, max_word_len);
//     cutSmall();
//     return EXIT_SUCCESS;
// }
