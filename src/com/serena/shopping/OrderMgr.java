package com.serena.shopping;

import java.util.List;

import com.serena.shopping.dao.OrderDAO;
import com.serena.shopping.dao.OrderMySQLDAO;

public class OrderMgr {

	private static OrderMgr om = null;

	OrderDAO dao = null;

	static {
		if (om == null) {
			om = new OrderMgr();
			// you should read the config file to set the dao object
			om.setDao(new OrderMySQLDAO());
		}
	}

	private OrderMgr() {

	}

	public static OrderMgr getInstance() {
		return om;
	}

	public OrderDAO getDao() {
		return dao;
	}

	public void setDao(OrderDAO dao) {
		this.dao = dao;
	}

	public void saveOrder(SalesOrder so) {
		dao.saveOrder(so);
	}

	public int getOrders(List<SalesOrder> list, int pageNo, int pageSize) {
		return dao.getOrders(list, pageNo, pageSize);
	}

	public SalesOrder loadById(int id) {
		return dao.loadById(id);
	}

	public List<SalesItem> getSalesItems(SalesOrder salesOrder) {
		return dao.getSalesItems(salesOrder);
	}

	public void updateStatus(SalesOrder salesOrder) {
		dao.updateStatus(salesOrder);
	}
}
