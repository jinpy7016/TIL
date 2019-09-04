`20190904W_Spark`

# Spark_MLlib

## 1. MLlib

> 통계처리나 머신러닝을 구현하기 위한 Spakr library

- 관측, 특성 : feture은 Observation data의 속성을 나타내는 용도로 사용된다.
- 지도학습
  - 레이블(lable) : 훈련을 위해 주어지는 데이터셋에  각 관측데이터에 대한 올바른 출력값을 알려주는 값
    - LabeledPoint
- data
  - 연속성 데이터 (Continuous Data) : 무게, 온도, 습도 .. 연속적인 값 => 실수값
  - 이산형 데이터 (Discrete data) : 나이, 성별, 개수 .. 불연속적인 값 => 정수, 문자값
  - **Double type** 데이터만 사용 가능 
- model : algorithm에 데이터를 적용해서 만들어낸 결과
- Parametric 방식
  - 고정된 개수의 파라미터
  - 계수 사용
  - 입-출력 사이의 관계를 특성 값에 관한 수학적 함수, 수식으로 가정=> 실제 결과값에 가깝도록 계수 조정하는 방법
- Nonparametric 방식
  - 머신러닝의 수행결과를 그대로 사용
  - SVM, Naive Bayes
- Supervised Learning ~ clustering Learning
- Unsupervised Learning

### 1.1 통계처리, 머신러닝

> 통계처리 : 특정 데이터로부터 수작적 기법을 이용하여 그 성질을 끄집어내는 처리
>
> 머신러닝 : 과거 데이터의 *정량적 관계*를 파악함으로써 미래 데이터에 대한 *예측*을 하는 처리

- MLlib은 스파크의 기능을 그대로 사용, 스몰 데이터에서 빅데이터까지 다룰 수 있다.
- `Spark Shell`로 반복적인 시행착오 작업도 가능하다.

## 2. MLlib algorithm

### 2.1 머신러닝 라이브러리

>  행렬계산을 이용하는 경우가 많다.

- MLlib API

  > 머신러닝 알고리즘 : classification, regression, clustering, collaborative filtering
  >
  > 특성 추출, 변환, 선택
  >
  > 파이프라인 :  여러 종류의 머신러닝 알고리즘을 순차적으로 수행할 수 있는 API 제공
  >
  > 저장 : 알고리즘 모델, 파이프라인에 대한 저장 및 불러오기 기능을 제공
  >
  > Utility : 선형대수, 통계, 데이터 처리 등의 유용한 함수를 제공

  - spark.mllib : RDD기반 API
  - spark.ml : DataFrame 기반 API

#### 2.1.1. MLlib의 DataType

- 보통 데이터는 희소성을 갖는 경향이 있다. 
  - 벡터 (`희소 벡터 (sparse vector)`) : 1차원 데이터를 다루는 데이터 타입
    - 순수한 1차원 테이블 데이터 타입 (`LocalVector`) : `DenseVector`과 `SparseVector`클래스 이용
    - 머신러닝용 레이블 갖는 데이터 타입 (`LabeledPoint`) : 지도학습 알고리즘 이용할 때, 독립변수와 종속변수를 함께 보존할 때 이용
    - `org.apache.spark.ml.linalg` package에 정의된 trade
    - factory method :  `dense()`, `sparse()`
    
    ```scala
    //vector 생성
    import org.apache.spark.ml.linalg.Vectors
    val v1=Vectors.dense(0.1, 0.0, 0.2, 0.3)
    val v2 = Vectors.dense(Array(0.1, 0.0, 0.2, 0.3))
    val v3 = Vectors.sparse(4, Seq((0, 0.1), (2, 0.2), (3, 0.3)))
    val v4 = Vectors.sparse(4, Array(0, 2, 3), Array(0.1, 0.2, 0.3))
    
    println(v1.toArray.mkString(", "))
    //0.1, 0.0, 0.2, 0.3
    
    println(v3.toArray.mkString(", "))
    //0.1, 0.0, 0.2, 0.3
    
    ```
    
    
    
  - 행렬 (`희소 행렬 (sparse matrix)`) : 1개 이상의 벡터로 구서되는 행렬 형식의 데이터 타입
    - LocalMatrix : 한대의 홋트로 행렬형식의 데이터를 다루기 위한 데이터 타입
    - DistributedMatrix : 대규모 데이터 셋을 분산처리하기 위한 행렬 형식의 데이터 타입
      - 복수의 RDD를 하나의 커다란 행렬 형식의 데이터셋으로 표현
      - RowMatrix
      - IndexedRowMatrix
      - CorrdinateMatrix
      - BlockMatrix

#### 2.1.2. ML algorithm

1. 분류와 회귀
   - 분류 : 선형 SVM(Support Vector Machine), 로지스틱 회귀, 결정 크리, 랜덤 포레스트, GBT, 나이브 베이즈
     - 미리 준비해둔 학습데이터를 통해 분류모델을 작성하고, 따로 준비된 처리데이터에 모델을 적용하여 분류
   - 회귀
2. 협업 필터링 : ALS(Alternating Least Squares)
   - 입력 데이터(고객/상품에 관한 구매이력)로 모델을 작성하고 관련 정보를 추천하는데 활용
3. 클러스터링(clustering)
   - 고객의 특성을 바탕으로 고객을 특정 클러스터로 나누고, 적합한 내용으로 메일을 보내는 것
4. dimension reduction : SVD(Singular Value Decomposition), PCA(Principal Component Analysis)
   - 원래 데이터의 주요 정보를 어떤 형태로든 유지하면서도 데이터 차원을 축소할 수 있다.
   - 사람이 이해하기 쉬운 저차원 데이터로 변환하는 처리
5. 특징 추출/ 변환 : TF-IDF, Word2Vec
   -  문서 특징을 추출하는 방법 (벡터화 방법)
6. frequent pattern mining : FP-growth, 연관성 규칙 마이닝, 순차 패턴 마이닝

## 3. K-means

> 클러스터링 대상 하나하나의 값을 벡터형식으로 나타내면, K-means를 이용해 여러개의 클러스터로 구분할 수 있다.

#### 3.1. K-means clustering

0. 입력 벡터의 집합

1. 임의의 위치에 클러스터 중심 벡터를 작성

2. 클러스터의 중심 벡터와 입력 벡터의 거리 계산하여, 가까운 클러스터에 소속시킨다.

3. 클러스터의 중심벡터를 중심으로 이동시킨다.

4. 중심 이동이 없어질 때까지 반복한다.

   ```scala
   import org.apache.spark.mllib.clustering.KMeans
   import org.apache.spark.mllib.linalg.Vectors
   val sparkHome =sys.env("SPARK_HOME")
   val data =sc.textFile("file://"+sparkHome+"/data/mllib/kmeans_data.txt")
   val parseData =data.map{s=> Vectors.dense(s.split(' ').map(_.toDouble))}.cache()
   val numClusters =2
   val numIter=10
   val clusters=KMeans.train(parseData, numClusters, numIter)
   ```

   - 입력 데이터를 다루는 `Vectors`, K-Means model을 생성하는 `Kmeans` 클래스 이용
     - `Vectors`의 `dense(array)` 메서드 이용하여 인서로 건내주는 배열을 요소로 같은 DenseVector을 생성=>공백으로 입력 데이터 구분하여 배열 생성, Double형의 벡터로 만들어 K-means로 이용
     - `Kmeans`의 `train` 메서드를 이용하여 학습모델 생성
       - 학습 데이터 벡터군/ 클러스터 개수/ 반복 횟수의 상한
       - 내부적으로 스파크 action을 수행하므로 shell에서 실행하면 job이 예약된다.
       - 중심 이동이 없거나 반복 횟수가 지정한 횟수를 넘으면 처리가 끝나고, 학습모델의 결과로 돌려준다.
   - 결과

   ```scala
   clusters.k
   //res0: Int = 2
   
   clusters.clusterCenters
   //res2: Array[org.apache.spark.mllib.linalg.Vector] = Array([9.1,9.1,9.1], [0.1,0.1,0.1])
   
   val vec1=Vectors.dense(0.3,0.3,0.3)
   clusters.predict(vec1)
   //res3: Int = 1
   
   val vec2=Vectors.dense(7.8,7.8,7.8)
   clusters.predict(vec2)
   //res4: Int = 0
   
   parseData.foreach(vec=>println(vec+"=>"+clusters.predict(vec)))
   /*[0.0,0.0,0.0]=>1
   [0.1,0.1,0.1]=>1
   [0.2,0.2,0.2]=>1
   [9.0,9.0,9.0]=>0
   [9.1,9.1,9.1]=>0
   [9.2,9.2,9.2]=>0*/
   
   ```

   

##### 3.1.1. WSSSE

> 입력 벡터의 집합과 소속 클러스터의 중심과의 오체 제곱 합 (SSE)
>
> K값을 크게 할수록 작아지는 경향, 임계치부터는 큰 변화를 보이지 않는 성질이 있다.
>
> 클러스터의 개수를 조정하면서 *최적의 클러스터 개수*를 결정할 수 있다.

``` scala
val WSSSE=clusters.computeCost(parseData)
println("Within Set Sum of Squred Errors = "+WSSSE)
//Within Set Sum of Squred Errors = 0.11999999999994547
```

##### 3.1.2. save

> 여러 번 시행착오를 거친 후 얻은 모델을 save 메서드를 이용해 보존하면 재사용 가능하다.

```scala
clusters.save(sc, "kmeans_model")
```

## 4. Word2Vec

> `단어의 백터화`를 위한 수단

### 4.1. 형태소 분석

> 의미를 갖는 최소한의 단위로 문서에서 단어 추출

0. 텍스트 데이터 준비

1. spark-shell에서 Word2Vec실행

   ```bash
   [hadoop@master jars]$ mv ~/Downloads/korean-text-4.4.4.jar /usr/local/spark/jars/
   
   $ ${SPARK_HOME}/bin/spark-shell \
   --master yarn \
   --packages com.twitter.penguin:korean-text:4.4.4 \
   --conf spark.serializer=org.apache.spark.serializer.KryoSerializer
   ```

   - 의존관계에 있는 한국어 형태소 분석 라이브러리 추가
   - 분산처리에서 이용하는 직렬화 클래스를 Kryo로 변경

   ```scala
   import java.io.StringReader
   import org.apache.spark.mllib.feature.{Word2Vec, Word2VecModel}
   import com.twitter.penguin.korean.TwitterKoreanProcessor
   import com.twitter.penguin.korean.tokenizer.KoreanTokenizer.KoreanToken
   import org.apache.spark.mllib.linalg.Vectors
   
   val sentence="이 책은 무슨 책 일까요"
   val nomalized: CharSequence = TwitterKoreanProcessor.nomalize(sentence)
   val tokens: Seq[KoreanToken]=TwitterKoreanProcessor.tokenize(nomalized)
   val stemmed: Seq[KoreanToken]=TwitterKoreanProcessor.stem(tokens)
   val input=sc.textFile("/path/to").map(line=>TwitterKoreanProcessor.tokensToStrings(TwitterKoreanProcessor.tokenize(TwitterKoreanProcessor.nomalize(line))))
   
   val word2vec= new Word2Vec()
   word2vec.setMinCount(3)
   word2vec.setVectorSize(30)
   val model=word2vec.fit(input)
   model.findSynonyms("소년",3)
   relationWords("남자","여자","연애",model)
   ```

   