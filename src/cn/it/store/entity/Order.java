package cn.it.store.entity;

import java.util.ArrayList;
import java.util.List;

public class Order {
	private String id;
	private double totalPrice;
	private int state;
	private String address;
	private String name;
	private String telephone;
	private int user_id;
	private int company_id;
	private List<OrderItem> orderItems=new ArrayList<OrderItem>();
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<OrderItem> getOrderItems() {
		return orderItems;
	}
	public void setOrderItems(List<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	public double getTotalPrice() {
		if(!orderItems.isEmpty())
		{
			this.totalPrice=0;
			for(OrderItem orderItem:orderItems)
			{
				totalPrice+=orderItem.getItemTotalPrice();
			}
			
		}
		return this.totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	
}
