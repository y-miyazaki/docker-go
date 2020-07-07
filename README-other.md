# Various samples for go language

## Overview
Goを利用する際に気をつけることを表形式でリストアップします。  
`※ 静的解析でチェックできることは記載しません。`  
`※ ある程度Goに限らない記載もあります。`  

## Standard layout  
Goはあまり他の言語と違いWebフレームワークはありますが、割とAPIサーバとして使う用途が多いです。  
また、FrontとBackendの役割により明確にリポジトリを分けることも多かったりします。  
APIサーバとして利用する場合は明確なWebフレームワークを選ぶ必要はないので以下standard layoutを参考にディレクトリ構成を構築しましょう。  
\
https://github.com/golang-standards/project-layout

## Generate Swagger  
APIドキュメントの作成はコードからジェネレートする。  
記載したコメントはAPI利用者がわかるようパラメータのdescriptionやexampleを明確にすること。  
\
https://github.com/go-swagger/go-swagger

## Check lint  
ツールを利用すれば一通りのチェックは可能。golint/govetなどはもちろん基本だが、もっと詳細なチェックをしたい場合はgolangci-lintを使うべき。  
\
https://github.com/golangci/golangci-lint

## Error  
エラーは、発生したらNewするか、もしく取得したエラーをWrapしましょう。そして発生したエラーについては必ずStackTraceのログを追加しましょう。  
\
https://github.com/pkg/errors  
https://pkg.go.dev/golang.org/x/xerrors?tab=doc  

## Resolve dependencies
go1.11以降からはgo modでdependenciesの解決ができる。depやglide等のツールもあるがgo標準で用意されているためgo modを使うべき。

## Get Log
ログの表示は標準パッケージより外部のライブラリが優れている。基本的にはlogrusで良いと思うがもっと良いものがあったら[awesome-go#logging](https://github.com/avelino/awesome-go#logging)から探すのも良いでしょう。  
Logレベルの定義は必ず明確に決めること。適当にERRORレベルを付与すると運用時にトラブルになりやすい。  
- Logrus
https://github.com/Sirupsen/logrus
- LogLevel(log4j)
https://ja.wikipedia.org/wiki/Log4j

## Routers
Goを利用する場合には必ず利用するというべきルーティング(URLのマッピングをしてくれる)だが、以下のをお勧めする。基本的には軽量・速度の速さ・メモリアロケートの少なさ・依存関係の少ないものを選ぶべき。  
- https://github.com/gin-gonic/gin  
処理速度の速さ、メモリアロケートの少なさも際立っている。若干依存関係がある。
- https://github.com/go-chi/chi  
速度は標準的、メモリアロケートは多少ありそう。標準パッケージのみで構成されている。
- https://github.com/labstack/echo  
速度は標準的、メモリアロケートの少なさも際立っている。外部ライブラリに依存しているが高機能。
- https://github.com/julienschmidt/httprouter  
処理速度の速さ、メモリアロケートの少なさも際立っている。標準パッケージのみで構成されている。機能的にはないものがありそうなので機能面の調査は必要。

## Avoid init function
init functionはpackageロード時に自動的に読み込まれてしまうため、go test等や想定外のバグを引き起こしやすい。仕様に精通していない限り使用は避けるべき。

## Functions and Variables and Const Scope
Goは大文字小文字の差でpackage外部から利用できるか出来ないかが決まります。これを適当に決めると、外部する必要がないものを公開することになり、packageを利用する人が混乱します。必要のないものは小文字とすること。

## Get config or environment variale
基本的に様々な環境に対してアプリケーションをデプロイする場合、環境によって異なる設定を入れる必要があります。例えば...

- 環境により異なるDB
- 環境により異なるAPI URL
- 環境により異なるAPI KEY

上記のようなものはenvironment variable。

- 環境により異ならないログの出力先
- 環境により異ならないAPI URL

上記のようなものはconfigで定義しましょう。

## Understanding status codes
HTTPステータスコードには様々なものがありますが、理解せず適当にレスポンスするとトラブルになります。  

- バリデーションエラーでInternal Server Error(500)を返す。  
これはValidationエラーでよくやりがちなミスですがデータのパースに失敗した場合に、何故かInternal Server Error(500)を返し、サーバエラーとしてログ監視でトラブルになるパターンです。  
ユーザ原因のエラー等は、Bad Request(400)等で返すべきです。  

- データが存在しない場合に、Not Found(404)ではなくInternal Server Error(500)で返す。  
データ上、存在しないことがあり得る場合はNot Found(404)。Masterデータのような必ず存在すべきデータが存在しない場合は、Internal Server Error(500)とする方が良い。

## About RESTful API
RESTful APIを作成する際には以下の点を意識しましょう。
\
https://ja.wikipedia.org/wiki/Representational_State_Transfer

- アドレス可能性(Addressability)  
提供する情報がURIを通して表現できること。全ての情報はURIで表現される一意なアドレスを持っていること。  
参考URLリスト: https://qiita.com/yu1ro/items/f366ded721f03ae91d96

- ステートレス性(Stateless)  
HTTPをベースにしたステートレスなクライアント/サーバプロトコルであること。セッション等の状態管理はせず、やり取りされる情報はそれ自体で完結して解釈できること。

- 接続性(Connectability)  
情報の内部に、別の情報や(その情報の別の)状態へのリンクを含めることができること。

- 統一インターフェース(Uniform Interface)  
情報の操作(取得、作成、更新、削除)は全てHttp Request Method(GET、POST、PUT、DELETE)を利用すること。

## Understanding Http Request Method
About RESTful APIでも出てきましたが、Http Request Methodでは代表的なものとして、GET/POST/DELETE/PUT/OPTIONS等がありますが、正しく理解していますか？  
https://ja.wikipedia.org/wiki/Hypertext_Transfer_Protocol#%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89

- GET  
The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.

- HEAD  
The HEAD method asks for a response identical to that of a GET request, but without the response body.

- POST  
The POST method is used to submit an entity to the specified resource, often causing a change in state or side effects on the server.

- PUT  
The PUT method replaces all current representations of the target resource with the request payload.

- DELETE  
The DELETE method deletes the specified resource.

- CONNECT  
The CONNECT method establishes a tunnel to the server identified by the target resource.

- OPTIONS  
The OPTIONS method is used to describe the communication options for the target resource.

- TRACE  
The TRACE method performs a message loop-back test along the path to the target resource.

- PATCH  
The PATCH method is used to apply partial modifications to a resource.
