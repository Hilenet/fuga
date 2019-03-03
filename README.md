# SlackArchiver

## about
Slackのポスト(+ファイル)を収集・保存する為のツール．
収集daemon + DB + Web．
webはまあ後でいいじゃろ・・・(開発放置)


## purpose
増えすぎたSlackのポスト，アーカイブを手元に残したい(freeプランではアクセス不可)
* 主目的はポストの管理
* ファイルは二の次かな->必要なら別途ファイルサーバ
* 収集保管のみを旨とし，提供は別途


## usage
知らん．


## component(services)
### collector
Goでバイナリ．
multi-stage buildingでビルド環境と分離，実行はalpine．

### db
mariaDB．
初回起動時にdevelopmentDBとproductionDBを生成，初期migration．
writeユーザとreaderユーザを用意．
webUI側作る時はreaderユーザ使おう．
なお，developmentDBとproducionDBでユーザ分けてみた．

