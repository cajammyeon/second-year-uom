import java.util.ArrayList;
import java.util.Scanner;
import java.io.File;

/*
 * Model for Branch Target Buffer (BTB)
 * 
 * Cache all types (conditional and unconditional branches)
 * Cache only taken when first encountered 
 * Cache only backward branches
 * 
 * Experiment with small cache size with cache line size = 1
 * Assume taken if backward, not taken of forward branch
 */
public class Model {
    ArrayList<Long> branch_address;
    ArrayList<Long> target_address;
    ArrayList<Integer> hysteresis;
    int insert_pointer;

    /**
     * Constructor method
     * @param size size of cache to be built
     */
    Model(int size) {
        this.branch_address = new ArrayList<Long>();
        this.target_address = new ArrayList<Long>();
        this.hysteresis = new ArrayList<Integer>();
        this.insert_pointer = 0;

        // fill in the arrays
        for (int i = 0; i < size; i++) {
            this.branch_address.add(0L);
            this.target_address.add(0L);
        }
    }

    /**
     * Helper method for add_target_address
     */
    private void increment_pointer() {
        this.insert_pointer += 1;
        if (this.insert_pointer == this.branch_address.size()) {
            this.insert_pointer = 0;
        }
    }

    /**
     * Insert new branch into the cache
     * @param branch_address_in address to be inserted
     * @param taken_cond condition whether or not the branch is taken
     */
    private void add_target_address(Long branch_address_in, Long target_address_in, Boolean branch_decision, String branch_direction) {
        if (branch_decision & branch_direction.equals("B")) {
            this.branch_address.set(insert_pointer, branch_address_in);
            this.target_address.set(insert_pointer, target_address_in);
            this.increment_pointer();
        }   
    }

    /**
     * Search for the given address in tag field
     * @param branch_to_search address to bea searched in tag field
     * @return if the address is in cache, return the condition (taken or not taken), -1 otherwise
     */
    private Boolean branch_decider(Long branch_to_search) {
        for (int i = 0; i < this.branch_address.size(); i++) {
            if (this.branch_address.get(i).equals(branch_to_search)) {
                return true;
            }
        }
        return false;
    }

    public Boolean run_branch(Long branch_to_search) {
        Boolean branch_taken = this.branch_decider(branch_to_search);
        if (branch_taken) {
            return true;
        } else {
            this.add_target_address(branch_to_search, target_address, branch_condition, branch_direction);
            return false;
        }
    }

}
