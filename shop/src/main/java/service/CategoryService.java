package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.CategoryDao;
import vo.Category;

public class CategoryService {
	private DBUtil dbUtil;
	private CategoryDao categoryDao;
	
	public List<Category> getCategoryList(){
		System.out.println("--------------- CategoryService.getCategoryList()");
		
		List<Category> categoryList = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.categoryDao = new CategoryDao();
			categoryList = categoryDao.selectCategoryList(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println(categoryList);
		return categoryList;
	}
	
	public String getCategoryNameOne(int categoryNo) {
		System.out.println("--------------- CategoryService.getCategoryNameOne()");
		
		String categoryName = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.categoryDao = new CategoryDao();
			categoryName = categoryDao.selectOneCategoryName(conn, categoryNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println(categoryName);
		return categoryName;
	}

}
