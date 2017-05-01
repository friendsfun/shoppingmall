package com.serena.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.serena.shopping.util.DB;

public class User {
	private int id;
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Timestamp rdate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Timestamp getRdate() {
		return rdate;
	}

	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}

	public void save2DB() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into ruser values (null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, addr);
			pstmt.setTimestamp(5, rdate);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public void update() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update ruser set username = ?, phone = ?, addr = ? where id = " + this.id;
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			pstmt.setString(3, addr);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public static User validate(String username, String password)
			throws UserNotFoundException, PasswordNotCorrectException {
		Connection conn = null;
		ResultSet rs = null;
		User u = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser where username = '" + username + "'";
			rs = DB.executeQuery(conn, sql);
			if (!rs.next()) {
				throw new UserNotFoundException();
			} else if (!rs.getString("password").equals(password)) {
				throw new PasswordNotCorrectException();
			} else {
				u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return u;
	}

	/*
	 * 以下的方法也可以单独写到一个java类：UserManager类用于后台管理用户
	 * 
	 */

	public static List<User> getUsers() {
		List<User> list = new ArrayList<User>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser order by id desc";
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setRdate(rs.getTimestamp("rdate"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}
		return list;
	}

	public static void deleteUser(int userid) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConn();
			stmt = DB.getStmt(conn);
			String sql = "delete from ruser where id = " + userid;
			stmt.executeUpdate(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(stmt);
			DB.close(conn);
		}

	}
}
