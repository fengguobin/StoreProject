package cn.it.store.entity;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class Cart {
	//键放product_id  值放CartItem
	private Map<String,CartItem> map=new LinkedHashMap<String,CartItem>();
	private double cartTotalPrice;
	private Collection<CartItem> cartItems;
	public Collection<CartItem> getCartItems() {
		return map.values();
	}
	//添加购物车项
	public void addCartItem(Product product,String count)
	{
		CartItem cartItem=map.get(product.getId()+"");
		if(cartItem==null)
		{
			cartItem=new CartItem(product,count);
			map.put(product.getId()+"", cartItem);
		}else
		{
			cartItem.setCount(cartItem.getCount()+1);
		}
	}
	//移除购物车项
	public void removeCartItem(String productId)
	{
		map.remove(productId);
	}
	//根据购物车中的购物车项获得购物车中商品的总价钱
	public double getCartTotalPrice() {
		cartTotalPrice=0;
		Set<Entry<String, CartItem>> entrySet = map.entrySet();
		for(Entry<String,CartItem> entry:entrySet)
		{
			CartItem cartItem = entry.getValue();
			cartTotalPrice+=cartItem.getItemTotalPrice();
		}
		return cartTotalPrice;
	}
	
}
