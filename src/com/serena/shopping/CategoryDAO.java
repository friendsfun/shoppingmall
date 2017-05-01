package com.serena.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.serena.shopping.util.DB;

public class CategoryDAO {

	public static void save(Category c) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into category values (null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.getPid());
			pstmt.setInt(4, c.isLeaf() ? 0 : 1);
			pstmt.setInt(5, c.getGrade());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public static void getCategories(List<Category> list, int id) {
		Connection conn = null;
		conn = DB.getConn();
		getCategories(conn, list, id);
		DB.close(conn);
	}

	private static void getCategories(Connection conn, List<Category> list, int id) {
		ResultSet rs = null;

		try {
			String sql = "select * from category where pid = " + id;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				list.add(c);
				if (!c.isLeaf()) {
					getCategories(conn, list, c.getId());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
		}
	}
	
	public static void getTopCategories(List<Category> list) {
		Connection conn = null;
		conn = DB.getConn();
		ResultSet rs = null;

		try {
			String sql = "select * from category where pid = 0";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}	
	}

	public static void getSubCategories(List<Category> list, int id) {
		Connection conn = null;
		conn = DB.getConn();
		ResultSet rs = null;

		try {
			String sql = "select * from category where pid = " + id;
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		
	}
	
	public static void addChildCategory(int pid, String name, String descr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			rs = DB.executeQuery(conn, "select * from category where id = " + pid);
			int parentGrade = 0;
			if (rs.next()) {
				parentGrade = rs.getInt("grade");
			}
			// store the new category
			String sql = "insert into category values (null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, name);
			pstmt.setString(2, descr);
			pstmt.setInt(3, pid);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, parentGrade + 1);
			pstmt.executeUpdate();

			// update the parent node
			DB.executeUpdate(conn, "update category set isleaf = 1 where id = " + pid);

			conn.commit();
			conn.setAutoCommit(true);

		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {

			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public static Category loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		Category c = null;

		try {
			conn = DB.getConn();
			String sql = "select * from category where id = " + id;
			rs = DB.executeQuery(conn, sql);
			if (rs.next()) {
				c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return c;
	}

	public static void deleteById(int id) {
		Category c = loadById(id);
		if (c != null) {
			int pid = c.getPid();
			boolean isleaf = c.isleaf;

			Connection conn = null;
			ResultSet rs = null;
			boolean autoCommit = true;

			try {
				conn = DB.getConn();
				autoCommit = conn.getAutoCommit();
				conn.setAutoCommit(false);
				deleteByIdHelper(conn, id, isleaf);

				// update the parent category of the deleted category
				String sql = "select * from category where pid = " + pid;
				rs = DB.executeQuery(conn, sql);
				if (!rs.next()) {
					DB.executeUpdate(conn, "update category set isleaf = 0 where id = " + pid);
				}

				conn.commit();
				conn.setAutoCommit(autoCommit);
			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			} finally {
				DB.close(rs);
				DB.close(conn);
			}
		}
	}

	public static void deleteByIdHelper(Connection conn, int id, boolean isleaf) {
		ResultSet rs = null;
		String sql = "";

		// delete all the children, then delete itself
		if (!isleaf) {
			try {
				sql = "select * from category where pid = " + id;
				rs = DB.executeQuery(conn, sql);
				while (rs.next()) {
					deleteByIdHelper(conn, rs.getInt("id"), rs.getInt("isleaf") == 0 ? true : false);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DB.close(rs);

			}
		}
		DB.executeUpdate(conn, "delete from category where id = " + id);
	}

	public static void updateById(int id, String name, String descr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update category set name = ?, descr = ? where id = " + id;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, name);
			pstmt.setString(2, descr);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
}
