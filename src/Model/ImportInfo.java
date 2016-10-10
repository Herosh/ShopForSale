package Model;

import java.sql.ResultSet;
import java.sql.SQLException;

import Core.DBOper;

//商品进货
public class ImportInfo {
	public int id;
	public String GoodsNum;
	public String GoodsName;
	public int ProviderId;
	public String ProviderName;//供货商名字
	public int Number;//进货量
	public int Price;//入货价格
	public String UserNum;//员工编号 
	public String UserName;//员工名字
	
	public java.sql.Timestamp SubTime;
	public int DelFlag;
	public String State;
	public String Remark;

	//商品进货方法
	public String GoodsImport(String goodsNum, String goodsName, String providerName, String number, String price, String userNum, String userName){
		System.out.println("进入数据访问层GoodsImport()成功");
		
		String sql = "update GoodsInfo set TotalNumber=TotalNumber+? where GoodsNum=?";
		String params1[]={number, goodsNum};
		int n = new DBOper().executeUpdate(sql, params1);
		
		sql = "insert into ImportInfo(GoodsNum,GoodsName,ProviderName,Number,Price,UserNum,UserName) values(?,?,?,?,?,?,?)";
		String params[]={goodsNum, goodsName, providerName, number, price, userNum, userName};
		n = new DBOper().executeUpdate(sql, params);
		
		if(n>=1){
			return "success";
		}else{
			return "error";
		}
	}
	
	//添加进货信息
	public int AddImportInfo(ImportInfo importinfo){
		System.out.print("进入ImportInfo");
		String sql = "insert into importinfo(GoodsNum,GoodsName,ProviderId, ProviderName,Number,Price,UserNum,UserName) values(?,?,?,?,?,?,?,?)";
		String params[] = {importinfo.GoodsNum, importinfo.GoodsName, String.valueOf( importinfo.ProviderId), importinfo.ProviderName, String.valueOf(importinfo.Number), String.valueOf(importinfo.Price), importinfo.UserNum, importinfo.UserName};
		
		DBOper db = new DBOper();
		
		return  db.executeUpdate(sql, params);
		
	}

	//根据商品编号查询该商品的供货商
	public String GetProviderNameByGooodsNum(String goodsNum) throws SQLException{
		System.out.println("进入数据访问层GetProviderNameByGooodsNum()成功");
		String providerName="";
		
		String sql = "select * from ImportInfo where GoodsNum=? order by Id";
		String params[]={goodsNum};
		ResultSet rst = new DBOper().executeQuery(sql, params);
		
		System.out.println(rst.next());
		
		
		if(rst.next()){
		System.out.println(rst.getInt(2)+rst.getString(3)+rst.getString(4));
		providerName=rst.getString(4);
		System.out.println("providerName:"+providerName);
		}
		return providerName;
	}
}
