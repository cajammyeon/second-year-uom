package comp26120;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class TestDataCollection extends dp_kp {
    ArrayList<Long> time_average;
    int persession_length = 5;
    int test_size = 200;
    int multiplier = 100;

    TestDataCollection(String filename) {
        super(filename);
        this.time_average = new ArrayList<Long>();
    }

    private long test_time() {
        long starttime = System.nanoTime();
        this.DP();
        long stoptime = System.nanoTime();

        return (stoptime - starttime);
    }

    private void loop_test() {
        long total_time = 0;
        for (int i = 0; i < this.persession_length; i++) {
            total_time += test_time();
        }
        time_average.add(total_time / persession_length);
    }

    private void change_attr_and_collect_data() {
        for (int i = 1; i < this.test_size; i++) {
            this.Capacity = i * multiplier;
	        System.out.println("Testing for capacity : " + String.valueOf(this.Capacity));
            this.loop_test();
        }
        this.data_write();
    }

    private void data_write() {
        try (FileWriter writer = new FileWriter("test_data.csv")) {
            for (int i = 1; i < time_average.size(); i++) {
                String wrt = String.valueOf(i * multiplier) + ", " + String.valueOf(time_average.get(i)) + "\n";
                writer.write(wrt);
            }
        } catch (IOException e) {
            System.out.println("Error while writing");
        }
        
    }

    public static void main(String[] args) {
        TestDataCollection data_collection = new TestDataCollection("../data/easy.200.txt");
        data_collection.change_attr_and_collect_data();
    }
    
}
