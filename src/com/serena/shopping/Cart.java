package com.serena.shopping;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<CartItem> items = new ArrayList<CartItem>();

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}

	public void add(CartItem item) {
		for (int i = 0; i < items.size(); i++) {
			CartItem ci = items.get(i);
			if (item.getProduct().getId() == ci.getProduct().getId()) {
				ci.setCount(ci.getCount() + 1);
				return;
			}
		}
		items.add(item);
	}
	
	public void remove(int pid) {
		for (int i = 0; i < items.size(); i++) {
			CartItem ci = items.get(i);
			if (pid == ci.getProduct().getId()) {
				items.remove(i);
				return;
			}
		}
	}

	public double getTotalPrice() {
		double totalPrice = 0;
		for (int i = 0; i < items.size(); i++) {
			CartItem ci = items.get(i);
			totalPrice = totalPrice + ci.getTotalPrice();
		}
		return totalPrice;
	}
}
