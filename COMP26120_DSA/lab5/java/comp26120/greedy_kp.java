package comp26120;

import java.util.ArrayList;

public class greedy_kp extends KnapSack {

    public greedy_kp(String filename) {
	super(filename);
    }

    public static void main(String[] args) {
		greedy_kp knapsack = new greedy_kp(args[0]);
		knapsack.print_instance();
		knapsack.greedy();
    }

	private int check_eval(ArrayList<Boolean> sol) {
	
		int i; // index variable
		total_weight = 0; // total weight packed

		ArrayList<Integer> pack = new ArrayList<Integer>(Nitems); // auxiliary array to do reverse-mapping
		for (i = 0; i<=Nitems; i++) {
			pack.add(null); // Fill array with null objects
		}
	
		// First pass: unmap the mapping using pack
		for (i = 1; i <= Nitems; i++) {
			if (sol.get(i) != null && sol.get(i) == true) {
				pack.set(temp_indexes.get(i), 1);
			} else {
				pack.set(temp_indexes.get(i), 0);
			}
		}
		
		for (i = 1; i <= Nitems; i++) {
			if (pack.get(i) == 1) {
				total_weight += item_weights.get(i);
			}
		}

		return total_weight;
	
	}

    public void greedy() {
		int total_weight=0; // current total weight of the items in the knapsack
		int total_value=0; // current total profit of the items in the knapsack
		int i;
		ArrayList<Boolean> solution = new ArrayList<Boolean>(Nitems+1);
		// initialise the knapsack initially empty
			for (i = 0; i <= Nitems; i++) {
				solution.add(null);
			}
		i = 1;

		sort_by_ratio(); //sort items in descending profit-to-weight ratio order

		/* ADD CODE HERE TO COMPUTE THE GREEDY SOLUTION */

		/* THE CODE SHOULD: take the items in descending 
		profit-to-weight ratio order (by using temp_indexes) and, 
		if an item fits, add it to the knapsack, and 
		do not stop at the first item that doesn't fit 
		- but keep going until all items have been tried */

		// at this point, the sorted thingy is the temp_index
		while (true) {

			// copy the current solution to check feasibility
			// feasible ? update the solution : ignore
			ArrayList<Boolean> temp_solution = new ArrayList<Boolean>(Nitems + 1);
			temp_solution.addAll(solution);
			temp_solution.set(i, true);

			// if temp solution feasible, update the solution set
			// use helper method that copy the check_evaluate_and_print_sol
			if (this.check_eval(temp_solution) <= Capacity) {
				solution.set(i, true);
			} else {
				solution.set(i, false);
			}

			i++;
			if (i == (Nitems + 1)) {
				break;
			}
		}

		System.out.println("The greedy solution - not necessarily optimal - is:");
		check_evaluate_and_print_sol(solution);

		/* NOTE: If the result you get when you use the check_ ...() function
			is not what you expected, it could be because you mapped
			to the sorted order TWICE.
			Use 
				solution[i]=1; 
			in order to "pack" the ith most value-dense item, 
			not solution[temp_index[i]];
		*/


    }
}
