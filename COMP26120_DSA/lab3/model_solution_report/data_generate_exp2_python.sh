SIZES="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000"

rm data/exp2_python_data.dat
rm data/exp2_python_data.csv


for SIZE in $SIZES
do

for COUNT in 1 2 3 4 5
do
    # Debugging call -- check command is doing what expected - can be commented out later
        # python3 ../python/speller_bstree.py -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 1 -s 20000 dictionaries_and_queries/empty_file
    
    ALL_TIME=`(time -p python3 ../python/speller_bstree.py -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 1 -s 20000 dictionaries_and_queries/empty_file) 2>&1 | grep -E "user|sys" | sed s/[a-z]//g`
    
    RUNTIME=0
    for i in $ALL_TIME;
        do RUNTIME=`echo $RUNTIME + $i|bc`;
             #    echo $RUNTIME
        done
    echo $SIZE $RUNTIME >> data/exp2_python_data.dat
    echo $SIZE, $RUNTIME >> data/exp2_python_data.csv
    
done

done
