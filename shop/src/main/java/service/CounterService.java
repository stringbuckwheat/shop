package service;

import java.sql.Connection;

import repository.CounterDao;

public class CounterService {
	private CounterDao counterDao;
	
	public void count() {
		Connection conn = null;
		
		this.counterDao = new CounterDao();
				
		if(counterDao.selectCounterToday(conn) == null) {
			counterDao.insertCounter(conn);
		} else {
			counterDao.updateCounter(conn);
		}
	}

	public int getTotalCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int totalCount = counterDao.selectTotalCount(conn);
		return totalCount;
	}

	public int getTodayCount() {
		counterDao = new CounterDao();
		Connection conn = null;
		int todayCount = counterDao.selectTodayCount(conn);
		return todayCount;
	}

}
