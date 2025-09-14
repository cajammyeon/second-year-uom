SIZES="10000 20000 30000 40000 50000"
QUERY_SIZES="20000 40000 60000 80000 100000"

rm data/exp3_c_data.dat
rm data/exp3_c_data.csv

for SIZE in $SIZES
do

for QUERY_SIZE in $QUERY_SIZES
do


for COUNT in 1 2 3 4 5
do
    # Debugging call -- check command is doing what expected - can be commented out later
    # ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_${QUERY_SIZE}_$COUNT -m 1 -s 200000 dictionaries_and_queries/query_${SIZE}_${QUERY_SIZE}_$COUNT

    # ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_${QUERY_SIZE}_$COUNT -m 1 -s 200000 dictionaries_and_queries/empty_file

    ALL_TIME=`(time -p ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_${QUERY_SIZE}_$COUNT -m 1 -s 200000 dictionaries_and_queries/query_${SIZE}_${QUERY_SIZE}_$COUNT) 2>&1 | grep -E "user |sys " | sed s/[a-z]//g`
    
    DICT_TIME=`(time -p ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_${QUERY_SIZE}_$COUNT -m 1 -s 200000 dictionaries_and_queries/empty_file) 2>&1 | grep -E "user |sys " | sed s/[a-z]//g`
    
    RUNTIME=0
    # echo $ALL_TIME
    for i in $ALL_TIME;
    do RUNTIME=`echo $RUNTIME + $i|bc`;
           # echo $RUNTIME
    done

    RUNTIME2=0
    for i in $DICT_TIME;
    do RUNTIME2=`echo $RUNTIME2 + $i|bc`;
           # echo $RUNTIME2
    done

    
    echo $SIZE $QUERY_SIZE $RUNTIME $RUNTIME2>> data/exp3_c_data.dat
    echo $SIZE, $QUERY_SIZE, $RUNTIME, $RUNTIME2 >> data/exp3_c_data.csv

    
done

done

done
