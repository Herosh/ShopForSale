package Model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Core.DBOper;

//供货商
public class ProviderInfo {
	public int id;//供货商编号 
	
	public String ProvideName;//供货商名字
	public String Address;//地址 
	public String Phone;//联系方式
	
	public java.sql.Timestamp SubTime;
	public int DelFlag;
	public String State;
	public String Remark;
	
	//查找所有供货商信息
	public ArrayList<ProviderInfo> getAllProviderInfo() throws SQLException{
		String sql = "select * from providerinfo where DelFlag = 0";
		String params[] = {};
		ArrayList<ProviderInfo> list = new ArrayList<ProviderInfo>();
		DBOper db = new DBOper();
		ResultSet rst = db.executeQuery(sql, params);
		ProviderInfo provider;
		while(rst.next()){
			provider = new ProviderInfo();
			provider.id = rst.getInt(1);
			provider.ProvideName = rst.getString(2);
			provider.Address = rst.getString(3);
			provider.Phone = rst.getString(4);
			provider.SubTime = rst.getTimestamp(5);
			//6 -- DelFlag
			provider.State = rst.getString(7);
			provider.Remark = rst.getString(8);
			
			list.add(provider);
			
		}
		
		return list;
		
		
	}
	
	
	
	
	
	
}
