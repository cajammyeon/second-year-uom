SIZES="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000"

rm data/exp2_java_data.dat
rm data/exp2_java_data.csv

for SIZE in $SIZES
do

for COUNT in 1 2 3 4 5
do

for COUNT2 in 1 2 3 4 5 6 7 8 9 10
do
    # Debugging call -- check command is doing what expected - can be commented out later
        # java -cp ../java comp26120.speller_bstree -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 1 -s 20000  dictionaries_and_queries/empty_file

    ALL_TIME=`(time -p java -cp ../java comp26120.speller_bstree -d dictionaries_and_queries/dict_${SIZE}_20000_$COUNT -m 1 -s 20000  dictionaries_and_queries/empty_file)  2>&1 | grep -E "user|sys|Height:" | sed s/[a-zA-Z]//g | sed s/://g `
    
    RUNTIME=0
    HEIGHT=0
    START=1
    for i in $ALL_TIME;
         do
            echo $i
            if (($START==1))
            then
                    # echo "echoing height"
                HEIGHT=$i
                START=0
                                # echo $HEIGHT
            else
                # echo "echoing runtime twice"
                RUNTIME=`echo $RUNTIME + $i|bc`;
                                # echo $RUNTIME
            fi
        done
    echo $SIZE $RUNTIME $HEIGHT >> data/exp2_java_data.dat
    echo $SIZE, $RUNTIME, $HEIGHT >> data/exp2_java_data.csv

done

done

done
