package service;

import java.sql.*;
import java.util.*;

import repository.ReviewDao;
import vo.Review;

public class ReviewService {
	private DBUtil dbUtil;
	private ReviewDao reviewDao;
	
	// C: 리뷰 쓰기
	// R: 개별 유저의 리뷰리스트
	// R: 전체 리뷰리스트(for admin)
	// R: 제품id별 리뷰리스트
	// U: 리뷰 수정
	// D: 리뷰 삭제
	
	// C: 리뷰 쓰기
	public boolean addReview(Review review) {
		System.out.println("------------------------------ ReviewService.addReview()");

		Connection conn = null;
		boolean result = true; // 메소드 실행 결과
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false); // 트랜잭션
			
			this.reviewDao = new ReviewDao();
			if(reviewDao.insertReview(conn, review) != 1) {
				throw new Exception();
			}
			
			conn.commit(); // insert 성공시에만 커밋
		} catch (Exception e) {
			System.out.println("reviewService.addReview() 실패");
			e.printStackTrace();
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
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
	
	// R: 해당 주문에 대한 리뷰가 존재하는지 검사하는 메소드
	// orderListForCustomer.jsp의 리뷰 작성 / 리뷰 수정 버튼을 띄우기 위해서
	public boolean getOneReview(int orderNo) {
		System.out.println("---------------- ReviewService.getReviewOne()");
		boolean result = false;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();

			this.reviewDao = new ReviewDao();
			int row = reviewDao.selectReviewOne(conn, orderNo);
			
			if(row == 1) {
				result = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	// R: 개별 유저의 리뷰리스트
	public List<Map<String, Object>> getReviewListByUser(String id){
		System.out.println("---------------- ReviewService.getReviewListByUser()");
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.reviewDao = new ReviewDao();
			list = reviewDao.selectReviewListByUser(conn, id);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	// R: 전체 리뷰리스트(for admin)
	public List<Map<String, Object>> getAllReviewList(){
		System.out.println("---------------- ReviewService.getAllReviewList()");
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.reviewDao = new ReviewDao();
			list = reviewDao.selectAllReviewList(conn);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	// R: 제품id별 리뷰리스트
	public List<Map<String, Object>> getReviewListByGoodsNo(int goodsNo){
		System.out.println("---------------- ReviewService.getReviewListByGoodsNo()");
		
		List<Map<String, Object>> list = null;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.reviewDao = new ReviewDao();
			list = reviewDao.selectReviewListByGoodsNo(conn, goodsNo);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	// 리뷰 상세보기는 필요없을듯
	
	
	// U: 리뷰 수정
	public boolean modifyReview(Review review) {
		System.out.println("---------------- CartService.modifyCart()");
		boolean result = true;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.reviewDao = new ReviewDao();
			int row = reviewDao.updateReview(conn, review);
			
			if(row != 1) {
				System.out.println("리뷰 수정 실패");
				result = false;
			}

		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	// D: 리뷰 삭제
	public boolean removeReview(int orderNo) {
		System.out.println("---------------- ReviewService.removeReview()");
		
		boolean result = true;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.reviewDao = new ReviewDao();
			int row = reviewDao.deleteReview(conn, orderNo);
			
			if(row == 0) {
				result = false;
				System.out.println("리뷰 삭제 성공");
			}
			
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
			
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
