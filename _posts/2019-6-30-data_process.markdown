---
layout: post
title:  "data_process"
date:   2019-11-24 14:07:35 +0800
categories: commend
---

字符统计
```
# 判断中文字符
def is_chinese_char(char):
    cp = ord(char)
    """Checks whether CP is the codepoint of a CJK character."""
    # This defines a "chinese character" as anything in the CJK Unicode block:
    #   https://en.wikipedia.org/wiki/CJK_Unified_Ideographs_(Unicode_block)
    #
    # Note that the CJK Unicode block is NOT all Japanese and Korean characters,
    # despite its name. The modern Korean Hangul alphabet is a different block,
    # as is Japanese Hiragana and Katakana. Those alphabets are used to write
    # space-separated words, so they are not treated specially and handled
    # like the all of the other languages.
    if ((cp >= 0x4E00 and cp <= 0x9FFF) or  #
            (cp >= 0x3400 and cp <= 0x4DBF) or  #
            (cp >= 0x20000 and cp <= 0x2A6DF) or  #
            (cp >= 0x2A700 and cp <= 0x2B73F) or  #
            (cp >= 0x2B740 and cp <= 0x2B81F) or  #
            (cp >= 0x2B820 and cp <= 0x2CEAF) or
            (cp >= 0xF900 and cp <= 0xFAFF) or  #
            (cp >= 0x2F800 and cp <= 0x2FA1F)):  #
        return True

    return False
def is_chinese(s):
    chnum = 0
    ennum = 0
    for ch in s:
        if u'\u4e00' <= ch <= u'\u9fff':
            chnum += 1
        elif '\u0041' <= ch <= u'\u005a' or u'\u0061' <= ch <= u'\u007a':
            ennum += 1

    if chnum > 3 * ennum:
        return 1
    else:
        return 0


def is_english(s):
    chnum = 0
    ennum = 0
    for ch in s:
        if u'\u4e00' <= ch <= u'\u9fff':
            chnum += 1
        elif '\u0041' <= ch <= u'\u005a' or u'\u0061' <= ch <= u'\u007a':
            ennum += 1

    if 3 * chnum < ennum:
        return 1
    else:
        return 0

# 统计中文字符
def char_len(inp):
    cnt = 0
    for _ in inp:
        if is_chinese_char(_):
            cnt += 1
    return cnt


```

英文词性还原
```
from nltk.corpus import wordnet
from nltk import word_tokenize, pos_tag
from nltk.stem import WordNetLemmatizer


def get_wordnet_pos(treebank_tag):
    if treebank_tag.startswith('J'):
        return wordnet.ADJ
    elif treebank_tag.startswith('V'):
        return wordnet.VERB
    elif treebank_tag.startswith('N'):
        return wordnet.NOUN
    elif treebank_tag.startswith('R'):
        return wordnet.ADV
    else:
        return None


def lemmatize_sentence(sentence):
    res = []
    lemmatizer = WordNetLemmatizer()
    for word, pos in pos_tag(word_tokenize(sentence)):
        wordnet_pos = get_wordnet_pos(pos) or wordnet.NOUN
        res.append(lemmatizer.lemmatize(word, pos=wordnet_pos))
    return res

lemmatize_sentence("i am going to hairdresser school.")

```



创建文件夹
```
if not os.path.exists(path):
    os.makedirs(path)
```

遍历文件夹
```
import os
path = "./" #文件夹目录
files= os.listdir(path) #得到文件夹下的所有文件名称
with open("fout.txt","w")as fout:
    for file in files: #遍历文件夹
         if not os.path.isdir(file) and "txt" in file: #判断是否是文件夹，不是文件夹才打开
            with open(file,"r")as fin:
                pass

import os
#遍历文件夹   
def iter_files(rootDir):
    #遍历根目录
    for root,dirs,files in os.walk(rootDir):
        for file in files:
            file_name = os.path.join(root,file)
            print(file_name)

```
