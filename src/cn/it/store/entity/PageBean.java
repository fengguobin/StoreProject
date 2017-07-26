package cn.it.store.entity;

import java.util.List;

public class PageBean<T> {
	private int currPage;
	private int totalPage;
	private int totalRecord;
	private int size=2;
	private int stratIndex;
	private List<T> data;
	public PageBean() {
	}
	public PageBean(int currPage, int totalRecord, int size) {
		super();
		this.currPage = currPage;
		this.totalRecord = totalRecord;
		this.size = size;
	}
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int getTotalPage() {
		if(totalRecord%size==0)
		{
			return (int) (totalRecord/size);
		}else
		{
			return (int) (totalRecord/size+1);
		}
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getStratIndex() {
		return (currPage-1)*size;
	}
	public void setStratIndex(int stratIndex) {
		this.stratIndex = stratIndex;
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	
	
	
}
