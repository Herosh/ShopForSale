package Model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Core.DBOper;

//商品类型
public class CategoryInfo {
	public int id;
	public String CateName;//商品类型名
	
	public java.sql.Timestamp SubTime;
	public int DelFlag;
	public String State;
	public String Remark;
	
	//获取所有商品类型
	public ArrayList<CategoryInfo> getAllCategoryInfo() throws SQLException{
		System.out.print("进入model");
		String sql = "select * from categoryinfo where DelFlag = 0";
		String params[] = {}; 
		
		ArrayList<CategoryInfo> list = new ArrayList<CategoryInfo>();
		ResultSet rst = new DBOper().executeQuery(sql,params);
		

		while(rst.next()){
			CategoryInfo cate = new CategoryInfo();
			 cate.id = rst.getInt(1);
			 cate.CateName = rst.getString(2);
			 
			 list.add(cate);
		}
		
		return list;
		
	}
	
	public int addNewCategoryInfo(String cateName, String cateRemark) throws SQLException{
		System.out.print("成功进入addNewCategoryInfo"+cateName);
		//String sql1 = "Select * from categoryinfo where CateName = '?'";
		String sql1 = "select * from categoryinfo where CateName = ?";
		String[] params1 = {cateName};
		DBOper db = new DBOper();
		ResultSet rst1 = db.executeQuery(sql1, params1);
		if(rst1.next()){//分类已经存在存在
			System.out.print("成功进入addNewCategoryInfo2222");
			return -1;
		}else{
			System.out.print("成功进入addNewCategoryInfo33333");
			String sql2 = "Insert into categoryinfo(CateName, Remark) values(?, ?)";
			String[] params2 = {cateName, cateRemark};
			
			if(db.executeUpdate(sql2, params2) > 0){//执行插入成功！
				return 1;
			}else{//插入失败
				return -2;
			}
		}
	}
	
}
