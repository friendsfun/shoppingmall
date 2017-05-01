package com.serena.shopping;

import java.util.ArrayList;
import java.util.List;

public class Category {
	int id;
	String name;
	String descr;
	int pid;
	boolean isleaf;
	int grade;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public boolean isLeaf() {
		return isleaf;
	}

	public void setLeaf(boolean leaf) {
		this.isleaf = leaf;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public static void add(Category c) {
		CategoryDAO.save(c);
	}

	public void addChild(Category c) {
		addChildCategory(id, c.getName(), c.getDescr());
	}

	public static void addTopCategory(String name, String descr) {
		/*
		 * Category c = new Category(); c.setId(-1); c.setName(name);
		 * c.setDescr(descr); c.setPid(0); c.setLeaf(true); c.setGrade(1);
		 * CategoryDAO.save(c); // add(c);
		 */
		addChildCategory(0, name, descr);
	}

	public static void addChildCategory(int pid, String name, String descr) {
		CategoryDAO.addChildCategory(pid, name, descr);
	}

	public static Category loadById(int id) {
		return CategoryDAO.loadById(id);
	}

	public static void deleteById(int id) {
		CategoryDAO.deleteById(id);
	}

	public static void updateById(int id, String name, String descr) {
		CategoryDAO.updateById(id, name, descr);
	}

	public static List<Category> getCategories() {
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getCategories(list, 0);
		return list;
	}
	
	public static List<Category> getTopCategories() {
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getTopCategories(list);
		return list;
	}

	public static List<Category> getSubCategories(int id) {
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getSubCategories(list, id);
		return list;
	}

	public static boolean isLeaf(int id) {
		return false;
	}

}
