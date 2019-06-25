---
layout: post
title:  "trans_api"
date:   2019-11-24 14:07:35 +0800
categories: commend
---

翻译api
```
import re
import googletrans
import json
import md5
import urllib
import random
import time
import sys
import requests
import hashlib 
translator = googletrans.Translator()

def youdao_en2zh(line):

    appKey = '14d515da1b1ac44e'
    secretKey = 'ZO0OiH3x7oVJdOI4FV13poEiErDGAzBT'
    httpClient = None
    fromLang = 'EN'
    toLang = 'zh-CHS'
    begin = time.time()
    salt = random.randint(1, 65536)
    sign = appKey + line + str(salt) + secretKey
    m1 = md5.new()
    m1.update(sign)
    sign = m1.hexdigest()
    myurl = '/api' + '?appKey=' + appKey + '&q=' + urllib.quote(line) + '&from=' + fromLang + '&to=' + toLang + '&salt=' + str(
        salt) + '&sign=' + sign
    try:
        httpClient = httplib.HTTPConnection('openapi.youdao.com')
        httpClient.request('GET', myurl)

        # response是HTTPResponse对象
        response = httpClient.getresponse()
        # print "this is the youdao response:"
        strresponse = response.read()
        # print strresponse
        dictresponse = json.loads(strresponse)
        translation = dictresponse['translation']
        return translation[0]
#             outfile.write(translation[0]+'\n')
    except Exception, e:
        return ("error_youdao_api")

def youdao_zh2en(line):

    appKey = '14d515da1b1ac44e'
    secretKey = 'ZO0OiH3x7oVJdOI4FV13poEiErDGAzBT'
    httpClient = None
    fromLang = 'zh-CHS'
    toLang = 'EN'
    begin = time.time()
    salt = random.randint(1, 65536)
    sign = appKey + line + str(salt) + secretKey
    m1 = md5.new()
    m1.update(sign)
    sign = m1.hexdigest()
    myurl = '/api' + '?appKey=' + appKey + '&q=' + urllib.quote(line) + '&from=' + fromLang + '&to=' + toLang + '&salt=' + str(
        salt) + '&sign=' + sign
    try:
        httpClient = httplib.HTTPConnection('openapi.youdao.com')
        httpClient.request('GET', myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        # print "this is the youdao response:"
        strresponse = response.read()
        # print strresponse
        dictresponse = json.loads(strresponse)
        translation = dictresponse['translation']
        return translation[0]

    except Exception, e:
        return ("error_youdao_api")

def baidu_api_zh2en(line):
    appid = '20171123000098988'
    secretKey = '_zwrJHFwR8zlWITkaqBx'
    httpClient = None
    myurl = '/api/trans/vip/translate'
    q = ''
    fromLang = 'zh'
    toLang = 'en'
    salt = random.randint(32768, 65536)
    sign = appid + line + str(salt) + secretKey
    m1 = md5.new()
    m1.update(sign)
    sign = m1.hexdigest()
    myurl = myurl + '?appid=' + appid + '&q=' + urllib.quote(line) + '&from=' + fromLang + '&to=' + toLang + '&salt=' + str(salt) + '&sign=' + sign
    try:
        httpClient = httplib.HTTPConnection('api.fanyi.baidu.com')
        httpClient.request('GET', myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        strresponse = response.read()
        # print strresponse
        dictresponse = json.loads(strresponse)
        translation = dictresponse['trans_result']
        return_line = ""
        for single in translation:
            return_line += single['dst']+"\n"
        return return_line
    except Exception, e:
        return "error_with_baidu_api"

def baidu_api_en2zh(line):
    appid = '20171123000098988'
    secretKey = '_zwrJHFwR8zlWITkaqBx'
    httpClient = None
    myurl = '/api/trans/vip/translate'
    q = ''
    fromLang = 'en'
    toLang = 'zh'
    salt = random.randint(32768, 65536)
    sign = appid + line + str(salt) + secretKey
    m1 = md5.new()
    m1.update(sign)
    sign = m1.hexdigest()
    myurl = myurl + '?appid=' + appid + '&q=' + urllib.quote(line) + '&from=' + fromLang + '&to=' + toLang + '&salt=' + str(salt) + '&sign=' + sign
    try:
        httpClient = httplib.HTTPConnection('api.fanyi.baidu.com')
        httpClient.request('GET', myurl)
        # response是HTTPResponse对象
        response = httpClient.getresponse()
        strresponse = response.read()
        # print strresponse
        dictresponse = json.loads(strresponse)
        translation = dictresponse['trans_result']
        return_line = ""
        for single in translation:
            return_line += single['dst']+"\n"
        return return_line
    except Exception, e:
        return "error_with_baidu_api"

def sougou_zh2en(line):
    fromLang = 'zh-CHS'
    toLang = 'en'
    pid = '72df0792df2638f5c608ea69fdabaac7'
    secretKey = '86b58acab5a6aa868bdcce845f19d797'
    salt = random.randint(1, 65536)
    q = line.strip()
    #md5(pid+q+salt+用户密钥)
    sign = pid.strip() + q.strip() + str(salt).strip() + secretKey.strip()
    hash_md5 = hashlib.md5(sign)
    sign_md5 = hash_md5.hexdigest()
    payload = {'q':q,'from':fromLang,'to':toLang,'pid':pid,'salt':str(salt),'sign':sign_md5}
    r = requests.post("http://fanyi.sogou.com/reventondc/api/sogouTranslate", data=payload)
    result = eval(r.text)
    return result['translation']


def sougou_en2zh(line):
    toLang = 'zh-CHS'
    fromLang = 'en'
    pid = '72df0792df2638f5c608ea69fdabaac7'
    secretKey = '86b58acab5a6aa868bdcce845f19d797'
    salt = random.randint(1, 65536)
    q = line.strip()
    #md5(pid+q+salt+用户密钥)
    sign = pid.strip() + q.strip() + str(salt).strip() + secretKey.strip()
    hash_md5 = hashlib.md5(sign)
    sign_md5 = hash_md5.hexdigest()
    payload = {'q':q,'from':fromLang,'to':toLang,'pid':pid,'salt':str(salt),'sign':sign_md5}
    r = requests.post("http://fanyi.sogou.com/reventondc/api/sogouTranslate", data=payload)
    result = eval(r.text)
    return result['translation']


def fanyi360_en2zh(line):
    payload = {'query':line,"eng":"1"}
    r = requests.post("http://fanyi.so.com/index/search",data=payload)
#    result = (re.findall(',"fanyi":"(.*)"},"msg":"succ"}',r.text)[0])
    data = json.loads(r.text)
    result = data["data"]["fanyi"]
    return result

def fanyi360_zh2en(line):
    payload = {'query':line,"eng":"0"}
    r = requests.post("http://fanyi.so.com/index/search",data=payload)
#    result = (re.findall(',"fanyi":"(.*)"},"msg":"succ"}',r.text)[0])
    data = json.loads(r.text)
    result = data["data"]["fanyi"]
    return result

data_zh["google"][i] = translator.translate(line,dest='zh-Cn').text
data_zh["youdao"][i] = youdao_en2zh(line.encode("utf-8"))
data_zh["baidu"][i] = baidu_api_en2zh(line.encode("utf-8"))
data_zh["sougou"][i] = sougou_en2zh(line.encode("utf-8"))
data_zh["360"][i] = fanyi360_en2zh(line.encode("utf-8"))
data_zh["google"][i] = translator.translate(line,dest='en').text
data_zh["youdao"][i] = youdao_zh2en(line.encode("utf-8"))
data_zh["sougou"][i] = sougou_zh2en(line.encode("utf-8"))
data_zh["baidu"][i] = baidu_api_zh2en(line.encode("utf-8"))
data_zh["360"][i] = fanyi360_zh2en(line.encode("utf-8"))

```
