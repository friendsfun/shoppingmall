package com.serena.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.serena.shopping.Category;
import com.serena.shopping.Product;
import com.serena.shopping.util.DB;

public class ProductMySQLDAO implements ProductDAO {

	/*
	 * for test reason public static void main(String[] args) { ProductMySQLDAO
	 * dao = new ProductMySQLDAO(); int[] id = { 0 }; List<Product> list =
	 * dao.findProducts(id, null, -1, -1, -1, -1, null, null, 1, 3);
	 * System.out.println(list.size()); }
	 */

	public List<Product> getProducts() {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select * from product";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	public List<Product> getProducts(int pageNo, int pageSize) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid, "
					+ " category.id cid, category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade "
					+ " from product join category on (product.categoryid = category.id) limit "
					+ (pageNo - 1) * pageSize + ", " + pageSize;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));

				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));

				p.setCategory(c);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		int pageCount = 0;

		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;

		try {
			conn = DB.getConn();
			rsCount = DB.executeQuery(conn, "select count(*) from product");
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;

			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid, "
					+ " category.id cid, category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade "
					+ " from product join category on (product.categoryid = category.id) limit "
					+ (pageNo - 1) * pageSize + ", " + pageSize;
			System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));

				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));

				p.setCategory(c);
				products.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}

		return pageCount;
	}

	public int findProducts(List<Product> list, int[] categoryId, String keyword, double lowNormalPrice,
			double highNormalPrice, double lowMemberPrice, double highMemberPrice, Timestamp startDate,
			Timestamp endDate, int pageNo, int pageSize) {

		int pageCount = 0;
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;

		String sql = "select * from product where 1=1";
		try {
			conn = DB.getConn();

			String strId = "";
			if (categoryId != null && categoryId.length > 0) {
				strId = strId + "(";
				for (int i = 0; i < categoryId.length; i++) {
					if (i < categoryId.length - 1) {
						strId = strId + categoryId[i] + ",";
					} else {
						strId = strId + categoryId[i];
					}
				}
				strId = strId + ")";
				sql = sql + " and categoryid in " + strId;
			}

			if (keyword != null && !keyword.trim().equals("")) {
				sql = sql + " and name like '%" + keyword + "%' or descr like '%" + keyword + "%'";
			}

			if (lowNormalPrice >= 0) {
				sql = sql + " and normalprice > " + lowNormalPrice;
			}

			if (highNormalPrice > 0) {
				sql = sql + " and normalprice < " + highNormalPrice;
			}

			if (lowMemberPrice >= 0) {
				sql = sql + " and memberprice > " + lowMemberPrice;
			}

			if (highMemberPrice > 0) {
				sql = sql + " and memberprice < " + highMemberPrice;
			}

			if (startDate != null) {
				sql = sql + " and pdate >= '" + new SimpleDateFormat("yyyy-MM-dd").format(startDate) + "'";
			}

			if (endDate != null) {
				sql = sql + " and pdate <= '" + new SimpleDateFormat("yyyy-MM-dd").format(endDate) + "'";
			}

			String sqlCount = sql.replaceFirst("select \\*", "select count(*)");
			System.out.println(sqlCount);

			rsCount = DB.executeQuery(conn, sqlCount);
			rsCount.next();
			System.out.println("count = " + rsCount.getInt(1));
			pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			System.out.println("pageCount = " + pageCount);

			sql = sql + " limit " + (pageNo - 1) * pageSize + ", " + pageSize;
			System.out.println(sql);

			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return pageCount;

	}

	public boolean deleteProductByCategoryId(int categoryId) {
		Connection conn = null;
		try {
			conn = DB.getConn();

			String sql = "delete from product where categoryid = " + categoryId;
			System.out.println(sql);
			DB.executeUpdate(conn, sql);

		} finally {
			DB.close(conn);
		}
		return true;
	}

	public boolean deleteProductById(int id) {
		Connection conn = null;
		try {
			conn = DB.getConn();

			String sql = "delete from product where id = " + id;
			System.out.println(sql);
			DB.executeUpdate(conn, sql);

		} finally {
			DB.close(conn);
		}
		return true;

	}

	public boolean updateProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DB.getConn();

			String sql = "update product set name=?, descr=?, normalprice=?, memberprice=?, categoryid=? where id=?";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryId());
			pstmt.setInt(6, p.getId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return true;
	}

	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DB.getConn();

			String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, p.getPdate());
			pstmt.setInt(6, p.getCategoryId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return true;
	}

	/*
	 * @return null if there is no record in the DB;
	 */
	public Product loadById(int id) {
		Product p = null;
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid, "
					+ " category.id cid, category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade "
					+ " from product join category on (product.categoryid = category.id) where product.id = " + id;
			rs = DB.executeQuery(conn, sql);
			if (rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));

				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));

				p.setCategory(c);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}

		return p;
	}

	public List<Product> getLatestProducts(int count) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select * from product order by pdate desc limit 0," + count;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	@Override
	public List<Product> getBestsellerProducts(int count) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid "
					+ "from product inner join (select productid, sum(pcount) totalCount from salesitem group by productid order by totalCount desc limit 0, "
					+ count + ") tmp on product.id=tmp.productid";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	@Override
	public List<Product> getProductsByTopCategoryid(int topCategoryid) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid "
			 + "from product inner join (select id cid from category where pid = " + topCategoryid + ") tmp on product.categoryid=tmp.cid";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	@Override
	public List<Product> getProductsBySubCategoryid(int subCategoryid) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select * from product where categoryid = " + subCategoryid;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryid"));
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

}
