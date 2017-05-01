package com.serena.shopping.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/FileUpload")
public class FileUpload extends HttpServlet {
	@Override
	public void init(ServletConfig config) throws ServletException {
		uploadPath = config.getInitParameter("uploadpath");
	}

	private static final long serialVersionUID = 1L;

	String uploadPath = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FileUpload() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		response.getWriter().println("Please upload files in post method!");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int id = -1;

		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		System.out.println(req.getContentLength());
		System.out.println(req.getContentType());
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(4096);
		// the location for saving data that is larger than getSizeThreshold()
		factory.setRepository(new File("/Users/serana/Desktop/"));

		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		upload.setSizeMax(1000000);

		try {
			List fileItems = upload.parseRequest(req);
			// assume we know there are two files. The first file is a small
			// text file,
			// the second is unknown and is written to a file on the server
			Iterator iter = fileItems.iterator();

			// regular expression: to get the file name from the file path
			String regExp = ".+(\\..+)$";

			// file types that are not allowed to upload
			String[] errorType = { ".exe", ".com", ".cgi", ".jsp" };
			Pattern p = Pattern.compile(regExp);
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					if (item.getFieldName().equals("id")) {
						id = Integer.parseInt(item.getString());
					}
				}
				if (!item.isFormField()) {
					String name = item.getName();
					// out.println("name = " + name);
					long size = item.getSize();
					if ((name == null || name.equals("")) && size == 0) {
						continue;
					}
					Matcher m = p.matcher(name);
					boolean result = m.find();
					if (result) {
						for (int temp = 0; temp < errorType.length; temp++) {
							if (m.group(1).endsWith(errorType[temp])) {
								throw new IOException(name + ": this file type is not allowed to upload");
							}
						}
						try {
							// store the uploaded file to the specific directory
							// modify here if you need to store the uploaded
							// file to the database
							// item.write(new File("" + m.group(1)));
							item.write(new File(uploadPath + id + ".jpg"));
							out.print(name + ": &nbsp;" + size + "<br>");

						} catch (Exception e) {
							out.println(e);
						}
					} else {
						throw new IOException("Fail to upload");
					}

				}

			}

		} catch (IOException e) {
			out.println(e);
		} catch (FileUploadException e) {
			out.println(e);
		}

	}

}
