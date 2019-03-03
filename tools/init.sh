#! /bin/sh

# .env.tmpから.envを作成
env_dir=env
for mode_dir in $env_dir/* ; do
  for tmp_file in $mode_dir/*.tmp ; do
    env_file=${tmp_file%.tmp}
    if [ -e $env_file ] ; then
      continue
    fi
    # PASSをランダム生成
    touch $env_file && cat $tmp_file > $env_file
    for line in $(grep PASS=\$ $tmp_file) ; do
      rnd=$(cat /dev/urandom | base64 | fold -w 64 | head -1 | tr -dc 'A-Za-z0-9')
      cat $env_file | (rm $env_file; sed "s/^$line$/$line$rnd/" > $env_file)
    done
  done
done

# conf/slack.cred
cred_dir=cred
cred_files=(slack.env)
for mode_dir in $cred_dir/* ; do
  for cred_file in $cred_files ; do
    env_file=$mode_dir/$cred_file
    tmp_file=$env_file.tmp
    if [ -e $env_file ] ; then
      continue
    fi

    # cpだとフラッシュのタイミングが不明
    touch $env_file && cat $tmp_file > $env_file
    echo "[init.sh] please input $env_file Credential"
    read -p "$env_file: " input
    cat $env_file | (rm $env_file; sed "s/=$/=$input/" > $env_file)
  done
done

