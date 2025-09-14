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
public class BranchPredictor_Hysteresis {
    ArrayList<Long> branch_address;
    ArrayList<Long> target_address;
    ArrayList<Integer> extra_info;
    int insert_pointer;

    /**
     * Constructor method
     * @param size size of cache to be built
     */
    BranchPredictor_Hysteresis(int size) {
        this.branch_address = new ArrayList<Long>();
        this.target_address = new ArrayList<Long>();
        this.extra_info = new ArrayList<Integer>();
        this.insert_pointer = 0;

        // fill in the arrays
        for (int i = 0; i < size; i++) {
            this.branch_address.add(0L);
            this.target_address.add(0L);
            this.extra_info.add(1);
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
    private void add_target_address(Long branch_address_in, Long target_address_in) {
        this.branch_address.set(insert_pointer, branch_address_in);
        this.target_address.set(insert_pointer, target_address_in);
        this.extra_info.set(insert_pointer, 1);
        this.increment_pointer();
    }

    /**
     * Search for the given address in tag field
     * @param branch_to_search address to bea searched in tag field
     * @return if the address is in cache, return the condition (taken or not taken), -1 otherwise
     */
    private int search_address_in_btb(Long branch_to_search) {
        for (int i = 0; i < this.branch_address.size(); i++) {
            if (this.branch_address.get(i).equals(branch_to_search)) {
                return i;
            }
        }
        return -1;
    }

    private void update_saturating_counter(int index_addr, Boolean taken_cond) {
        if (taken_cond) {
            if (this.extra_info.get(index_addr) < 3) {
                this.extra_info.set(index_addr, this.extra_info.get(index_addr) + 1);
            }
        } else {
            if (this.extra_info.get(index_addr) > 0) {
                this.extra_info.set(index_addr, this.extra_info.get(index_addr) - 1);
            }
        }
    }

    /**
     * Combiner method, combine all method required for the model and simplify the return
     * @param origin_address address to be checked
     * @param move_direction backward or forward branch, to decide whether to cache
     * @return true if there is a hit, false otherwise - assume that always hit if the address in cache
     */
    private Boolean branch_decider(Long origin_address, Long branch_target, String move_direction, Boolean taken_cond) {
        int index_addr = this.search_address_in_btb(origin_address);
        if (index_addr < 0) {
            if (move_direction.equals("B") && taken_cond) {
                this.add_target_address(origin_address, branch_target);
            }
            return false;
        }

        // get return result
        int ret_result = this.extra_info.get(index_addr);

        // update hysteresis
        this.update_saturating_counter(index_addr, taken_cond);

        // return value
        return (ret_result > 1) ? true : false;
    }

    /**
     * Act as main entrance point for the code, will call branch decider
     * @param filename location of trace file
     */
    public float read_trace(String filename) {

        float correct = 0;
        float wrong = 0;

        try (Scanner file_scanner = new Scanner(new File(filename))) {
            while (file_scanner.hasNextLine()) {
                // read the trace file
                String[] trace_read = file_scanner.nextLine().trim().split(" ");
                
                // only consider invariant branch
                if (trace_read[0].equals("B")) {
                    Long orig_addr = Long.parseLong(trace_read[2], 16);
                    Long targ_addr = Long.parseLong(trace_read[4], 16);

                    String move_dirt = trace_read[5];

                    Boolean real_dec = trace_read[7].equals("not") ? false : true;
                    Boolean cache_result = this.branch_decider(orig_addr, targ_addr, move_dirt, real_dec);

                    // taken - fetched
                    if (cache_result == real_dec) {
                        correct += 1;
                    } else {
                        wrong += 1;
                    }
                } 
            }
        } catch (Exception e) {
            System.out.println(e);        
        }

        return (float)(((3423933 + (wrong * 2)) / 3423933) * 100);

    } 

    public static void main(String[] args) {
        BranchPredictor_Hysteresis branchPred = new BranchPredictor_Hysteresis(30);
        branchPred.read_trace("block_profile");
    }
}
