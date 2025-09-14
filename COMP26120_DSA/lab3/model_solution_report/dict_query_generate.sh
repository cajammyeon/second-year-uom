SIZES="1000 2000 3000 4000 5000 6000 7000 8000 9000"
# SIZES="10000 20000 30000 40000 50000 60000 70000 80000 90000 100000"

QUERY_SIZES="20000 40000 60000 80000 100000"

for SIZE in $SIZES
do

for QUERY_SIZE in $QUERY_SIZES
do

echo $QUERY_SIZE

for COUNT in 1 2 3 4 5
do

     python3 generate.py input_dict dictionaries_and_queries/dict_${SIZE}_${QUERY_SIZE}_$COUNT dictionaries_and_queries/query_${SIZE}_${QUERY_SIZE}_$COUNT $SIZE ${QUERY_SIZE} none 50


done

done

done
