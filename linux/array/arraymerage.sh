#!/usr/bin/env bash
java=(
java_home
classpath
path
)
python=(
python2.6
python2.7
python3
)
common=(${java[@]} ${python[@]})
for i in ${common[@]}
do
        echo $i
done
