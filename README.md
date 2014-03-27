Okuraを用いた形態素解析WebAPI
====================


これは何
--------------------

[todesking](https://github.com/todesking/okura)さんが作成され
たRubyによる形態素解析ライブラリ
[okura](https://github.com/todesking/okura)をHTTP経由で利用す
るための簡易ラッパーです。


準備
--------------------

* 1: gem をインストールします。

```
% bundle install --path vendor/bundle
```

* 2: 辞書を準備をします。
[mecab-naist-jdic-0.6.3b-20111013.tar.gz]
(http://sourceforge.jp/projects/naist-jdic/releases/)を利用
します。

```
% bundle exec rake
```

* 3: 任意の rack コンテナでアプリを起動します。

```
% bundle exec rackup
```


形態素解析
--------------------

* 1: URL `/okura/morph` に対し、HTTP POST で形態素解析したい文を
送出します。formatはJSON、文を示すkeyは'text'です。

```
% curl -d '{"text": "今日は良い天気でした。"}' http://localhost:9292/okura/morph -H Content-Type:application/json
```

* 2: 解析結果のmincost_pathが配列としてJSONで返ります。各要素はHashです。各keyとdataの対応付けは以下の通りです。

    - surface: 表記。node.word.surface。
    - text: 品詞の配列。node.left.text。

```
[{"surface":"BOS/EOS","text":"[\"BOS/EOS\"]"},{"surface":"今日","text":"[\"名詞\", \"副詞可能\", \"*\", \"*\", \"*\", \"*\", \"*\"]"},{"surface":"は","text":"[\"助詞\", \"係助詞\", \"*\", \"*\", \"*\", \"*\", \"は\"]"},{"surface":"良い","text":"[\"形容詞\", \"自立\", \"*\", \"*\", \"形容詞・アウオ段\", \"基本形\", \"*\"]"},{"surface":"天気","text":"[\"名詞\", \"一般\", \"*\", \"*\", \"*\", \"*\", \"*\"]"},{"surface":"でし","text":"[\"助動詞\", \"*\", \"*\", \"*\", \"特殊・デス\", \"連用形\", \"です\"]"},{"surface":"た","text":"[\"助動詞\", \"*\", \"*\", \"*\", \"特殊・タ\", \"基本形\", \"た\"]"},{"surface":"。","text":"[\"記号\", \"句点\", \"*\", \"*\", \"*\", \"*\", \"BOS/EOS\"]"},{"surface":"BOS/EOS","text":"[\"BOS/EOS\"]"}]
```

分かち書き
--------------------

* 1: URL `/okura/wakati` に対し、HTTP POST で形態素解析したい文を
送出します。formatはJSON、文を示すkeyは'text'です。

```
% curl -d '{"text": "今日は良い天気でした。"}' http://localhost:9292/okura/wakati -H Content-Type:application/json
```

* 2: 分かち書き結果が配列としてJSONで返ります。

```
["BOS/EOS","今日","は","良い","天気","でし","た","。","BOS/EOS"]
```


謝辞
--------------------

有益なライブラリを公開して下さった todesking さんへ感謝いたします。


COPYRIGHT
--------------------

* mecab-naist-jdic-0.6.3b-20111013.tar.gz ならびに okura は
  それぞれのライセンスをご確認下さい。
* 本レポジトリ内コードのライセンスは LICENSE を御覧ください。
