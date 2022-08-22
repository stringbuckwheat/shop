package repository;

import java.sql.Connection;

public class CounterDao {
	// 입력
	
	// 오늘 날짜의 데이터가 있으면 update, 없으면 insert
	
	// 오늘 날짜의 데이터가 있는지 확인
	public String selectCounterToday(Connection conn) {
		String result = null;
		String sql = "select counter_date from counter where counter_date = curdate()";
		

		
		// null 혹은 오늘 날짜를 리턴
		return result;
	}
	
	public void insertCounter(Connection conn) {
		// 하루의 첫번째 카운트에 호출되는 메소드이므로 counter_num == 1
		String sql = "insert into counter(counter_date, counter_num) values (curdate(), 1)";
		
	}
	
	public void updateCounter(Connection conn) {
		String sql = "update counter set counter_num counter_num + 1 where counter_date = curdate()";
	}
	
	// 전체 접속자 수
	// select sum(counter_num) from counter;
	
	// 오늘 접속자 수
	// select counter_num from counter where counter_date = curdate();
	
	public String selectCounterToday(Connection conn) {
		String result = null;
		// SELECT counter_date FROM counter WHERE counter_date = CURDATE()
		return result;	
	}
	
	public void insertCounter(Connection conn) {
		// INSERT INTO counter(counter_date,counter_num) VALUES(CURDATE(),1)
	}
	
	public void updateCounter(Connection conn) {
		// UPDATE counter SET counter_num = counter_num+1 WHERE counter_date = CURDATE()
	}
	
	
	// IndexController에서 호출
	// 전체접속자 수
	// SELECT SUM(counter_num) FROM counter; 
	public int selectTotalCount(Connection conn) {
		return 0;
	}
	
	// 오늘 접속자 수
	// SELECT counter_num FROM counter WHERE counter_date = CURDATE();
	public int selectTodayCount(Connection conn) {
		return 0;
	}
	
}
