SIZES="10000 20000 30000 40000 50000 60000 70000 80000 90000 100000"

rm data/exp1_c_data.dat
rm data/exp1_c_data.csv

for SIZE in $SIZES
do

for COUNT in 1 2 3 4 5
do
    # Debugging statement to check program calls working as expected
    # ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 0 -s 200000 dictionaries_and_queries/empty_file

    ALL_TIME=`(time -p ../c/speller_hashset -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 0 -s 200000 dictionaries_and_queries/empty_file) 2>&1 | grep -E "user|sys" | sed s/[a-z]//g`
    
    RUNTIME=0
    for i in $ALL_TIME;
    do
        RUNTIME=`echo $RUNTIME + $i|bc`;
        # echo $RUNTIME
    done
 
    echo $SIZE $RUNTIME >> data/exp1_c_data.dat
    echo $SIZE, $RUNTIME >> data/exp1_c_data.csv

done

done
