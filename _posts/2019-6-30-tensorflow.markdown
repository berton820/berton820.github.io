---
layout: post
title:  "tensorflow"
date:   2019-11-24 14:07:35 +0800
categories: commend
---

初始化设置
```
# TF_CPP_MIN_LOG_LEVEL默认值为 0 (显示所有logs)，设置为 1 隐藏 INFO logs, 2 额外隐藏WARNING logs, 设置为3所有 ERROR logs也不显示。
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '0'  #
os.environ['CUDA_VISIBLE_DEVICES'] = '0,1,2,3'
graph = tf.get_default_graph()
gpu_options = tf.GPUOptions(allow_growth=True)
sess_config = tf.ConfigProto(gpu_options=gpu_options)
sess_config.gpu_options.allow_growth = True
sess_config.allow_soft_placement = True
sess_config.log_device_placement = False
sess = tf.Session(graph=graph, config=sess_config)
```

打印参数
``` 
print("Total number of parameters: ",np.sum([np.prod(v.get_shape().as_list()) for v in tf.trainable_variables()]))
```

自动选择GPU
```
if FLAGS.auto_gpu:
    index_of_gpu = get_available_gpu()
    FLAGS.gpu = 'gpu:' + str(index_of_gpu)
    print('Use GPU {}'.format(index_of_gpu))
else:
    index_of_gpu = 0
os.environ["CUDA_VISIBLE_DEVICES"] = str(index_of_gpu)
```
# 网址
<https://mp.weixin.qq.com/s/x5TOCcg3BvRjsFzKJicgRg> tensorboard
<https://mp.weixin.qq.com/s/9etR8QEk4UXtoLqkJFQIHA> tf.metrics
