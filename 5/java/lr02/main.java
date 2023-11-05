import java.util.*;
import java.text.*;

class Pc {
    public int id;
    public String vendor;
    public String cpu;
    public int freq;
    public short ram;
    public int storage;
    public Date release;
    public int cost;
    public int count;
}

class Main {
    public static void main(String[] args){
        // MVector<int> arr = new MVector<int>(10);
        MVector<int> arr = new MVector(10);
        arr.setElementAt(1, 0);
        System.out.println(arr.get(0));
        // SimpleDateFormat a = new SimpleDateFormat("yyyy-MM-dd");
        // String date = a.format(new Date());
        // System.out.println(date);
        // try {
        //     Date nah = a.parse("2022-01-12");
        //     // System.out.println("date is : " + a.format().parse("2023-10-09"));
        // } catch (ParseException e) { e.printStackTrace(); }
    }
}
