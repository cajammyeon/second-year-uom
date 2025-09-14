package comp26120;

import java.util.ArrayList;

public class dp_kp extends KnapSack {
    public dp_kp(String filename) {
	super(filename);
    }

    public ArrayList<Boolean> DP() {
	ArrayList<Integer> v = item_values;
	ArrayList<Integer> wv = item_weights;
	int n = Nitems;
	int W = Capacity;

	// Initialise the solution to an empty knapsack
	ArrayList<Boolean> solution = new ArrayList<Boolean>(Nitems+1);
	solution.add(null); // C implementation has null first object

	// the dynamic programming function for the knapsack problem
	// the code was adapted from p17 of http://www.es.ele.tue.nl/education/5MC10/solutions/knapsack.pdf

	// v array holds the values / profits / benefits of the items
	// wv array holds the sizes / weights of the items
	// n is the total number of items
	// W is the constraint (the weight capacity of the knapsack)
	// solution: a 1 in position n means pack item number n+1. A zero means do not pack it.

	ArrayList<ArrayList<Integer>> V = new ArrayList<ArrayList<Integer>>(n + 1);
	ArrayList<ArrayList<Boolean>> keep = new ArrayList<ArrayList<Boolean>>(n + 1);;// 2d arrays for use in the dynamic programming solution
	// keep[][] and V[][] are both of size (n+1)*(W+1)

	int i, w, K;

	// Initialise V and keep with null objects
	for (i = 0; i < (n + 1); i++) {
		ArrayList<Integer> insert_null = new ArrayList<Integer>(W + 1);
		for (int k = 0; k < (W + 1); k++) {
			insert_null.add(null);
		}
		V.add(insert_null);
	}
	for (i = 0; i < (n + 1); i++) {
		ArrayList<Boolean> insert_null = new ArrayList<Boolean>(W + 1);
		for (int k = 0; k < (W + 1); k++) {
			insert_null.add(null);
		}
		keep.add(insert_null);
	}
 
	//  set the values of the zeroth row of the partial solutions table to zero
	for (w = 0; w < (W + 1); w++) {
		V.get(0).set(w, 0);
	}

	// main dynamic programming loops , adding one item at a time and looping through weights from 0 to W
	for (i = 1; i < (n + 1); i++) {
		for (w = 0; w < (W + 1); w++) {
			if ((wv.get(i) <= w) && ((v.get(i) + V.get(i - 1).get(w - wv.get(i))) > (V.get(i - 1).get(w)))) {
				// calculate the new max weights
				int value_cal = v.get(i) + V.get(i - 1).get(w - wv.get(i));

				// update V and keep table
				V.get(i).set(w, value_cal);
				keep.get(i).set(w, true);
			} else {
				// update V and keep table
				V.get(i).set(w, V.get(i - 1).get(w));
				keep.get(i).set(w, false);
			}
		}
	}

	// now discover which items were in the optimal solution
	ArrayList<Integer> best_solution_unmapped = new ArrayList<Integer>();
	K = W;
	for (i = n; i > 0; i--) {
		if (keep.get(i).get(K)) {
			best_solution_unmapped.add(i);
			K = K - wv.get(i);
		}
	}

	// set the solution array to false
	for (i = 0; i < (n + 1); i++) {
		solution.add(false);
	}
	solution.set(0, null);

	// fix the solution array based on best_solution unmapped, map back to one hot encoding
	for (Integer integer : best_solution_unmapped) {
		solution.set(integer, true);
	}

	return solution;
    }
    
    public static void main(String[] args) {
	dp_kp knapsack = new dp_kp(args[0]);

	ArrayList<Boolean> solution = knapsack.DP();
	knapsack.check_evaluate_and_print_sol(solution);
    }
}
