package repository;

import java.sql.*;

public class CounterDao {
	
	// 오늘 날짜의 데이터가 있으면 update, 없으면 insert
	// 오늘 날짜의 데이터가 있는지 확인
	public String selectCounterToday(Connection conn) throws SQLException {
		System.out.println("----------- CounterDao.selectCounterToday()");
		
		String result = null;
		String sql = "select counter_date from counter where counter_date = curdate()";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString(1);
				System.out.println(result);
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		// null 혹은 오늘 날짜를 리턴
		return result;
	}
	
	public void insertCounter(Connection conn) throws SQLException {
		// 하루의 첫번째 카운트에 호출되는 메소드이므로 counter_num == 1
		System.out.println("----------- CounterDao.insertCounter()");

		String sql = "insert into counter(counter_date, counter_num) values (curdate(), 1)";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("오늘의 카운트 시작");
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
	}
	
	// counter + 1
	public void updateCounter(Connection conn) throws SQLException {
		System.out.println("----------- CounterDao.updateCounter()");

		String sql = "update counter set counter_num = counter_num + 1 where counter_date = curdate()";
		PreparedStatement stmt = null;
		
		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.executeQuery();
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
	}
	
	// IndexController에서 호출
	// 전체 접속자 수
	// select sum(counter_num) from counter;
	public int selectTotalCount(Connection conn) throws SQLException {
		System.out.println("----------- CounterDao.selectTotalCount()");

		int result = -1;
		String sql = "select sum(counter_num) from counter";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	
	// 오늘 접속자 수
	public int selectTodayCount(Connection conn) throws SQLException {
		String sql = "select counter_num from counter where counter_date = curdate()";
		int result = -1;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			System.out.println(stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
				System.out.println(result);
			}
			
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		
		return result;
	}
	

	
}
