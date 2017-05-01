package com.serena.shopping.dao;

import java.sql.Timestamp;
import java.util.List;

import com.serena.shopping.Product;

public class ProductOracleDAO implements ProductDAO {

	public List<Product> getProducts() {

		return null;
	}

	public List<Product> getProducts(int pageNo, int pageSize) {

		return null;
	}

	@Override
	public int getProducts(List<Product> list, int pageNo, int pageSize) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int findProducts(List<Product> list, int[] categoryId, String keyword, double lowNormalPrice,
			double highNormalPrice, double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize) {

		return 0;
	}

	public boolean deleteProductByCategoryId(int categoryId) {

		return false;
	}

	public boolean deleteProductById(int id) {

		return false;
	}

	public boolean updateProduct(Product p) {

		return false;
	}

	public boolean addProduct(Product p) {

		return false;
	}

	public Product loadById(int id) {

		return null;
	}

	@Override
	public List<Product> getLatestProducts(int count) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getBestsellerProducts(int count) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> getProductsByTopCategoryid(int topCategoryid) {
		return null;
	}

	@Override
	public List<Product> getProductsBySubCategoryid(int subCategoryid) {
		// TODO Auto-generated method stub
		return null;
	}

}
