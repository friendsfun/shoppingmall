package com.serena.shopping;

import java.sql.Timestamp;
import java.util.List;

import com.serena.shopping.dao.ProductDAO;
import com.serena.shopping.dao.ProductMySQLDAO;

public class ProductMgr {

	private static ProductMgr pm = null;

	ProductDAO dao = null;

	static {
		if (pm == null) {
			pm = new ProductMgr();
			// you should read the config file to set the dao object
			pm.setDao(new ProductMySQLDAO());
		}
	}

	private ProductMgr() {

	}

	public static ProductMgr getInstance() {
		return pm;
	}

	public ProductDAO getDao() {
		return dao;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}

	public List<Product> getProducts() {
		return dao.getProducts();
	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		return dao.getProducts(pageNo, pageSize);
	}

	/*
	 * @param products
	 * 
	 * @param pageNo
	 * 
	 * @param pageSize
	 * 
	 * @return page counts of the specific pageSize
	 */

	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		return dao.getProducts(products, pageNo, pageSize);
	}

	public int findProducts(List<Product> list, int[] categoryId, String keyword, double lowNormalPrice,
			double highNormalPrice, double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize) {
		return dao.findProducts(list, categoryId, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice,
				highMemberPrice, startDate, endDate, pageNo, pageSize);
	}

	public int findProducts(List<Product> list, int[] categoryId, String keyword, int pageNo, int pageSize) {
		return dao.findProducts(list, categoryId, keyword, -1, -1, -1, -1, null, null, pageNo, pageSize);
	}

	public boolean deleteProductByCategoryId(int categoryId) {
		return dao.deleteProductByCategoryId(categoryId);
	}

	public boolean deleteProductById(int id) {
		return dao.deleteProductById(id);

	}

	public boolean updateProduct(Product p) {
		return dao.updateProduct(p);
	}

	public boolean addProduct(Product p) {
		return dao.addProduct(p);
	}

	public Product loadById(int id) {
		return dao.loadById(id);
	}

	public List<Product> getLatestProducts(int count) {
		return dao.getLatestProducts(count);
	}

	public List<Product> getBestsellerProducts(int count) {
		return dao.getBestsellerProducts(count);
	}
	
	public List<Product> getProductsByTopCategoryid(int topCategoryid) {
		return dao.getProductsByTopCategoryid(topCategoryid);
	}
	
	public List<Product> getProductsBySubCategoryid(int subCategoryid) {
		return dao.getProductsBySubCategoryid(subCategoryid);
	}
}
