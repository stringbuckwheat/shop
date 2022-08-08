package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import repository.GoodsDao;
import vo.Goods;

public class GoodsService {
	// interface를 구현했다면 interface 타입으로 선언하는 편이 좋다 - decouplings, 유연성
	private GoodsDao goodsDao;
	private DBUtil dbUtil;
	
	public GoodsService() {
		super();
		this.goodsDao = new GoodsDao();
		this.dbUtil = new DBUtil();
	}

	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage){
		List<Goods> goodsList = null;
		Connection conn = null;
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = dbUtil.getConnection();
			goodsList = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			System.out.println("Goods Service: " + goodsList);
		
		} catch (Exception e) {
		
			e.printStackTrace();
		
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return goodsList;
	}
	
	public int getLastPage(int rowPerPage) {
		Connection conn = null;
		int lastPage = 0;
		
		try {
			conn = dbUtil.getConnection();
			int cnt = goodsDao.countAllGoods(conn);
			lastPage = (int) Math.ceil (cnt / (double)rowPerPage);
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return lastPage;
	}
	
}
