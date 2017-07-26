package cn.it.store.entity;

import java.util.Date;

public class Product {
	private int id;
	private String name;
	private double cprice;
	private double xprice;
	private String img;
	private Date createDate;
	private int hot;
	private String desc;
	private int state;
	private int category_id;
	private int company_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getCprice() {
		return cprice;
	}
	public void setCprice(double cprice) {
		this.cprice = cprice;
	}
	public double getXprice() {
		return xprice;
	}
	public void setXprice(double xprice) {
		this.xprice = xprice;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getHot() {
		return hot;
	}
	public void setHot(int hot) {
		this.hot = hot;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	
}
