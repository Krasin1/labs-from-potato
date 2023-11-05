
import java.lang.*;
import java.util.*;

public class MVector<T> {

    @SuppressWarnings("unchecked")
    public MVector(int len) {
        this.capacity = len;
        this.size = 0;
        this.array = (T[]) new Object[this.capacity];
    }

    public void append(T obj) {
        ensureCapacity(this.size + 1);
        this.array[this.size++] = obj;
    }

    @SuppressWarnings("unchecked")
    public void pushFront(T obj) {
        ensureCapacity(this.size + 1);
        T[] temp = (T[]) new Object[this.capacity];
        temp[0] = obj;
        for (int i = 1; i <= this.size; i++) 
            temp[i] = this.array[i - 1];
        this.array = temp;
        this.size++;
    }

    @SuppressWarnings("unchecked")
    public void insertElementAt(T obj, int index) {
        if (index < 0 || index >= this.size) 
            throw new NoSuchElementException("Index out of array");

        ensureCapacity(this.size + 1);
        T[] temp = (T[]) new Object[this.capacity];

        for(int i = 0; i < index; ++i) 
            temp[i] = this.array[i];

        temp[index] = obj;
        for(int i = index + 1; i <= this.size; ++i) 
            temp[i] = this.array[i - 1];

        this.array = temp;
        this.size++;
    }

    @SuppressWarnings("unchecked")
    public void removeElementAt(int index) {
        if (index < 0 || index >= this.size) 
            throw new NoSuchElementException("Index out of array");

        T[] temp = (T[]) new Object[this.capacity];

        for(int i = 0; i < index; ++i) 
            temp[i] = this.array[i];
        for(int i = index + 1; i < this.size; ++i) 
            temp[i - 1] = this.array[i];

        this.array = temp;
        this.size--;
    }

    public void setElementAt(T obj, int index) {
        if (index >= this.size || index < 0) 
            throw new IllegalArgumentException("Wrong index");
        this.array[index] = obj;
    }

    public T at(int index) {
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

    private int size;
	private int capacity;
	private T[] array;
}

