package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import vo.Category;

public class CategoryDao {
	
	public List<Category> selectCategoryList(Connection conn) throws Exception{
		System.out.println("----------------------- CategoryDao.selectCategoryList()");
		
		ArrayList<Category> categoryList = new ArrayList<>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT category_id categoryId, category_name categoryName"
				+ " FROM category";
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				// vo 객체 생성
				Category c = new Category();
				
				// setting
				c.setCategoryId(rs.getInt("categoryId"));
				c.setCategoryName(rs.getString("categoryName"));
				
				// 반환할 리스트에 담기
				categoryList.add(c);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}

			if (stmt != null) {
				stmt.close();
			}
		}
		
		return categoryList;
	} // end for selectCategoryList

	public String selectOneCategoryName(Connection conn, int categoryNo) throws Exception{
		System.out.println("----------------------- CategoryDao.selectOneCategoryName()");
		String categoryName = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select category_name categoryName from category where category_id = ?";
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);

			rs = stmt.executeQuery();

			if (rs.next()) {
				categoryName = rs.getString("categoryName");
			}

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}		

		System.out.println("categoryName: " + categoryName);
		return categoryName;
	}
}
