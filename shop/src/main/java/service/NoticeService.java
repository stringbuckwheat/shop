package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import repository.NoticeDao;
import vo.Notice;

public class NoticeService {
	private DBUtil dbUtil;
	private NoticeDao noticeDao;
	
	// notice/noticeList.jsp
	public List<Notice> getNoticeList(int rowPerPage, int currentPage){
		System.out.println("------------------------------ NoticeService.getNoticeList()");
		
		List<Notice> noticeList = null;
		Connection conn = null;
		
		// beginRow 구하기 
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.noticeDao = new NoticeDao();
			noticeList = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return noticeList;
	}
	
	public int getLastPage(int rowPerPage) {
		System.out.println("------------------------------ NoticeService.getLastPage()");

		Connection conn = null;
		int lastPage = 0;
		
		try {
			
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			int cnt = noticeDao.selectAllNotice(conn);
			lastPage = (int) Math.ceil (cnt / (double)rowPerPage);
			System.out.println("lastPage: " + lastPage);
			
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
	
	// notice/noticeList.jsp
	public Notice getNoticeOne(int noticeNo) {
		System.out.println("------------------------------ NoticeService.getNoticeOne()");

		Notice notice = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.noticeDao = new NoticeDao();
			notice = noticeDao.selectOneNotice(conn, noticeNo);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return notice;
	}
	
	// notice/noticeOne.jsp
	public int addNotice(Notice paramNotice) {
		System.out.println("------------------------------ NoticeService.addNotice()");

		int noticeNo = 0;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.noticeDao = new NoticeDao();
			noticeNo = noticeDao.insertNotice(conn, paramNotice);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return noticeNo;
	}
	
	public int modifyNotice(Notice paramNotice) {
		System.out.println("------------------------------ NoticeService.addNotice()");

		int row = 0;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.noticeDao = new NoticeDao();
			row = noticeDao.updateNotice(conn, paramNotice);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	public int removeNotice(int noticeNo) {
		int row = 0;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.noticeDao = new NoticeDao();
			row = noticeDao.deleteNotice(conn, noticeNo);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	
}
