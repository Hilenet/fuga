#! /bin/sh

# env/*.tmpから本番用環境変数を作成
./tools/init.sh

# productionのdiffを適用して実行
# docker-compose -f docker-compose.yml -f production.docker-compose.yml up -d

