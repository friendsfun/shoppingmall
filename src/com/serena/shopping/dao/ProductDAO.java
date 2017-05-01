package com.serena.shopping.dao;

import java.sql.Timestamp;
import java.util.List;

import com.serena.shopping.Product;

public interface ProductDAO {

	public List<Product> getProducts();

	public List<Product> getProducts(int pageNo, int pageSize);

	public int getProducts(List<Product> list, int pageNo, int pageSize);

	public int findProducts(List<Product> list, int[] categoryId, String keyword, double lowNormalPrice,
			double highNormalPrice, double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize);

	public boolean deleteProductByCategoryId(int categoryId);

	public boolean deleteProductById(int id);

	public boolean updateProduct(Product p);

	public boolean addProduct(Product p);

	public Product loadById(int id);

	public List<Product> getLatestProducts(int count);

	public List<Product> getBestsellerProducts(int count);
	
	public List<Product> getProductsByTopCategoryid(int topCategoryid);
	
	public List<Product> getProductsBySubCategoryid(int subCategoryid);
}
