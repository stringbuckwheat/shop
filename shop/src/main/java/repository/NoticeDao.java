package repository;

import java.sql.*;
import java.util.*;

import vo.Notice;

public class NoticeDao {

	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws Exception{
		System.out.println("------------------------------ NoticeDao.selectNoticeList()");
		
		ArrayList<Notice> noticeList = new ArrayList<>();
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "select notice_no noticeNo, notice_title noticeTitle, create_date createDate from notice order by create_date desc limit ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Notice n = new Notice();
				
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeTitle(rs.getString("noticeTitle"));
				n.setCreateDate(rs.getString("createDate"));
				
				noticeList.add(n);
			}
			
			System.out.println(noticeList);
		
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		return noticeList;
	}
	
	public int selectAllNotice(Connection conn) throws SQLException {
		System.out.println("------------------------------ NoticeDao.selectAllNotice()");
		int cnt = 0;
		String sql = "select count(*) cnt from notice";

		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
		} finally {
			
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
				
		return cnt;
		
	}
	
	// notice = noticeDao.selectOneNotice(conn, noticeNo);
	public Notice selectOneNotice(Connection conn, int noticeNo) throws SQLException {
		System.out.println("------------------------------ NoticeDao.selectOneNotice()");
		
		Notice notice = null;
		ResultSet rs =  null;
		PreparedStatement stmt = null;
		
		try {
			String sql = "select notice_title noticeTitle, notice_content noticeContent, create_date createDate, update_date updateDate from notice where notice_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(noticeNo);
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setCreateDate(rs.getString("createDate"));
				notice.setUpdateDate(rs.getString("updateDate"));

				System.out.println(notice);
			}
			
		} finally {
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
		}
		return notice;
	}

	// int result = noticeDao.insertNotice(conn, paramNotice);
	public int insertNotice(Connection conn, Notice paramNotice) throws SQLException {
		System.out.println("------------------------------ NoticeDao.insertNotice()");

		// 방금 입력한 notice_no(value)를 저장할 변수
		int noticeNo = 0;
		String sql = "insert into notice(notice_title, notice_content, update_date, create_date)"
				+ "values(?, ?, now(), now())";

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			// RETURN_GENERATED_KEYS == 1 --> 두 번의 쿼리 실행
			// 1) insert
			// 2) select last_ai_key from table

			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			stmt.executeUpdate(); // insert
			rs = stmt.getGeneratedKeys(); // return 값

			if (rs.next()) {
				noticeNo = rs.getInt(1);
				System.out.println("NoticeDao.insertNotice - 직전 insert의 noticeNo: " + noticeNo);
				// getGeneratedKeys가 반환하는 컬럼명을 알 순 없지만
				// 첫번째라는 것은 알 수 있으므로 rs.getInt(1)
			}
		} finally {
			if (rs != null) { rs.close(); }
			if (stmt != null) { stmt.close(); }
		}
		
		return noticeNo;
	}
	
	// row = noticeDao.updateNotice(conn, paramNotice);
	public int updateNotice(Connection conn, Notice paramNotice) throws SQLException{
		int row = 0;
		PreparedStatement stmt = null;
		String sql = "update notice set notice_title = ?, notice_content = ?, update_date = now() where notice_no = ?";
		
		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeTitle());
			stmt.setString(2, paramNotice.getNoticeContent());
			stmt.setInt(3, paramNotice.getNoticeNo());
			
			row = stmt.executeUpdate();
			
		} finally {
			
			if(stmt != null) { stmt.close(); }
		
		}
		
		return row;
	}

	public int deleteNotice(Connection conn, int noticeNo) throws SQLException{
		int row = 0;
		
		PreparedStatement stmt = null;
		String sql = "delete from notice where notice_no = ?";
		
		try {
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			
			row = stmt.executeUpdate();
			
		} finally {
			
			if(stmt != null) { stmt.close(); }
		
		}
		
		return row;
	}
}
