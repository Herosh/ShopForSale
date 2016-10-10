package Model;

import Core.DBOper;

public class BackInfo {
	public int id;
	public int ExportId;//商品销售编号 
	
	public String GoodsNum;//商品编号 
	public String GoodsName;//商品名字
	
	public String CustomerName;//客户名字
	public String CustomerPhone;//客户电话
	public String Description;//退货描述
	
	public String UserNum;//处理员工编号 
	public String UserName;//处理员工名字
	
	public java.sql.Timestamp SubTime;
	public int DelFlag;
	public String State;
	public String Remark;
	
	//员工退货方法
	public String SaleBack(String exportId, String goodsNum, String goodsName, String customerName, String customerPhone, String description, String userNum, String userName){
        System.out.println("进入数据访问层SaleBack()成功");
		
		String sql = "insert into BackInfo(ExportId, GoodsNum, GoodsName, CustomerName, CustomerPhone, Description, UserNum,UserName) values(?,?,?,?,?,?,?,?)";
		String params[]={exportId, goodsNum, goodsName, customerName, customerPhone, description, userNum, userName};
		int n = new DBOper().executeUpdate(sql, params);
		
		if(n>=1){
			return "success";
		}else{
			return "error";
		}
	}
	
	//员工退货方法2
	public int SaleBack2(String exportId, String goodsNum, String goodsName, String customerName, String customerPhone, String description, String userNum, String userName){
        System.out.println("进入数据访问层SaleBack()成功");
		
		String sql = "insert into BackInfo(ExportId, GoodsNum, GoodsName, CustomerName, CustomerPhone, Description, UserNum,UserName) values(?,?,?,?,?,?,?,?)";
		String params[]={exportId, goodsNum, goodsName, customerName, customerPhone, description, userNum, userName};
		return  new DBOper().executeUpdate(sql, params);
		
		
	}
}
