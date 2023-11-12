
import java.util.function.Function;
import java.util.function.BiConsumer;
import java.util.*;
import java.text.*;
import java.lang.*;
import java.util.*;


public class MVector {

    public MVector(int len) {
        this.capacity = len;
        this.size = 0;
        this.array = new Pc[this.capacity];
    }

    public void append(Pc obj) {
        ensureCapacity(this.size + 1);
        this.array[this.size++] = obj;
    }

    public void pushFront(Pc obj) {
        ensureCapacity(this.size + 1);
        Pc[] temp = new Pc[this.capacity];
        temp[0] = obj;
        for (int i = 1; i <= this.size; i++) 
            temp[i] = this.array[i - 1];
        this.array = temp;
        this.size++;
    }

    public void insertElementAt(Pc obj, int index) {
        if (index < 0 || index >= this.size) 
            throw new NoSuchElementException("Index out of array");

        ensureCapacity(this.size + 1);
        Pc[] temp = new Pc[this.capacity];

        for(int i = 0; i < index; ++i) 
            temp[i] = this.array[i];

        temp[index] = obj;
        for(int i = index + 1; i <= this.size; ++i) 
            temp[i] = this.array[i - 1];

        this.array = temp;
        this.size++;
    }

    public void removeElementAt(int index) {
        if (index < 0 || index >= this.size) 
            throw new NoSuchElementException("Index out of array");

        Pc[] temp = new Pc[this.capacity];

        for(int i = 0; i < index; ++i) 
            temp[i] = this.array[i];
        for(int i = index + 1; i < this.size; ++i) 
            temp[i - 1] = this.array[i];

        this.array = temp;
        this.size--;
    }

    public <J> Integer find(Pc arr[], J value, Function<Pc, J> getter) {
        for (int i = 0; i < arr.length - 1; ++i) {
            if (getter.apply(arr[i]) == value) 
                return i;
        }
        return -1;
    }
    
    public Integer findCpu(String value) {
        Function<Pc, String> getter = x -> Pc.getCpu(x);
        return this.find(this.array, value, getter);
    }

    public Integer findRam(Integer value) {
        Function<Pc, Integer> getter = x -> Pc.getRam(x);
        return this.find(this.array, value, getter);
    }
    public Integer findRelease(Date value) {
        Function<Pc, Date> getter = x -> Pc.getRelease(x);
        return this.find(this.array, value, getter);
    }

    public void sortCpu(){
        Function<Pc, String> getter = x -> Pc.getCpu(x);
        BiConsumer<Pc, String> setter = (pc, val) -> Pc.setCpu(pc, val);
        this.sort(this.array, 0, size - 1, getter, setter);
    }
    public void sortRam(){
        Function<Pc, Integer> getter = x -> Pc.getRam(x);
        BiConsumer<Pc, Integer> setter = (pc, val) -> Pc.setRam(pc, val);
        this.sort(this.array, 0, size - 1, getter, setter);
    }
    public void sortRelease(){
        Function<Pc, Date> getter = x -> Pc.getRelease(x);
        BiConsumer<Pc, Date> setter = (pc, val) -> Pc.setRelease(pc, val);
        this.sort(this.array, 0, size - 1, getter, setter);
    }

    public <J extends Comparable<J>> void sort(Pc arr[], int begin, int end, Function<Pc, J> getter, BiConsumer<Pc, J>  setter) {
        if (begin < end) {
            int partitionIndex = partition(arr, begin, end, getter, setter);

            sort(arr, begin, partitionIndex-1,getter, setter);
            sort(arr, partitionIndex+1, end,getter, setter);
        }
    }

    private <J extends Comparable<J>> int partition(Pc arr[], int begin, int end, Function<Pc, J> getter, BiConsumer<Pc, J> setter) {
        var pivot = getter.apply(arr[end]);
        int i = (begin-1);
        for (int j = begin; j < end; j++) {
            Integer compare = getter.apply(arr[j]).compareTo(pivot);

            if (compare <= 0) {
                i++;
                var swapTemp = arr[i];
                arr[i] = arr[j];
                arr[j] = swapTemp;
            }
        }
        var swapTemp = arr[i+1];
        arr[i+1] = arr[end];
        arr[end] = swapTemp;

        return i+1;
    }

    public void setElementAt(Pc obj, int index) {
        if (index >= this.size || index < 0) 
            throw new IllegalArgumentException("Wrong index");
        this.array[index] = obj;
    }

    public Pc at(int index) {
        if (index < 0 || index >= this.size) 
            throw new NoSuchElementException("Wrong index");
        return this.array[index];
    }
    
    public int getSize() {
		return this.size;
    }

    public int getCapacity() {
		return this.capacity;
	}

	public Pc[] getArray() {
		return array;
	}

    public void ensureCapacity(int cap) {
        if (this.capacity >= cap) 
            return;

        if (cap < 0) 
            throw new IllegalArgumentException("Wrong capacity");
        else if (cap <= 500) 
            this.capacity = cap * 2;
        else 
            this.capacity = (int)(cap * 1.3);
    }

    public void printAll() {
        System.out.println("");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println("* Характеристики компьютера:");
        System.out.println("* 1)ID  2)Производитель  3)Процессор  4)Частота  5)ОЗУ  6)HDD  7)Дата выхода  8)Цена  9)Кол-во ");
        for(int i = 0; i < this.size; ++i) {
            System.out.print("1)" + this.array[i].id + "  2)" + this.array[i].vendor + "  3)" + this.array[i].cpu + "  4)" );
            System.out.print(this.array[i].freq + "  5)" + this.array[i].ram + "  6)" + this.array[i].storage + " 7)");
            if (this.array[i].release == null) 
                System.out.print("null  8)");
            else    
                System.out.print(format.format(this.array[i].release) + "  8)");
            System.out.println(this.array[i].cost + "  9)" + this.array[i].count);
        }
    }

    private int size;
	private int capacity;
	private Pc[] array;

}

