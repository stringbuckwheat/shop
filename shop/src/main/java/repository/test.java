package repository;

import java.sql.SQLException;
import java.util.*;

import service.DBUtil;

public class test {
	public static void main(String[] args) {
		String sql = "select o.order_no orderNo, g.goods_no goodsNo, c.customer_id customerId,"
				+ " o.order_quantity orderQuantity, o.order_state orderState, o.update_date updateDate,"
				+ " o.create_date createDate, o.order_price orderPrice, o.order_address orderAddress"
				+ " from orders o inner join goods g on g.goods_no = o.goods_no"
				+ " inner join customer c on o.customer_id = c.customer_id"
				+ " order by o.create_date desc";
		
		System.out.println(sql);
		System.out.println();
		
		OrdersDao od = new OrdersDao();
		try {
			List<Map<String, Object>> list = od.selectOrdersList(new DBUtil().getConnection(), 10, 1);
			System.out.println(list);
		} catch (SQLException e) {
			e.printStackTrace();
		
	}
}
