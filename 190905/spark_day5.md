#### Tokenizer 

공백 문자를 기준으로 입력 문자열을 개별 단어의 배열로 변환하고 이 배열을 값으로 하는 새로운 컬럼을 생성하는 트랜스포머. 문자열을 기반으로 하는 특성 처리에 자주 사용

```scala
import org.apache.spark.ml.feature.Tokenizer
import org.apache.spark.sql.SparkSession 

val data = Seq("Tokenization is the process",
 "Refer to the Tokenizer").map(Tuple1(_))    
val inputDF = spark.createDataFrame(data).toDF("input")    
val tokenizer = new Tokenizer().setInputCol("input").setOutputCol("output")   
val outputDF = tokenizer.transform(inputDF)    
outputDF.printSchema()    

scala> outputDF.show(false)    
+---------------------------+--------------------------------+
|input                      |output                          |
+---------------------------+--------------------------------+
|Tokenization is the process|[tokenization, is, the, process]|
|Refer to the Tokenizer     |[refer, to, the, tokenizer]     |
+---------------------------+--------------------------------+

```



#### StringIndexer

문자열 레이블 컬럼에 적용하며 해당 컬럼의 모든 문자열에 노출 빈도에 따른 인덱스를 부여해서 숫자로 된 새로운 레이블 컬럼을 생성

```scala
import org.apache.spark.ml.feature.{IndexToString, StringIndexer}
import org.apache.spark.sql.SparkSession

val spark = SparkSession .builder() .appName("StringIndexerSample") .master("local[*]") .getOrCreate() 
val df1 = spark.createDataFrame(Seq((0, "red"),(1, "blue"),(2, "green"),(3, "yellow"))).toDF("id", "color")   
val strignIndexer = new StringIndexer().setInputCol("color") .setOutputCol("colorIndex") .fit(df1)    
val df2 = strignIndexer.transform(df1)    
scala> df2.show(false)    
+---+------+----------+
|id |color |colorIndex|
+---+------+----------+
|0  |red   |3.0       |
|1  |blue  |1.0       |
|2  |green |0.0       |
|3  |yellow|2.0       |
+---+------+----------+


val indexToString = new IndexToString() .setInputCol("colorIndex") .setOutputCol("originalColor") 
val df3 = indexToString.transform(df2)   
scala> df3.show(false)    
+---+------+----------+-------------+
|id |color |colorIndex|originalColor|
+---+------+----------+-------------+
|0  |red   |3.0       |red          |
|1  |blue  |1.0       |blue         |
|2  |green |0.0       |green        |
|3  |yellow|2.0       |yellow       |
+---+------+----------+-------------+
```



### 8.5 응용(회귀에 의한 매출 분석)

2014년 소매점 매출 정보를 분석해 미래를 예측

1. 과거 로그 데이터에 대한 전처리

2. 알고리즘을 적용해 모델 작성

3. 예측 모델 평가와 미지의 데이터에 대한 적용

   

1단계 : 데이터 전처리
MLlib 입력 데이터 형으로 변환하기 위해 DataFrame으로 생성

shema 정의 - case class 정의

```bash
$ hadoop fs -mkdir /data/sales
$ hadoop fs -put weather.csv  /data/sales/
$ hadoop fs -put sales.csv  /data/sales/
```

```scala
case class Weather( date: String,
                    day_of_week: String,
                    avg_temp: Double,
                    max_temp: Double,
                    min_temp: Double,
                    rainfall: Double,
                    daylight_hours: Double,
                    max_depth_snowfall: Double,
                    total_snowfall: Double,
                    solar_radiation: Double,
                    mean_wind_speed: Double,
                    max_wind_speed: Double,
                    max_instantaneous_wind_speed: Double,
                    avg_humidity: Double,
                    avg_cloud_cover: Double)
case class Sales(date: String, sales: Double)

import spark.implicits._
import org.apache.spark.mllib.regression.{LabeledPoint,LinearRegressionWithSGD}
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.feature.StandardScaler
import org.apache.spark.mllib.evaluation.RegressionMetrics
import org.apache.spark.sql.functions.udf

// 기상 데이터를 읽어 DataFrame으로 변환한다
val weatherCSVRDD = sc.textFile("/data/sales/weather.csv")
val headerOfWeatherCSVRDD = sc.parallelize(Array(weatherCSVRDD.first))
val weatherCSVwithoutHeaderRDD = weatherCSVRDD.subtract(headerOfWeatherCSVRDD)
val weatherDF = weatherCSVwithoutHeaderRDD.map(_.split(",")).
      map(p => Weather(p(0),
      p(1),
      p(2).trim.toDouble,
      p(3).trim.toDouble,
      p(4).trim.toDouble,
      p(5).trim.toDouble,
      p(6).trim.toDouble,
      p(7).trim.toDouble,
      p(8).trim.toDouble,
      p(9).trim.toDouble,
      p(10).trim.toDouble,
      p(11).trim.toDouble,
      p(12).trim.toDouble,
      p(13).trim.toDouble,
      p(14).trim.toDouble
    )).toDF()

// 매출 데이터를 읽어 DataFrame으로 변환한다
val salesCSVRDD = sc.textFile("/data/sales/sales.csv")
val headerOfSalesCSVRDD = sc.parallelize(Array(salesCSVRDD.first))
val salesCSVwithoutHeaderRDD = salesCSVRDD.subtract(headerOfSalesCSVRDD)
val salesDF = salesCSVwithoutHeaderRDD.map(_.split(",")).map(p => Sales(p(0), p(1).trim.toDouble)).toDF()

//정의된 스키마 확인
println(weatherDF.printSchema)  
println(salesDF.printSchema)   

// 데이터의 전처리(날짜 기준으로 조인 후, 요일 컬럼값을 수치화하고, 요일컬럼제거후 , 수치화된 주말컬럼 추가)
val salesAndWeatherDF = salesDF.join(weatherDF, "date")
val isWeekend = udf((t: String) => if(t.contains("일") || t.contains("토")) 1d 
                                       else 0d)
val replacedSalesAndWeatherDF = salesAndWeatherDF.withColumn("weekend", isWeekend(salesAndWeatherDF("day_of_week"))).drop("day_of_week")

//매출에 영향을 주는 독립변수만 추출하여 새로운 데이터 프레임 생성
//매출에 영향을 주는 독립변수 평균기온, 일강수량, 휴일을 선택
val selectedDataDF = replacedSalesAndWeatherDF.select("sales", "avg_temp", "rainfall", "weekend")

//데이터프레임을 회귀분석을 위한 Vector, LabeledPoint로 생성
 val labeledPointsRDD = selectedDataDF.rdd.map(row => LabeledPoint(row.getDouble(0),
 Vectors.dense(row.getDouble(1),row.getDouble(2),row.getDouble(3))))

//데이터 특성을 표준화(평균 0, 분산1인 스케일러 사용)
// 데이터의 표준화 (평균값을 조정하고 스케이링을 개별적으로 유효화 또는 무효화를 할 수 있다
//val scaler = new StandardScaler(withMean = true, withStd = true).fit(labeledPointsRDD.map(x => x.features))
val scaler = new StandardScaler().fit(labeledPointsRDD.map(x =>x.features))
val scaledLabledPointsRDD = labeledPointsRDD.map(x => LabeledPoint(x.label, scaler.transform(x.features)))

```



2. 알고리즘 적용 모델 작성

```scala
// 선형회귀 모델을 작성한다
    val numIterations = 20
    scaledLabledPointsRDD.cache
    val linearRegressionModel = LinearRegressionWithSGD.train(scaledLabledPointsRDD, numIterations)
    println("weights :" + linearRegressionModel.weights)

// 알고리즘에 미지의 데이터를 적용해 예측한다
    val targetDataVector1 = Vectors.dense(15.0,15.4,1)
    val targetDataVector2 = Vectors.dense(20.0,0,0)
    val targetScaledDataVector1 = scaler.transform(targetDataVector1)
    val targetScaledDataVector2 = scaler.transform(targetDataVector2)
    val result1 = linearRegressionModel.predict(targetScaledDataVector1)
    val result2 = linearRegressionModel.predict(targetScaledDataVector2)
    println("avg_tmp=15.0,rainfall=15.4,weekend=true : sales = " + result1)
    println("avg_tmp=20.0,rainfall=0,weekend=false : sales = " + result2)


```



3. 예측 모델 평가

   ```scala
   // 입력 데이터를 분할하고 평가한다
       val splitScaledLabeledPointsRDD = scaledLabledPointsRDD.randomSplit(Array(0.6, 0.4), seed = 11L)
       val trainingScaledLabeledPointsRDD = splitScaledLabeledPointsRDD(0).cache()
       val testScaledLabeledPointsRDD = splitScaledLabeledPointsRDD(1)
       val linearRegressionModel2 = LinearRegressionWithSGD.train(trainingScaledLabeledPointsRDD, numIterations)
       val scoreAndLabels = testScaledLabeledPointsRDD.map { point =>
       val score = linearRegressionModel2.predict(point.features)
         (score, point.label)
       }
   ```

   

4. 보존

   ```scala
   val metrics = new RegressionMetrics(scoreAndLabels)
       println("RMSE = "+ metrics.rootMeanSquaredError)
       // 작성한 모델을 보존한다
   linearRegressionModel.save(sc, "/output/mllib/model/")
    
   import org.apache.spark.mllib.regression.LinearRegressionModel
   val model2 = LinearRegressionModel.load(sc, "/output/mllib/model/")
   
   //스파크를 실행시킨 디렉토리 경로 아래에 파일 생성
   linearRegressionModel.toPMML("model.pmml")
   
   hadoop ~ ]# cat model.pmml
   ```

   