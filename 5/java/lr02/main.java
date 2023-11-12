import java.util.function.Function;
import java.util.function.BiConsumer;
import java.util.Date;
import java.util.*;
import java.text.*;
import java.lang.*;

class Main {
    public static void main(String[] args){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        //*********************************
        Pc a = new Pc();
        a.id = 1;
        a.vendor = "a";
        a.cpu = "i3";
        a.freq = 4.2;
        a.ram = 8;
        a.storage = 256;
        try {
            a.release = format.parse("2021-01-12");
        } catch (ParseException e) { e.printStackTrace(); }
        a.cost = 32.5;
        a.count = 5;
        //*********************************
        Pc b = new Pc();
        b.id = 2;
        b.vendor = "b";
        b.cpu = "i5";
        b.freq = 4.7;
        b.ram = 16;
        b.storage = 512;
        try {
            b.release = format.parse("2022-01-12");
        } catch (ParseException e) { e.printStackTrace(); }
        b.cost = 55.5;
        b.count = 4;
        //*********************************
        Pc c = new Pc();
        c.id = 3;
        c.vendor = "c";
        c.cpu = "i7";
        c.freq = 5.1;
        c.ram = 64;
        c.storage = 1024;
        try {
            c.release = format.parse("2022-09-12");
        } catch (ParseException e) { e.printStackTrace(); }
        c.cost = 99.9;
        c.count = 1;
        //*********************************
        Function<Pc, String> g = x -> Pc.getVendor(x);
        BiConsumer<Pc, String> s = (pc, val) -> Pc.setVendor(pc, val);
        //********************************
        MVector arr = new MVector(10);
        arr.append(c);
        arr.append(b);
        arr.append(a);
        //*********************************
        arr.printAll();
        Integer index = arr.findCpu("i7");
        System.out.println(index);

        // arr.sort(arr.getArray(), 0, arr.getSize() - 1, g, s);
        arr.sortRelease();

        arr.printAll();
        index = arr.findCpu("i7");
        System.out.println(index);
        //*********************************
        
    }

}
