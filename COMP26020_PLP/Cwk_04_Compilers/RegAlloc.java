import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Scanner;
import java.util.Comparator;

import java.io.File;
import java.io.FileWriter;

public class RegAlloc {
    private ArrayList<ArrayList<Integer>> data_from_file;
    private ArrayList<Character> solution;
    private int problem_size;
    private String output_path;

    /**
     * Default constructor, which initialises the ArrayLists and read the content of input file
     * 
     * @param filename_in The filepath of input file
     * @param filename_out The filepath of output file
     */
    public RegAlloc(String filename_in, String filename_out) {
        // setup the arraylist
        this.data_from_file = new ArrayList<ArrayList<Integer>>();
        this.solution = new ArrayList<Character>();

        // read data into the arraylist
        this.problem_size = this.read_file(filename_in);

        // save output path, ignore input as it is used immediately
        this.output_path = filename_out;

        // setup the solution set with null
        for (int i = 0; i < this.problem_size + 1; i++) {
            this.solution.add(null);
        }
    }

    /**
     * Print data read from the file
     */
    public void get_array_info() {
        for (ArrayList<Integer> list : this.data_from_file) {
            System.out.println(list.toString());
        }
    }

    /**
     * Main method to run the solution finding algortihm, combining methods - O(N^2)
     * 
     * @return Solution array
     */
    public void run() {

        // bound checking,number of nodes check - O(N^2)
        if (!this.initial_bound_check()) {
            System.out.println("Node number is greater than number of nodes in the graph");
            throw new IllegalArgumentException();
        }

        // solve problem - O(N^2)
        Boolean stat_check = this.solve_prob();
        if (stat_check) {
            for (int i = 1; i < solution.size(); i++) {
                System.out.println(Integer.toString(i) + Character.toString(this.solution.get(i)));
            }
            // write complexity - O(N)
            this.write_file(output_path);
            System.out.println("The solution has been written to " + this.output_path);
        } 
    }

    /**
     * Check for undefined nodes in the input file
     * @return True if everything is properly defined, False if there is undefined nodes
     */
    private Boolean initial_bound_check() {
        //get defined nodes - O(N)
        ArrayList<Integer> defined_nodes = new ArrayList<Integer>();
        for (ArrayList<Integer> iterable_element : this.data_from_file) {
            defined_nodes.add(iterable_element.get(0));
        }

        // check undefined nodes - O(N^2)
        for (ArrayList<Integer> iterable_element : this.data_from_file) {
            for (Integer integer : iterable_element) {
                if (!defined_nodes.contains(integer)) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Takes a string with comma delimeter and change it into Integer list, helper method for file reader
     * 
     * @param data The string with comma delimeter
     * @return A list of Integer from the String, separated by the comma delimiter
     */
    private Integer[] break_string_to_integer(String data) {
        Integer[] broken_string = Arrays.stream(data.split(",")).mapToInt(Integer::parseInt).boxed().toArray(Integer[]::new);
        return broken_string;
    }

    /**
     * Read the document from given string and turn it into 2-dimensional ArrayList of Integer, sort based of size of inner list
     * 
     * @param filename The filepath of input file
     */
    private int read_file(String filename) {
        try (Scanner file_reader = new Scanner(new File(filename))) {
            // read the input file
            while (file_reader.hasNextLine()) {
                String data_stream = file_reader.nextLine();
                ArrayList<Integer> interm_store = new ArrayList<Integer>(Arrays.asList(this.break_string_to_integer(data_stream)));
                this.data_from_file.add(interm_store);
            }
            file_reader.close();

            // sort based on size of items in the ArrayList by using custom comparator (desc)
            Collections.sort(this.data_from_file, new Comparator<ArrayList<Integer>>() {
                @Override
                public int compare(ArrayList<Integer> list_one, ArrayList<Integer> list_two) {
                    return Integer.compare(list_two.size(), list_one.size());
                }
            });

        } catch (Exception e) {
            System.out.println("Exception in read");
            System.out.println(e);
        }
        return this.data_from_file.size();
    }

    /**
     * Write the solution ArrayLIst in given format index+solution - O(N)
     * 
     * @param filename The filepath of output file
     */
    private void write_file(String filename) {
        try (FileWriter file_writer = new FileWriter(new File(filename))) {
            for (int i = 1; i < solution.size(); i++) {
                file_writer.write(Integer.toString(i) + Character.toString(solution.get(i)) + "\n");
            }
            file_writer.close();
        } catch (Exception e) {
            System.out.println("Exception in write");
            System.out.println(e);
        }
    }

    /**
     * Find available character to be assigned to a particular node, helper method for solve_prob - O(N)
     * 
     * @param node_conflict A list of conflicting node for a prticular node
     * @return Appropriate character for assignment
     */
    private Character check_available_char(ArrayList<Integer> node_conflict) {
        
        // check used character, build a list for used character - O(N)
        ArrayList<Character> char_used = new ArrayList<Character>();
        for (Integer node_number : node_conflict) {
            if (this.solution.get(node_number) != null) {
                char_used.add(this.solution.get(node_number));
            }
        }

        // base case - there is no used characters - O(1)
        if (char_used.size() == 0) {
            return 'A';
        }

        // step case - there is some used characters - O(26N) == O(N)
        for (int i = 65; i <= 90; i++) {
            Character c_comp = (char) i;
            if (!char_used.contains(c_comp)) {
                return c_comp;
            }
        }

        // final case - all characters are used - O(1)
        return null;
    }
    
    /**
     * Assign characters for ech node in the problem - O(N^2)
     */
    private Boolean solve_prob() {
        for (int i = 0; i < this.problem_size; i++) {
            int node_index = this.data_from_file.get(i).get(0);
            ArrayList<Integer> node_conflict = new ArrayList<Integer>(this.data_from_file.get(i).subList(1, this.data_from_file.get(i).size()));
            Character avail_char = this.check_available_char(node_conflict);
            
            if (avail_char != null) {
                this.solution.set(node_index, avail_char);
            } else {
                System.out.println("Solution not available ! Exiting ...");
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        RegAlloc test = new RegAlloc(args[0], args[1]);
        test.run();
    }
}