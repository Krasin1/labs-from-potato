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
        MVector<Integer> arr = new MVector<Integer>(10);
        arr.append(0);
        arr.append(1);
        arr.append(2);
        arr.append(3);
        // arr.append(4);
        arr.pushFront(-2);

        System.out.println(arr.getSize());
        System.out.println(arr.at(4));

        // arr.removeElementAt(5);

        // System.out.println(arr.at(4));
        // System.out.println(arr.getSize());

        // SimpleDateFormat a = new SimpleDateFormat("yyyy-MM-dd");
        // String date = a.format(new Date());
        // System.out.println(date);
        // try {
        //     Date nah = a.parse("2022-01-12");
        //     // System.out.println("date is : " + a.format().parse("2023-10-09"));
        // } catch (ParseException e) { e.printStackTrace(); }
    }
}
