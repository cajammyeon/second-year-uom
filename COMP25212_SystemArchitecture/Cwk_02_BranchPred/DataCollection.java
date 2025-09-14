import java.io.FileWriter;
import java.util.ArrayList;

public class DataCollection {

    public static void main(String[] args) {
        ArrayList<Float> data = new ArrayList<Float>();
        ArrayList<Float> data_hysteresis = new ArrayList<Float>();

        for (int i = 1; i < 201; i++) {
            BranchPredictor data_collector = new BranchPredictor(i);
            data.add(data_collector.read_trace("block_profile"));

            BranchPredictor_Hysteresis data_hysteresis_obj = new BranchPredictor_Hysteresis(i);
            data_hysteresis.add(data_hysteresis_obj.read_trace("block_profile"));
        }
        try (FileWriter file_writer = new FileWriter("data_collection.txt")) {
            for (Float float1 : data) {
                file_writer.write(float1.toString() + "\n");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        try (FileWriter file_writer = new FileWriter("data_hysteresis.txt")) {
            for (Float float1 : data_hysteresis) {
                file_writer.write(float1.toString() + "\n");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
