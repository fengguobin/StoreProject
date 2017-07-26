package cn.it.store.entity;

public class OrderItem {
	private int id;
	private String product_name;
	private double product_price;
	private String product_img;
	private int count;
	private double itemTotalPrice;
	private String order_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public double getProduct_price() {
		return product_price;
	}
	public void setProduct_price(double product_price) {
		this.product_price = product_price;
	}
	public int getCount() {
		return count;
	}
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getItemTotalPrice() {
		return itemTotalPrice;
	}
	public void setItemTotalPrice(double itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	
	
}
