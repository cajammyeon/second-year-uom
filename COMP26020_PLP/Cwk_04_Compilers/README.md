## COMPILATION
javac RegAlloc.java

## EXECUTION
java RegAlloc input-path output-path

## ERROR HANDLING
The program will throw some exceptions :
#### IllegalArgumentException
When number of nodes (labelled as problem_size) is smaller than one of the node defined the interference graph, it means the input file has some undefined nodes. \
Example : \
1,2,3,4 \
2,1,3 \
3,1,2 \
In this example, 4 is one of the node in the interference graph but not defined by the input.

#### FileNotFoundExcpetion
Input file was not found, no data can be read.