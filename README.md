ぶっくる
=======

## 概要
ぶっくるは学習支援を目的とししたアプリです。
アプリの概要を説明する前に質問をしたいと思います。

#### どこで学習をしますか？

ぶっくるはこの質問に対して答えを提示してくれます。
ぶっくるは学習できる場所を簡単に探してくれます。
つまり「場所」という観点であなたの学習支援をしてくれます。
多忙で家でまとまった学習時間をとれないあなたに、隙間時間で勉強できるよう、ぶっくるは近場の学習できる環境がどこにあるか教えてくれます。具体的には次の4つの機能を提供しています。

#### 近場の図書館の検索
#### 近場のカフェの検索
#### 近場の過去に登録した場所を検索
#### 検索した場所までの道案内を表示 ※Google Mapsアプリとの連携を利用して

## 詳細
では実際の操作の流れにそって詳細を説明していきます。

### アプリの起動
「ぶっ」という文字のアイコンがぶっくるのアプリアイコンです。
これをタップするとアプリが起動します。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2505.PNG" alt="ぶっくるスクリーンショット" style="display: block; width: 320px; height: auto;"/>

起動後大きな「ぶっ」が表示されます。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2506.PNG" alt="ぶっくるスクリーンショット" style="display: block; width: 320px; height: auto;"/>

※せっかく作成したので表示させていただきました。

### 図書検索
アプリを起動すると即座に付近の図書館を検索してくれます。
こちらは[カーリル](http://calil.jp/)という図書検索のAPIを利用させて頂いております。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2507.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

ではちかばけんさくと書かれたナビゲーションバーの右端を左にスワイプしてください。
そうすると現在表示されている図書館リストが表示されます。
そして人のアイコンをタップします。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2512.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

そうするとGoogle Mapsを、現在位置から目標地点（図書館）までの案内をしてくれる形で起動してくれます。
※Google Mapsの機能です
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2513.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

選択したらひたすらウォーキングです。
Google Mapsアプリで道案内もばっちり！これで迷子になることもないですね。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2514.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

### カフェ検索
さて、ここでもう一度アプリに戻ってみましょう。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2507.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

そしたら左上の三本線のアイコンをタップしてメニューを表示します。
そうするメニューが表示され、その中にカフェ検索があります。
カフェ検索をタップします。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2508.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

そうすると近場のカフェが検索されます。
設定でwifi付きのみのカフェを検索することもできます。
※こちらは[リクルート](http://webservice.recruit.co.jp/hotpepper/reference.html)のAPIを利用しています。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2509.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

こちらも図書検索と同様に道案内を表示する事ができます。

### お気に入り検索
今度はメニューの「ブックマーク」をタップします。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2508.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

そうすると過去に「ぶっくる（ブックマーク）」したものが表示されます。
また、現在の場所を「ぶっくる（ブックマーク）」したい場合は「ぶ」をタップします。

<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2510.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

確認画面が表示されますので、そのまま「はい」をタップします。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2515.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

タイトルとノートを記入して「ぶっくる」をタップします。
住所は現在位置から自動で取得されるため記入する必要はありません。
簡単にご自身のお気に入りの場所を登録できます！
もちろんこの登録した内容は近くまで来たら検索で表示されます。
道案内と合わせて「過去行ったけど…どこだったっけな…？」なんて事でもう悩む必要はありません。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2516.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

### 検索設定
より柔軟に検索するために設定画面を用意しています。
特にカフェ検索のwifiで絞り込むオプションは非常に便利です！
wifiがあればネットを利用して調べ物もできてしまいます。
<img src="https://dl.dropboxusercontent.com/u/37986965/Bookuru/IMG_2511.PNG" alt="ぶっくるスクリーンショット" style="display: block; margin: 10px; width: 320px; height: auto;"/>

## インストール（salesforceで使うオブジェクトのみ）
このアプリで利用しているオブジェクトを以下のリンクからインストールする事ができます。
[開発者用の組織を取得](https://developer.salesforce.com/signup)して是非試してみてください。
[インストールURL](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t10000000FkEX)

## 最後に
このアプリを作成するために以下の3つのライブラリを利用しました。
非常に使い勝手がいいので是非利用してみてください。
作者に感謝です。
#### [AFNetworking](https://github.com/AFNetworking/AFNetworking)
#### [AHKActionSheet](https://github.com/fastred/AHKActionSheet)
#### [JASidePanels](https://github.com/gotosleep/JASidePanels)