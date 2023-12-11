package lab.course.model;

public class Product {
    private Integer id;
	private String product_name;
    private String barcode;
    private Integer count_in_stok;
	private Integer price;
    private Integer count;

    public Product(Integer id, String name, String barcode,
            Integer count_in_stok, Integer price, Integer count) {
        this.id = id;
        this.product_name = name;
        this.barcode = barcode;
        this.count_in_stok = count_in_stok;
        this.price = price;
        this.count = count;
    }

    public Integer getCount_in_stok() {
		return count_in_stok;
	}
	public void setCount_in_stok(Integer count_in_stok) {
		this.count_in_stok = count_in_stok;
	}
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
}
