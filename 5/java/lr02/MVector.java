public class MVector<T> {

    @SuppressWarnings("unchecked")
    public MVector(int len) {
        if (len < 0) {
            System.out.println("Wrong length");
        } else if (len <= 500 && len >= 0) {
            this.capacity = len * 2;
        } else {
            this.capacity = (int)(len * 1.3);
        }
        this.size = len;
        this.array = (T[]) new Object[this.capacity];
    }

    public void setElementAt(T obj, int index) {
        this.array[index] = obj;
    }

    public T get(int index) {
        return this.array[index];
    }

    private int size;
    private int capacity;
    private T[] array;
}

