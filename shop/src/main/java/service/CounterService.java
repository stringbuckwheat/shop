package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.CounterDao;

public class CounterService {
	private DBUtil dbUtil;
	private CounterDao counterDao;
	
	public void count() {
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.counterDao = new CounterDao();
			
			if(counterDao.selectCounterToday(conn) == null) {
				counterDao.insertCounter(conn);
			} else {
				counterDao.updateCounter(conn);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public int getTotalCount() {
		int totalCount = -1;
		Connection conn = null;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.counterDao = new CounterDao();
			totalCount = counterDao.selectTotalCount(conn);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return totalCount;
	}

	public int getTodayCount() {
		
		int todayCount = -1;
		Connection conn = null;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.counterDao = new CounterDao();
			todayCount = counterDao.selectTodayCount(conn);
			
		} catch(Exception e) {
			
			e.printStackTrace();
		
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return todayCount;
	}

}
