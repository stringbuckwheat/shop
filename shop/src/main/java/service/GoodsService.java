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

	public int addGoods(Goods goods, GoodsImg goodsImg) {
		int goodsNo = 0;
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			goodsNo = goodsDao.insertGoods(conn, goods);
			// 방금 insert한 goods_no 리턴 -> action의 redirection에 씀

			System.out.println("goodsDao.insertGoods(): " + goodsNo);
			
			if(goodsNo != 0) { // goods insert에 성공한 경우
				goodsImg.setGoodsNo(goodsNo);
				this.goodsImgDao = new GoodsImgDao(); // 모든 메소드에서 쓰는 dao가 아니므로
				
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					goodsNo = 0; // 실패 시 goodsNo 다시 0
					System.out.println("goodsImgDao.insertGoods: " + goodsNo);

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

	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Map<String, Object> goodsAndImgOne = null;
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
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

	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
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
			lastPage = (int) Math.ceil(cnt / (double) rowPerPage);

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

}
