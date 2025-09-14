clear

javac comp26120/bnb_kp.java comp26120/bnb_kp.java comp26120/KnapSack.java
javac comp26120/dp_kp.java comp26120/dp_kp.java comp26120/KnapSack.java

echo "Time for DP"
java comp26120.dp_kp ../data/easy.20.txt
echo "Time for BNB"
java comp26120.bnb_kp ../data/easy.20.txt
echo "-------------------------------------------------"
echo "\n"

echo "Time for DP"
java comp26120.dp_kp ../data/easy.200.txt
echo "Time for BNB"
java comp26120.bnb_kp ../data/easy.200.txt
echo "-------------------------------------------------"
echo "\n"

echo "Time for DP"
java comp26120.dp_kp ../data/hard.200.txt
echo "Time for BNB"
java comp26120.bnb_kp ../data/hard.200.txt
echo "-------------------------------------------------"
echo "\n"

echo "Time for DP"
java comp26120.dp_kp ../data/hard.2000.txt
echo "Time for BNB"
java comp26120.bnb_kp ../data/hard.2000.txt
echo "-------------------------------------------------"
echo "\n"