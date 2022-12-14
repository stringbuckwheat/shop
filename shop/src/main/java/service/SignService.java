package service;

import java.sql.*;

import repository.SignDao;


public class SignService {
	private SignDao signDao;
	private DBUtil dbUtil;

	// return: true면 사용 가능한 아이디, false면 사용불가
	public boolean checkId(String id) {
		boolean result = false; // 메소드 실행 결과값을 담을 변수
		Connection conn = null;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 자동 커밋 막기
			
			this.signDao = new SignDao();

			System.out.println(id + " 입력 -> " + signDao.checkId(conn, id));

			if (signDao.checkId(conn, id) == null) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = false;

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}
}
