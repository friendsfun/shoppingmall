package com.serena.shopping.dao;

import java.util.List;

import com.serena.shopping.SalesItem;
import com.serena.shopping.SalesOrder;

public interface OrderDAO {

	void saveOrder(SalesOrder so);

	int getOrders(List<SalesOrder> list, int pageNo, int pageSize);

	int getOrdersByUserid(List<SalesOrder> list, int pageNo, int pageSize, int userid);

	SalesOrder loadById(int id);

	List<SalesItem> getSalesItems(SalesOrder salesOrder);

	void updateStatus(SalesOrder salesOrder);
}
