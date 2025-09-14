import java.util.Arrays;
import java.util.Scanner;
import java.io.File;

public class Branch {

    Branch(){}

    public void number_at_ninety() {
        try (Scanner scanner = new Scanner(new File("sorted_prof.txt"))) {
            Integer total_access = 0;
            Integer total_instruction = 0;

            while (total_access < 3081539.7) {
                String[] line = scanner.nextLine().trim().split(" ");
                total_access += Integer.parseInt(line[0]);
                total_instruction += 1;
            }

            System.out.println("Total instruction at 90% accesses : " + total_instruction.toString());
            System.out.println("Total amount of access at 90% : " + total_access.toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void count_exec_taken() {
        try (Scanner scanner = new Scanner(new File("block_profile"))) {
            Integer total_not = 0;
            Integer total_line = 0;

            while (scanner.hasNextLine()) {
                String[] line = scanner.nextLine().trim().split(" ");
                for (String string : line) {
                    if (string.equals("not")) {
                        total_not += 1;
                        break;
                    }
                }
                total_line += 1;
            }

            System.out.println("Total branch taken : " + ((Integer)(total_line - total_not)).toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void calculate_invariant() {
        try (Scanner scanner = new Scanner(new File("block_profile"))) {
            Integer total_invariant = 0;
            Integer total_branches = 0;

            while (scanner.hasNextLine()) {
                String line = (scanner.nextLine().trim().split(" "))[0];
                if (line.equals("B")) {
                    total_invariant += 1;
                }
                total_branches += 1;
            }

            System.out.println("Total branches taken : " + ((total_branches)).toString());
            System.out.println("Total invariant branch : " + ((total_invariant)).toString());

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        Branch b = new Branch();
        b.number_at_ninety();
    }
}