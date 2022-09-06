package service;

import java.sql.*;
import java.util.*;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	// interface를 구현했다면 interface 타입으로 선언하는 편이 좋다 - decoupling, 유연성
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;
	private DBUtil dbUtil;

	public GoodsService() {
		super();
		this.goodsDao = new GoodsDao();
		this.dbUtil = new DBUtil();
	}

	// 상품 추가 메소드 -> goods, goodsImg 테이블 트랜잭션
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		System.out.println("------------------------------ GoodsService.addGoods()");

		int goodsNo = 0;
		Connection conn = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			this.goodsDao = new GoodsDao();
			goodsNo = goodsDao.insertGoods(conn, goods);
			// 방금 insert한 goods_no 리턴 -> action의 redirection에 씀

			System.out.println("goodsDao.insertGoods(): !0 -> " + goodsNo);
			
			if(goodsNo != 0) { // goods insert에 성공한 경우
				goodsImg.setGoodsNo(goodsNo);
				this.goodsImgDao = new GoodsImgDao(); // 모든 메소드에서 쓰는 dao가 아니므로
				
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					goodsNo = 0; // 실패 시 goodsNo 다시 0
					System.out.println("goodsImgDao.insertGoods: !0 -> " + goodsNo);

					throw new Exception();
					// 이미지 입력 실패 시 catch 절로 이동 -> rollBack
				}
			}
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
		} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return goodsNo;
	}

	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		System.out.println("------------------------------ GoodsService.getGoodsAndImgOne()");

		Map<String, Object> goodsAndImgOne = null;
		Connection conn = null;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.goodsDao = new GoodsDao();
			goodsAndImgOne = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			System.out.println("getGoodsAndImgOne: " + goodsAndImgOne);

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return goodsAndImgOne;
	}

	// admin goods list + beginRow 구해서 DAO로 넘겨줌
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		System.out.println("------------------------------ GoodsService.getGoodsListByPage()");

		List<Goods> goodsList = null;
		Connection conn = null;

		// 시작할 행 구하기
		int beginRow = (currentPage - 1) * rowPerPage;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.goodsDao = new GoodsDao();
			goodsList = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			System.out.println("goodsList.size: " + goodsList.size());

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

	// 페이징 용도
	public int getLastPage(int rowPerPage, int categoryId) {
		System.out.println("------------------------------ GoodsService.getLastPage()");

		Connection conn = null;
		int lastPage = 0;

		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.goodsDao = new GoodsDao();
			int cnt = goodsDao.countAllGoods(conn, categoryId);
			
			lastPage = (int) Math.ceil(cnt / (double) rowPerPage); // lastPage 여기서 구해서 넘기기

		} catch (Exception e) {

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
	
	// 고객 상품 리스트 + beginRow 넘겨주기
	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage, String sortBy, int categoryId) throws SQLException {
		System.out.println("------------------------------ GoodsService.getCustomerGoodsListByPage()");

		Connection conn = null;
		List<Map<String, Object>> list = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			int beginRow = (currentPage - 1) * rowPerPage; // beginRow 구해서 넘기기
			
			this.goodsDao = new GoodsDao();
			list = goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, beginRow, sortBy, categoryId);
			
		} catch(Exception e) {
			
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
	
	// 검색
	public List<Map<String, Object>> getGoodsListBySearch(String search){
		System.out.println("------------------------------ GoodsService.getGoodsListBySearch()");
		System.out.println(search);

		Connection conn = null;
		List<Map<String, Object>> list = null;
		
		try {
			this.dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			this.goodsDao = new GoodsDao();
			list = goodsDao.selectGoodsListBySearch(conn, search);
			
		} catch(Exception e) {
			
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
}
