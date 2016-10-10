package Model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import Core.DBOper;



//管理员
public class AdminInfo {
	public int id;
	public String AdminNum;
	public String AdminPwd;
	public String AdminName;
	public String Email;
	public String Phone;
	public Timestamp SubTime;
	public int DelFlag;
	public String State;
	public String Remark;
	
	    //检查管理员登录方法
		public  String CheckLogin(String username, String password){
			System.out.println("进入数据访问层成功");
			String sql="select * from AdminInfo where AdminNum=? and AdminPwd=? and DelFlag=0";
			String[] params={username,password};
			
			DBOper db=new DBOper();
			ResultSet rst = db.executeQuery(sql, params);
			
			try {
				if(rst.next()){   
					return "success";
				}else{
					return "error";  
				}
			} catch (SQLException e) {
				// TODO �Զ����ɵ� catch ��
				//e.printStackTrace();
				return "error";
			}
		}

		//根据管理员编号查询取得该管理员的信息
		public AdminInfo getAdminInfoByStuNum(String adminNum) {
			// TODO 自动生成的方法存根
			System.out.println("进入数据访问层getAdminInfoByStuNum(String adminNum)成功");
			AdminInfo s = new AdminInfo();
			
			String sql = "select * from AdminInfo where DelFlag =0 and  AdminNum =?";
			String[] params = {adminNum};
			
			ResultSet rst =  new DBOper().executeQuery(sql, params);
			
			try {
				if(rst.next()){
					//编号
					if(rst.getString(2) == null){
						s.AdminNum="";
					}else{
						s.AdminNum=rst.getString(2);
					}
					//姓名
					if(rst.getString(4) == null){
						s.AdminName="";
					}else{
						s.AdminName=rst.getString(4);
					}
					//邮箱
					if(rst.getString(5) == null){
						s.Email="";
					}else{
						s.Email=rst.getString(5);
					}
					//电话
					if(rst.getString(6) == null){
						s.Phone="";
					}else{
						s.Phone=rst.getString(6);
					}
					//注册时间
					if(rst.getTimestamp(7) == null){

					}else{
						s.SubTime=rst.getTimestamp(7);
						System.out.println("SubTime:"+s.SubTime);
					}
					
				}else{
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return s;
		}

		//修改管理员密码
		public String updateAdminPwd(String userName, String oldPwd,String newPwd){
			String sql="Update AdminInfo set AdminPwd = ? where AdminNum = ? and AdminPwd=?";
			String[] params={newPwd,userName,oldPwd};
			
			int n = new DBOper().executeUpdate(sql, params);
			
			if(n>0){
				return "success";
			}else{
				return "error";
			}
		}

		//修改管理员基本信息
		public String updateAdminInfo(String userName, String Email, String Phone, String userNum){
			System.out.println("进入数据访问层updateAdminInfo(成功");
			
			String sql="Update AdminInfo set AdminName = ?, Email=?, Phone=? where AdminNum = ?";
			String[] params={userName, Email, Phone, userNum};
			
			int n = new DBOper().executeUpdate(sql, params);
			
			if(n>0){
				return "success";
			}else{
				return "error";
			}
		}
}
