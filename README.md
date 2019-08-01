# alpine-python3-numpy-pandas-sparkContainer-spark-submit #

### If you are interested in working with Big Data(spark,pyspark,Java),ML(numpy,pandas),Data Engineering (kafka,pymongo,flatbuffers)on Docker - Kubernetes ###

![you are expected to know everything possible with data in it](https://i.imgur.com/el8l3nS.jpg)


Using python3.6 alpine base image adds java,pandas, numpy,pyspark,spark,kafka,pymongo,flatbuffers as rundeps. 
This image can be used as container image when you run spark-submit on k8. 
When you spark-submit you have to specify "spark.kubernetes.container.image=<image>"in conf options .
That image will be applied on the drivers and executors. So if you need any dependencies like numpy,pandas in your code 
than you need to make sure that these dependencies are present in that image.Also this image should have spark and other dependencies
like(Java,pyspark)

This image has all these dependencies(check requirements.txt) 

If you need some more dependencies to be added you can add it in requirements.txt)
