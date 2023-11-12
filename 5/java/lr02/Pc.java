import java.util.Date;

class Pc {
    public Integer id;
    public String vendor;
    public String cpu;
    public Double freq;
    public Integer ram;
    public Integer storage;
    public Date release;
    public Double cost;
    public Integer count;

	public static Integer getId(Pc a) {
		return a.id;
	}
	public static String getVendor(Pc a) {
        if (a.vendor == null)
            return "null";
		return a.vendor;
	}
	public static String getCpu(Pc a) {
        if (a.cpu == null)
            return "null";
		return a.cpu;
	}
	public static Double getFreq(Pc a) {
		return a.freq;
	}
	public static Integer getRam(Pc a) {
		return a.ram;
	}
	public static Integer getStorage(Pc a) {
		return a.storage;
	}
	public static Date getRelease(Pc a) {
		return a.release;
	}
	public static Double getCost(Pc a) {
		return a.cost;
	}
    public static Integer getCount(Pc a) {
		return a.count;
	}

	public static void setId(Pc a, Integer id) {
		a.id = id;
	}
	public static void setVendor(Pc a, String vendor) {
		a.vendor = vendor;
	}
	public static void setCpu(Pc a, String cpu) {
		a.cpu = cpu;
	}
	public static void setFreq(Pc a, Double freq) {
		a.freq = freq;
	}
	public static void setRam(Pc a, Integer ram) {
		a.ram = ram;
	}
	public static void setStorage(Pc a, Integer storage) {
		a.storage = storage;
	}
	public static void setRelease(Pc a, Date release) {
		a.release = release;
	}
	public static void setCost(Pc a, Double cost) {
		a.cost = cost;
	}
	public static void setCount(Pc a, Integer count) {
		a.count = count;
	}
}
