STATES="sorted reverse none"
SIZES="10000 20000 30000 40000 50000"

for STATE in $STATES
do

for SIZE in $SIZES
do

echo $SIZE

for COUNT in 1 2 3 4 5
do
    python3 ../data/generate.py input_dict dictionaries_and_queries/dict_${SIZE}_${STATE}_$COUNT dictionaries_and_queries/empty_query $SIZE 0 $STATE 0    
done

done

done
