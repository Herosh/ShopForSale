package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;

import Model.AdminInfo;
import Model.GoodsInfo;
import Model.UserInfo;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpServletRequest myRequest;
	private HttpServletResponse myResponse;
	private HttpSession mySession;
	private String action;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");                  //request中文转码
		response.setContentType("text/html;charset=utf-8");     //response中文转码
		
		// 初始化常用的参数
		this.myRequest = request;
		this.myResponse = response;
		this.mySession = request.getSession();
		//PrintWriter out=response.getWriter();
				
		System.out.println("进入AdminController成功！");
				
		this.action = request.getParameter("a") == null ? "Index" : request.getParameter("a");
		
		if (action.equals("CheckLogin")) {
			//【调用验证管理员登录Action】
			CheckLoginAction();
		}else if(action.equals("Index") && IsLogin()) {
			//【用户已经登录成功，直接进来，跳转员工主页】
			try {
				ShowAdminInfoAction();
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("updateAdminPwd") && IsLogin()){
			// 【调用修改管理员密码Action】
			UpdateAdminPwdAction();
		}else if(action.equals("UpdateAdminInfo") && IsLogin()){
			// 【调用修改管理员基本信息Action】
			UpdateAdminInfoAction();
		}else if(action.equals("AddUserInfo") && IsLogin()){
			// 【调用添加员工Action】
			AddUserInfoAction();
		}else if (action.equals("QueryAllUserInfo")&& IsLogin()){
			// 【查询所有员工Action】
			try {
				QueryAllUserInfoAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("UpdateUserInfo")&& IsLogin()){
			// 【更新员工信息Action】
			UpdateUserInfoAction();
		}else if(action.equals("DeleteUserInfo")&& IsLogin()){
			// 【删除员工信息Action】
			DeleteUserInfoAction();
		}else if(action.equals("QueryUserInfoByItem")&& IsLogin()){
			//【条件查询员工信息Action】
			try {
				QueryUserInfoByItemAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("PrintUserInfo")&& IsLogin()){
			//【导出员工信息到Excel表Action】
			try {
				PrintUserInfoAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("QueryAllGoodsInfo")&& IsLogin()){
			// 【查询所有商品Action】
			try {
				QueryAllGoodsInfoAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("PrintAllGoodsInfo")&& IsLogin()){
			// 【导出所有商品信息到Excel表Action】
			try {
				PrintAllGoodsInfoAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("QueryGoodsInfoByItem")&& IsLogin()){
			// 【条件查询商品信息Action】
			try {
				QueryGoodsInfoByItemAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}else if(action.equals("DeleteGoodsInfo")&& IsLogin()){
			// 【删除商品信息Action】
			DeleteGoodsInfoAction();
		}else if(action.equals("UpdateGoodsInfo")&& IsLogin()){
			// 【更改商品信息Action】
			UpdateGoodsInfoAction();
		}else{
			// 【管理员没有登录，跳转登录页面】
			response.sendRedirect("./login.html");
		}
		
	} 
	    //检查登录
	    // 验证管理员登录Action
		public void CheckLoginAction() throws IOException {
			System.out.print("进入CheckLoginAction()成功");
			String username = myRequest.getParameter("username");
			String password = myRequest.getParameter("password");

			String rst = new AdminInfo().CheckLogin(username, password);
			System.out.println("数据访问完成，返回rst："+rst);

			if (rst == "success") {
				
				mySession.setAttribute("username", username);
				mySession.setAttribute("usertype", "admin");
				
				myResponse.getWriter().print("success");
			} else {
				myResponse.getWriter().print("error");
			}
		}
		
		//判断是否登录
		// 通过查看session中的username是否为空，检查用户是否登陆
		public Boolean IsLogin() {
			if (mySession.getAttribute("username") != null && mySession.getAttribute("usertype") != null && mySession.getAttribute("usertype").toString().equals("admin")) {
				return true;
			} else {
				return false;
			}
		}

		//展示管理员信息
		//展示管理员主页信息Action
		public void ShowAdminInfoAction() throws ParseException, ServletException, IOException{
			String adminNum=mySession.getAttribute("username").toString();
			
			AdminInfo admin=new AdminInfo().getAdminInfoByStuNum(adminNum);
			
			if (admin != null) {
				System.out.println("数据访问成功，返回");
				mySession.setAttribute("truename", admin.AdminName);

				myRequest.setAttribute("admin", admin);
				// System.out.print(s.StuName);
			}
			//跳转到管理员主页
			RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Admin/admin.jsp");
			dispatcher.forward(myRequest, myResponse);
			
		}

		//修改密码
		//修改管理员密码Action
		public void UpdateAdminPwdAction() throws IOException{
			String username=mySession.getAttribute("username").toString();
			String oldPwd=myRequest.getParameter("oldPwd").toString();
			String newPwd=myRequest.getParameter("newPwd").toString();
			
			System.out.print("进入数据访问层访问数据！");
			String rst=new AdminInfo().updateAdminPwd(username, oldPwd, newPwd);
			System.out.print("rst:"+rst);
			myResponse.getWriter().print(rst);
		}

		//更改信息
		//修改基本信息Action
		public void UpdateAdminInfoAction() throws IOException{
			System.out.println("进入UpdateAdminInfoAction()成功！");
			
			String userName=myRequest.getParameter("UserName");
			String Email=myRequest.getParameter("Email");
			String Phone=myRequest.getParameter("Phone");
			
			String userNum=mySession.getAttribute("username").toString();
			
			System.out.println(userName+Email+Phone+userNum);
			String rst=new AdminInfo().updateAdminInfo(userName,  Email, Phone, userNum);
			myResponse.getWriter().print(rst);
		}
        
		//添加员工Action
		public void AddUserInfoAction() throws IOException{
			String userNum=myRequest.getParameter("userNum");
			String userName=myRequest.getParameter("userName");
			String gender=myRequest.getParameter("gender");
			
			String rst=new UserInfo().addUserInfo(userNum, userName, gender);
			myResponse.getWriter().print(rst);
		}

		//查询所有员工Action
		public void QueryAllUserInfoAction() throws SQLException, ParseException, IOException{
			ArrayList<UserInfo> userInfoArr = new UserInfo().getAllUserInfo();
			System.out.println("数据访问层返回完成！");
			
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"Total\"" + ":\"" + userInfoArr.size() + "\"");
			sb.append(",\"Row\":[");
			
			for (int i = 0; i < userInfoArr.size(); i++) {
				UserInfo userInfo = userInfoArr.get(i);
				
				sb.append("{");
				sb.append("\"userName\"" + ":\"" + userInfo.UserName + "\",");
				sb.append("\"userNum\"" + ":\"" + userInfo.UserNum + "\",");
				sb.append("\"phone\"" + ":\"" + userInfo.Phone + "\",");
				sb.append("\"gender\"" + ":\"" + userInfo.Gender + "\",");
				sb.append("\"email\"" + ":\"" + userInfo.Email + "\"");

				if (i == userInfoArr.size() - 1) {
					sb.append("}");
				} else {
					sb.append("},");
				}
			}
			
			sb.append("]");
			sb.append("}");
			
			myResponse.getWriter().print(sb.toString());	
		}

		//更改员工信息
		//更新修改员工信息Action
		public void UpdateUserInfoAction() throws IOException{
			System.out.println("进入UpdateUserInfoAction()成功！");
			String oldUserNum=myRequest.getParameter("oldUserNum");
			String newUserNum=myRequest.getParameter("newUserNum");
			String newUserName=myRequest.getParameter("newUserName");
			
			String newGender=myRequest.getParameter("newGender");
			String newEmail=myRequest.getParameter("newEmail");
			String newPhone=myRequest.getParameter("newPhone");
			
			System.out.println(oldUserNum+newUserNum+newUserName+newGender+newEmail+newPhone);
			String rst=new UserInfo().updateUserInfo(oldUserNum, newUserNum, newUserName, newGender, newEmail, newPhone);
			System.out.println("数据访问层返回完成！"+rst);
			myResponse.getWriter().print(rst);
		}
		
		//删除员工
		//删除员工信息Action
		public void DeleteUserInfoAction() throws IOException{
			System.out.println("进入DeleteUserInfoAction()成功！");
			String userNum=myRequest.getParameter("userNum");
			
			String rst=new UserInfo().deleteUserInfo(userNum);
			System.out.println("数据访问层返回完成！"+rst);
			myResponse.getWriter().print(rst);
		}

		//条件查询员工信息
		//条件查询员工信息Action
		public void QueryUserInfoByItemAction() throws SQLException, ParseException, IOException{
			System.out.println("进入QueryUserInfoByItemAction()成功！");
			String userNum=myRequest.getParameter("txtUserNum");
			String userName=myRequest.getParameter("txtUserName");
			String gender=myRequest.getParameter("txtGender");
			
			ArrayList<UserInfo> userInfoArr = new UserInfo().QueryUserInfoByItem(userNum, userName, gender);
			System.out.println("数据访问层返回完成！");
			
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"Total\"" + ":\"" + userInfoArr.size() + "\"");
			sb.append(",\"Row\":[");
			
			for (int i = 0; i < userInfoArr.size(); i++) {
				UserInfo userInfo = userInfoArr.get(i);
				
				sb.append("{");
				sb.append("\"userName\"" + ":\"" + userInfo.UserName + "\",");
				sb.append("\"userNum\"" + ":\"" + userInfo.UserNum + "\",");
				sb.append("\"phone\"" + ":\"" + userInfo.Phone + "\",");
				sb.append("\"gender\"" + ":\"" + userInfo.Gender + "\",");
				sb.append("\"email\"" + ":\"" + userInfo.Email + "\"");

				if (i == userInfoArr.size() - 1) {
					sb.append("}");
				} else {
					sb.append("},");
				}
			}
			
			sb.append("]");
			sb.append("}");
			
			myResponse.getWriter().print(sb.toString());	
		}

		//导出员工信息到Excel表
		//导出员工信息到Excel表Action
		public void PrintUserInfoAction() throws SQLException, ParseException, IOException{
			System.out.println("进入PrintAction()成功！");
			
			ArrayList<UserInfo> userInfoArr=new UserInfo().getAllUserInfo();
			
			myResponse.setContentType("text/html;charset=GBK");
			myResponse.setContentType("application/xml");
			myResponse.setHeader("Content-Disposition","attachment;filename="+new String("员工信息".getBytes(),"iso-8859-1")+".xls");

			HSSFWorkbook workbook=new HSSFWorkbook();//创建一个excal文档
			HSSFSheet sheet=workbook.createSheet();//创建一个工作本
			HSSFCell cell=null;//声明一个单元格对象
			
			//.设置列宽
			sheet.setColumnWidth(Short.parseShort("0"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("1"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("2"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("3"),Short.parseShort("2000"));
			sheet.setColumnWidth(Short.parseShort("4"),Short.parseShort("5000"));
			sheet.setColumnWidth(Short.parseShort("5"),Short.parseShort("4000"));

			HSSFCellStyle style=workbook.createCellStyle();//创建风格
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			//合并单元格
			sheet.addMergedRegion(new CellRangeAddress(0,0,0,3));
			sheet.addMergedRegion(new CellRangeAddress(1,1,0,3));
			sheet.addMergedRegion(new CellRangeAddress(2,2,0,3));
			cell=sheet.createRow(0).createCell(0);
			cell.setCellStyle(style);
		    cell.setCellValue(new HSSFRichTextString("员工信息"));
		    cell=sheet.createRow(2).createCell(0);
		    cell.setCellStyle(style);
		    cell.setCellValue(new HSSFRichTextString(""));

		    //设置边框的样式
		    HSSFCellStyle tableStyle=workbook.createCellStyle();
		    tableStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    tableStyle.setBorderTop((short)1);
		    tableStyle.setBorderBottom((short)1);
		    tableStyle.setBorderLeft((short)1);
		    tableStyle.setBorderRight((short)1);

		    //生成表头
		    String[] bt=new String[]{"序号","员工编号","姓名","性别","邮箱","电话"};
		    HSSFRow row=sheet.createRow(3);

		    for(int i=0;i<bt.length;i++){
		    cell=row.createCell(i);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(bt[i]));
		    }

		    //写入表格的内容
		    for(int i=0;i<userInfoArr.size();i++){
		    	
		    UserInfo userInfo=userInfoArr.get(i);//对应对对象数组中的每个对象
		    row=sheet.createRow(i+4);//创建一个对象

		    cell=row.createCell(0);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(i)));

		    cell=row.createCell(1);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(userInfo.UserNum.toString()));

		    cell=row.createCell(2);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(userInfo.UserName.toString()));

		    cell=row.createCell(3);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(userInfo.Gender.toString()));

		    cell=row.createCell(4);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(userInfo.Email)));

		    cell=row.createCell(5);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(userInfo.Phone)));
		    
		    }

		    try {
				workbook.write(myResponse.getOutputStream());
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}	
		}	

		//查询所有商品信息Action
		public void QueryAllGoodsInfoAction() throws IOException, SQLException{
			System.out.println("进入QueryAllGoodsInfoAction()成功！");
			
			ArrayList<GoodsInfo> goodsInfoArr = new GoodsInfo().getAllGoodsInfo();
			System.out.println("数据访问层返回完成！");
			
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"Total\"" + ":\"" + goodsInfoArr.size() + "\"");
			sb.append(",\"Row\":[");
			
			for (int i = 0; i < goodsInfoArr.size(); i++) {
				GoodsInfo goodsInfo = goodsInfoArr.get(i);
				
				sb.append("{");
				sb.append("\"goodsNum\"" + ":\"" + goodsInfo.GoodsNum + "\",");
				sb.append("\"goodsName\"" + ":\"" + goodsInfo.GoodsName + "\",");
				sb.append("\"cateName\"" + ":\"" + goodsInfo.CateName + "\",");
				sb.append("\"price\"" + ":\"" + goodsInfo.Price + "\",");
				sb.append("\"totalNumber\"" + ":\"" + goodsInfo.TotalNumber + "\",");
				sb.append("\"saleNumber\"" + ":\"" + goodsInfo.SaleNumber + "\"");

				if (i == goodsInfoArr.size() - 1) {
					sb.append("}");
				} else {
					sb.append("},");
				}
			}
			
			sb.append("]");
			sb.append("}");
			
			myResponse.getWriter().print(sb.toString());
		}

		//导出所有商品信息到Excel表Action
		public void PrintAllGoodsInfoAction() throws SQLException, UnsupportedEncodingException{
			System.out.println("进入PrintAction()成功！");
			
			ArrayList<GoodsInfo> goodsInfoArr=new GoodsInfo().getAllGoodsInfo();
			
			myResponse.setContentType("text/html;charset=GBK");
			myResponse.setContentType("application/xml");
			myResponse.setHeader("Content-Disposition","attachment;filename="+new String("商品信息".getBytes(),"iso-8859-1")+".xls");

			HSSFWorkbook workbook=new HSSFWorkbook();//创建一个excal文档
			HSSFSheet sheet=workbook.createSheet();//创建一个工作本
			HSSFCell cell=null;//声明一个单元格对象
			
			//.设置列宽
			sheet.setColumnWidth(Short.parseShort("0"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("1"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("2"),Short.parseShort("3000"));
			sheet.setColumnWidth(Short.parseShort("3"),Short.parseShort("2000"));
			sheet.setColumnWidth(Short.parseShort("4"),Short.parseShort("5000"));
			sheet.setColumnWidth(Short.parseShort("5"),Short.parseShort("4000"));

			HSSFCellStyle style=workbook.createCellStyle();//创建风格
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			//合并单元格
			sheet.addMergedRegion(new CellRangeAddress(0,0,0,3));
			sheet.addMergedRegion(new CellRangeAddress(1,1,0,3));
			sheet.addMergedRegion(new CellRangeAddress(2,2,0,3));
			cell=sheet.createRow(0).createCell(0);
			cell.setCellStyle(style);
		    cell.setCellValue(new HSSFRichTextString("商品信息"));
		    cell=sheet.createRow(2).createCell(0);
		    cell.setCellStyle(style);
		    cell.setCellValue(new HSSFRichTextString(""));

		    //设置边框的样式
		    HSSFCellStyle tableStyle=workbook.createCellStyle();
		    tableStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		    tableStyle.setBorderTop((short)1);
		    tableStyle.setBorderBottom((short)1);
		    tableStyle.setBorderLeft((short)1);
		    tableStyle.setBorderRight((short)1);

		    //生成表头
		    String[] bt=new String[]{"编号","商品名","商品类型","销售价格","库存量","已售量"};
		    HSSFRow row=sheet.createRow(3);

		    for(int i=0;i<bt.length;i++){
		    cell=row.createCell(i);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(bt[i]));
		    }

		    //写入表格的内容
		    for(int i=0;i<goodsInfoArr.size();i++){
		    	
		    GoodsInfo goodsInfo=goodsInfoArr.get(i);//对应对对象数组中的每个对象
		    row=sheet.createRow(i+4);//创建一个对象

		    cell=row.createCell(0);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(goodsInfo.GoodsNum.toString()));

		    cell=row.createCell(1);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(goodsInfo.GoodsName.toString()));

		    cell=row.createCell(2);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(goodsInfo.CateName.toString()));

		    cell=row.createCell(3);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(goodsInfo.Price)));

		    cell=row.createCell(4);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(goodsInfo.TotalNumber)));

		    cell=row.createCell(5);
		    cell.setCellStyle(tableStyle);
		    cell.setCellValue(new HSSFRichTextString(String.valueOf(goodsInfo.SaleNumber)));
		    
		    }

		    try {
				workbook.write(myResponse.getOutputStream());
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}	
		}

		//条件查询商品信息
		public void QueryGoodsInfoByItemAction() throws IOException, SQLException{
			System.out.println("进入QueryUserInfoByItemAction()成功！");
			String goodsNum=myRequest.getParameter("txtGoodsNum");
			String goodsName=myRequest.getParameter("txtGoodsName");
			String cateName=myRequest.getParameter("txtCateName");
			
			ArrayList<GoodsInfo> goodsInfoArr = new GoodsInfo().QueryGoodsInfoByItem(goodsNum, goodsName, cateName);
			System.out.println("数据访问层返回完成！");
			
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"Total\"" + ":\"" + goodsInfoArr.size() + "\"");
			sb.append(",\"Row\":[");
			
			for (int i = 0; i < goodsInfoArr.size(); i++) {
				GoodsInfo goodsInfo = goodsInfoArr.get(i);
				
				sb.append("{");
				sb.append("\"goodsNum\"" + ":\"" + goodsInfo.GoodsNum + "\",");
				sb.append("\"goodsName\"" + ":\"" + goodsInfo.GoodsName + "\",");
				sb.append("\"cateName\"" + ":\"" + goodsInfo.CateName + "\",");
				sb.append("\"price\"" + ":\"" + goodsInfo.Price + "\",");
				sb.append("\"totalNumber\"" + ":\"" + goodsInfo.TotalNumber + "\",");
				sb.append("\"saleNumber\"" + ":\"" + goodsInfo.SaleNumber + "\"");

				if (i == goodsInfoArr.size() - 1) {
					sb.append("}");
				} else {
					sb.append("},");
				}
			}
			
			sb.append("]");
			sb.append("}");
			
			myResponse.getWriter().print(sb.toString());	
		}

		//删除商品信息
		public void DeleteGoodsInfoAction() throws IOException{
			System.out.println("进入DeleteGoodsInfoAction()成功！");
			String goodsNum=myRequest.getParameter("goodsNum");
			
			String rst=new GoodsInfo().deleteGoodsInfo(goodsNum);
			System.out.println("数据访问层返回完成！"+rst);
			myResponse.getWriter().print(rst);
		}

		//更改商品信息
		public void UpdateGoodsInfoAction() throws IOException{
			System.out.println("进入UpdateGoodsInfoAction()成功！");
			String oldGoodsNum=myRequest.getParameter("oldGoodsNum");
			
			String newGoodsNum=myRequest.getParameter("newGoodsNum");
			String newGoodsName=myRequest.getParameter("newGoodsName");
			String newCateName=myRequest.getParameter("newCateName");
			String newPrice=myRequest.getParameter("newPrice");
			String newTotalNumber=myRequest.getParameter("newTotalNumber");
			String newSaleNumber=myRequest.getParameter("newSaleNumber");
			
			System.out.println(oldGoodsNum+newGoodsNum+newGoodsNum+newCateName+newPrice+newTotalNumber+newSaleNumber);
			String rst=new GoodsInfo().updateGoodsInfo(oldGoodsNum, newGoodsNum, newGoodsName, newCateName, newPrice, newTotalNumber, newSaleNumber);
			System.out.println("数据访问层返回完成！"+rst);
			myResponse.getWriter().print(rst);
		}
}
