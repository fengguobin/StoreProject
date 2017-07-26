package cn.it.store.entity;

public class CartItem {
	//购物车项存放的商品
	private Product product;
	//购物车项存放商品的数量
	private int count;
	//单项购物车项的总价钱
	private double itemTotalPrice;
	
	public CartItem(Product product, String count) {
		// TODO Auto-generated constructor stub
		this.product=product;
		this.count=Integer.parseInt(count);
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getItemTotalPrice() {
		return product.getXprice()*count;
	}
	public void setItemTotalPrice(double itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
	}
	
}
