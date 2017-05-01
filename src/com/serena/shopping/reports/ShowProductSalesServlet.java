package com.serena.shopping.reports;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import com.serena.shopping.util.DB;

/**
 * Servlet implementation class ShowProductSalesServlet
 */
@WebServlet("/ShowProductSalesServlet")
public class ShowProductSalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DefaultCategoryDataset categoryDataset = new DefaultCategoryDataset();
	private DefaultPieDataset pieDataset = new DefaultPieDataset();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShowProductSalesServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void getDataSet() {

		Connection conn = null;
		ResultSet rs = null;

		try {
			conn = DB.getConn();

			String sql = "select p.name, sum(pcount) from product p join salesitem si on "
					+ "(p.id = si.productid) group by p.id";
			System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while (rs.next()) {
				categoryDataset.addValue(rs.getInt(2), "", rs.getString(1));
				pieDataset.setValue(rs.getString(1), rs.getInt(2));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(conn);
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		getDataSet();
		JFreeChart chart = ChartFactory.createBarChart3D("Product Sales Diagram", // 图表标题
				"product name", // 目录轴的显示标签
				"sales amount", // 数值轴的显示标签
				categoryDataset, // 数据集
				PlotOrientation.VERTICAL, // 图表方向：水平、垂直
				true, // 是否显示图例(对于简单的柱状图必须是 false)
				false, // 是否生成工具
				false // 是否生成 URL 链接
		);

		JFreeChart pieChart = ChartFactory.createPieChart("Product Sales PieChart", // 图表标题
				pieDataset, true, // 是否显示图例
				false, false);
		// 写图表对象到文件，参照柱状图生成源码

		FileOutputStream category_jpg = null;
		FileOutputStream pie_jpg = null;
		try {
			category_jpg = new FileOutputStream(
					"/Users/serana/Workspaces/MyEclipse 2016/Shopping/WebRoot/images/reports/productsales.jpg");
			ChartUtilities.writeChartAsJPEG(category_jpg, (float) 1, chart, 400, 300, null);

			pie_jpg = new FileOutputStream(
					"/Users/serana/Workspaces/MyEclipse 2016/Shopping/WebRoot/images/reports/productsales_pie.jpg");
			ChartUtilities.writeChartAsJPEG(pie_jpg, (float) 1, pieChart, 400, 300, null);

			this.getServletContext().getRequestDispatcher("/admin/showproductsaleschart.jsp").forward(request,
					response);
		} finally {
			try {
				category_jpg.close();
				pie_jpg.close();
			} catch (Exception e) {
			}
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
