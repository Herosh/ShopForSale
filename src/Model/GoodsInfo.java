package Model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import Core.DBOper;

//商品信息
public class GoodsInfo {
	public int id;
	public String GoodsNum;//商品编号
	public String GoodsName;//商品名字
	public int CateId;//商品类型Id
	public String CateName;//商品类型名
	public int Price;
	public int TotalNumber;//商品库存量
	public int SaleNumber;//商品已经售出数量
	
	public java.sql.Timestamp SubTime;//提交时间
	public int DelFlag;
	public String State;
	public String Remark;
	public int IsSale;

	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	//查询所有商品信息
	public ArrayList<GoodsInfo> getAllGoodsInfo(String sql) throws SQLException{
		System.out.println("进入数据访问层getAllGoodsInfo()成功");
		ArrayList<GoodsInfo> goodsInfoArr=new ArrayList<GoodsInfo>();
	
		
		String params[]={};
		
		ResultSet rst = new DBOper().executeQuery(sql,params);
		
		while(rst.next()){
			GoodsInfo goodsInfo = new GoodsInfo();
			
			goodsInfo.GoodsNum=rst.getString(2);
			goodsInfo.GoodsName=rst.getString(3);
			goodsInfo.CateId=rst.getInt(4);
			goodsInfo.CateName=rst.getString(5);
			goodsInfo.Price=rst.getInt(6);
			goodsInfo.TotalNumber=rst.getInt(7);
			goodsInfo.SaleNumber=rst.getInt(8);
			goodsInfo.SubTime=rst.getTimestamp(9);
			goodsInfo.DelFlag=rst.getInt(10);
			goodsInfo.State=rst.getString(11);
			goodsInfo.Remark=rst.getString(12);
			goodsInfo.IsSale=rst.getInt(13);
			
			goodsInfoArr.add(goodsInfo);
		}
		return goodsInfoArr;
	}
	
	//商品上架
	public int ExecuteUpToSale(String goodsNum){
		String sql = "Update goodsinfo set IsSale = 1 where GoodsNum = ?";
		String params[] = {goodsNum};
		
		//执行更新
		return  new DBOper().executeUpdate(sql,params);
	}
	
	//商品下架
	public int ExecuteDownToSale(String goodsNum){
		String sql = "Update goodsinfo set IsSale = 0 where GoodsNum = ?";
		String params[] = {goodsNum};
		
		//执行更新
		return  new DBOper().executeUpdate(sql,params);
	}
	
	//新增商品信息
	public int AddNewGoodsInfo(GoodsInfo goods){
		String sql = "Insert into goodsinfo(GoodsNum, GoodsName, CateId, CateName,Price, TotalNumber,SaleNumber,State, Remark, IsSale) values(?,?,?,?,?,?,?,?,?,?)";
		String params[] = {goods.GoodsNum, goods.GoodsName, String.valueOf(goods.CateId) , goods.CateName, String.valueOf(goods.Price), String.valueOf(goods.TotalNumber), String.valueOf(goods.SaleNumber), goods.State, goods.Remark, String.valueOf(goods.IsSale)};
		
		DBOper db = new DBOper();
		
		return db.executeUpdate(sql, params);
		
	}
	
	//产生一个新的值
	public String getNewGoodsNum() throws SQLException{
		String sql = "Select GoodsNum from goodsinfo order by GoodsNum";
		String[] params = {};
		DBOper db = new DBOper();
		
		ResultSet rst = db.executeQuery(sql, params);
		String lastGoodsNum1 = "";
		String lastGoodsNum2 = "";
		if(rst.last()){
			lastGoodsNum1 = rst.getString(1);
			
			//截取字符串中数字部分
			Pattern p = Pattern.compile("[0-9\\.]+");
			Matcher m = p.matcher(lastGoodsNum1);
			
			
			while(m.find()){
				lastGoodsNum2 += m.group();
			}
		}
		
		String newGoodsNum =  "G"+(Integer.parseInt(lastGoodsNum2) +1); 
		//System.out.print("产生新的值："+ newGoodsNum);
		return newGoodsNum;
		
	}
	
	
	//商品采购更新的几个属性
	public int UpdateGodosInfoAsBuy(String goodsnum,int price, int issale,int totalnumber){
		String sql = "Update goodsinfo set Price = ?, IsSale = ?, TotalNumber = TotalNumber + "+totalnumber+"  where GoodsNum = ?";
		String params[] = {String.valueOf(price)  ,String.valueOf(issale) ,goodsnum };
		
		DBOper db = new DBOper();
		return db.executeUpdate(sql, params);		
	}
	
	//商品销售
	public int UpdateGoodsInfoAsSale(String goodsnum,int salenumber){
		//Update goodsinfo set TotalNumber = TotalNumber - 1, SaleNumber = SaleNumber + 1  where GoodsNum = 'G1005';
		System.out.print("salenumber:"+salenumber);
		String sql = "Update goodsinfo set TotalNumber = TotalNumber - "+salenumber+", SaleNumber = SaleNumber + "+salenumber+"  where GoodsNum = ?";
		String params[] = {goodsnum};
		
		DBOper db = new DBOper();
		return db.executeUpdate(sql, params);	
	}
	
	//查询所有商品信息
		public ArrayList<GoodsInfo> getAllGoodsInfo() throws SQLException{
			System.out.println("进入数据访问层getAllGoodsInfo()成功");
			ArrayList<GoodsInfo> goodsInfoArr=new ArrayList<GoodsInfo>();
		
			String sql = "select * from GoodsInfo where DelFlag =0";
			String params[]={};
			
			ResultSet rst = new DBOper().executeQuery(sql,params);
			
			while(rst.next()){
				GoodsInfo goodsInfo = new GoodsInfo();
				
				goodsInfo.GoodsNum=rst.getString(2);
				goodsInfo.GoodsName=rst.getString(3);
				goodsInfo.CateId=rst.getInt(4);
				goodsInfo.CateName=rst.getString(5);
				goodsInfo.Price=rst.getInt(6);
				goodsInfo.TotalNumber=rst.getInt(7);
				goodsInfo.SaleNumber=rst.getInt(8);
				goodsInfo.SubTime=rst.getTimestamp(9);
				goodsInfo.DelFlag=rst.getInt(10);
				goodsInfo.State=rst.getString(11);
				if(rst.getString(12)!=null){
					goodsInfo.Remark=rst.getString(12);
				}else{
					goodsInfo.Remark="";
				}
				goodsInfoArr.add(goodsInfo);
			}
			return goodsInfoArr;
		}
		
		//条件查询商品信息
		public ArrayList<GoodsInfo> QueryGoodsInfoByItem(String goodsNum, String goodsName, String cateName) throws SQLException{
			System.out.println("进入数据访问层 QueryGoodsInfoByItem(成功");
			
			ArrayList<GoodsInfo> goodsInfoArr=new ArrayList<GoodsInfo>();
			String sql="";
			DBOper db = null;
			ResultSet rst = null;
			
			if(!goodsNum.equals("")&&goodsName.equals("")&&cateName.equals("")){//查商品编号
				sql = "select * from GoodsInfo where GoodsNum=? and delflag=0 order by GoodsNum";
				String[] params = {goodsNum};
				
				rst =  new DBOper().executeQuery(sql,params);
			}else if(!goodsName.equals("")&&goodsNum.equals("")&&cateName.equals("")){//查商品名
				sql = "select * from GoodsInfo where GoodsName=? and delflag=0 order by GoodsNum";
				String[] params = {goodsName};
				
				rst = new DBOper().executeQuery(sql,params);
			}else if(!cateName.equals("")&&goodsNum.equals("")&&goodsName.equals("")){//查商品类型
				sql = "select * from GoodsInfo where CateName=? and delflag=0 order by GoodsNum";
				String[] params = {cateName};
				
				rst = new DBOper().executeQuery(sql,params);
			}else if(!goodsName.equals("")&&goodsNum.equals("")&&!cateName.equals("")){//查姓名、性别
				sql = "select * from UserInfo where UserName=? and Gender=? and delflag=0 order by UserNum";
				String[] params = {goodsName,cateName};
				
				rst = new DBOper().executeQuery(sql,params);
			}
			
			while(rst.next()){
				    GoodsInfo goodsInfo = new GoodsInfo();
					
				    if(rst.getString(2) == null){
				    	goodsInfo.GoodsNum="";
					}else{
						goodsInfo.GoodsNum=rst.getString(2);
					}
					if(rst.getString(3) == null){
						goodsInfo.GoodsName="";
					}else{
						goodsInfo.GoodsName=rst.getString(3);
					}
					goodsInfo.CateName=rst.getString(5);
					goodsInfo.Price=rst.getInt(6);
					goodsInfo.TotalNumber=rst.getInt(7);
					goodsInfo.SaleNumber=rst.getInt(7);

					goodsInfoArr.add(goodsInfo);
				}
			return goodsInfoArr;
		}
		
		//删除商品信息
		public String deleteGoodsInfo(String goodsNum){
			System.out.println("进入数据访问层deleteGoodsInfo(成功");
			String sql="update GoodsInfo set DelFlag =1 where GoodsNum=?";
			String[] params={goodsNum};
			
			int n = new DBOper().executeUpdate(sql, params);
			
			if(n>=1){
				return "success";
			}else{
				return "error";
			}
		}
		
		public String updateGoodsInfo(String oldGoodsNum, String newGoodsNum, String newGoodsName, String newCateName, String newPrice, String newTotalNumber, String newSaleNumber ){
			System.out.println("进入数据访问层updateGoodsInfo(成功");
			System.out.println(oldGoodsNum+ newGoodsNum+newCateName+newPrice+newTotalNumber+newSaleNumber);
			String sql="update GoodsInfo set GoodsNum=?, GoodsName=?, CateName=?, Price=?, TotalNumber=?, SaleNumber=? where GoodsNum=?";
			String[] params={newGoodsNum, newGoodsName, newCateName, newPrice, newTotalNumber, newSaleNumber,oldGoodsNum};
			
			int n = new DBOper().executeUpdate(sql, params);
			
			if(n>=1){
				return "success";
			}else{
				return "error";
			}
		}


}
