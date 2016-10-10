package Controller;

import java.awt.SystemColor;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.jws.soap.SOAPBinding;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Core.Controller;
import Core.ExcelUtil;
import Model.BackInfo;
import Model.CategoryInfo;
import Model.ExportInfo;
import Model.GoodsInfo;
import Model.ImportInfo;
import Model.ProviderInfo;
import Model.UserInfo;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/HomeController")
public class HomeController extends Controller {
	// private static final long serialVersionUID = 1L;
	// private HttpServletRequest myRequest;
	// private HttpServletResponse myResponse;
	// private HttpSession mySession;
	// private String action;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomeController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8"); // request中文转码
		response.setContentType("text/html;charset=utf-8"); // response中文转码

		// 初始化常用的参数
		this.myRequest = request;
		this.myResponse = response;
		this.mySession = request.getSession();

		System.out.println("进入HomeController成功！");

		this.action = request.getParameter("a") == null ? "Index" : request.getParameter("a");

		// System.out.println("action="+action);
		// System.out.println("action End");
		if (action.equals("CheckLogin")) {
			// 【调用检查登录Action】
			CheckLoginAction();
		} else if (action.equals("Index") && IsLogin()) {
			// 【用户已经登录成功，直接进来，跳转员工主页】
			try {
				ShowUserInfoAction();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if (action.equals("updateStaffPwd") && IsLogin()) {
			// 【调用修改员工密码Action】
			UpdateStaffPwdAction();
		} else if (action.equals("Exit") && IsLogin()) {
			Exit();
		} else if (action.equals("UpdateStaffInfo") && IsLogin()) {
			// 【调用修改员工基本信息Action】
			System.out.println("进入action.equals('UpdateStaffInfo')成功！");
			UpdateStaffInfoAction();
		} else if (action.equals("UpdatePwd") && IsLogin()) {
			UpdatePwdAction();
		} else if (action.equals("EnterGoodsExport") && IsLogin()) {
			// 【调用进入商品销售页面Action】
			try {
				EnterGoodsExportAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (action.equals("SaleGoods") && IsLogin()) {
			// 【调用购买商品Action】
			SaleGoodsAction();
		} else if (action.equals("SaleBack") && IsLogin()) {
			// 【调用退货Action】
			SaleBackAction();
		} else if (action.equals("QueryExportInfo") && IsLogin()) {
			// 【调用查询销售单号Action】
			QueryExportInfoAction();
		} else if (action.equals("EnterGoodsImport") && IsLogin()) {
			System.out.println( myRequest.getRealPath("/"));
			// 【调用进入入货页面Action】
			try {
				EnterGoodsImportAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (action.equals("GoodsImport") && IsLogin()) {
			// 【调用查询销售单号Action】
			try {
				GoodsImportAction();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (action.equals("EnterGoodsBack") && IsLogin()) {
			//进入退货页面
			// System.out.print("2222222222222");
			try {
				GoodsBackAction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (action.equals("UpToSale") && IsLogin()) {
			// 调用商品上架
			UpToSaleAction();
		}else if(action.equals("DownToSale") && IsLogin()){
			DownToSaleAction();
		}else if(action.equals("test")){
			test();
		}else if(action.equals("AddNewCategory") && IsLogin()){
			//调用商品分类新增方法
			try {
				AddNewCategoryAction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(action.equals("AddNewGoodsInfo") && IsLogin() ){
			//调用商品新增方法
			try {
				AddNewGoodsInfoAction();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(action.equals("EnterSubBackInfo") && IsLogin()){
			//进入填写退货信息页面
			EnterSubBackInfoAction();
		
		}else if(action.equals("InsertBackInfo") && IsLogin()){
			//插入退货信息
			InsertBackInfoAction();
		
		} else {
			// 【用户还没有登录直接进来，跳转登录页面】
			response.sendRedirect("./login.html");

		}
	}
	
	//执行插入退货信息
	public void InsertBackInfoAction() throws IOException{
		String exportId = myRequest.getParameter("id");
		String goodsNum = myRequest.getParameter("goodsNum");
		String goodsName = myRequest.getParameter("goodsName");
		String custName = myRequest.getParameter("custName");
		String custPhone = myRequest.getParameter("custPhone");
		String description = myRequest.getParameter("description");
		
		int rst1 = new ExportInfo().updateStateAsBack(Integer.valueOf(exportId) , "退货");
		if(rst1 > 0){
			int rst2 = new BackInfo().SaleBack2(exportId, goodsNum, goodsName, custName, custPhone, description, mySession.getAttribute("username").toString(), mySession.getAttribute("truename").toString());
			
			if(rst2 > 0){
				myResponse.getWriter().print("success");
			}else{
				myResponse.getWriter().print("error2");
			}
			
		}else{
			myResponse.getWriter().print("error3");
		}
		
		
	}
	
	
	
	//进入退货信息登记页面
	public void EnterSubBackInfoAction() throws ServletException, IOException{
		String id = myRequest.getParameter("exportId");
		
		ExportInfo exportInfo = new ExportInfo().QueryExportInfoByExportId(id);
		myRequest.setAttribute("exportInfo", exportInfo);
		
		
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/SubBackInfo.jsp");
		dispatcher.forward(myRequest, myResponse);
	}
	
	//新增商品信息
	public void AddNewGoodsInfoAction() throws SQLException, IOException{
		String goodsName = myRequest.getParameter("newGoodsName");
		String categoryAndId = myRequest.getParameter("newCategory");
		String categoryAndIds[] = categoryAndId.split("#"); 
		String id = categoryAndIds[1];
		String category = categoryAndIds[0];
		String isSale = myRequest.getParameter("newIsSale");
		String goodsnum = myRequest.getParameter("goodsnum");
		
		//供应商的部分信息
		String providerNameAndId = myRequest.getParameter("providerName");
		String pName = "";
		int pId = 0;
		int newTotalNumber = 0;
		int price = 0;
		if(!providerNameAndId.equals("0")){
			newTotalNumber = Integer.parseInt(myRequest.getParameter("newTotalNumber"));
			price = Integer.parseInt(myRequest.getParameter("price"));
			
			//截取供应商名字和编号
			String providerNameAndIds[] = providerNameAndId.split("#");
			pName = providerNameAndIds[0];
			pId = Integer.parseInt(providerNameAndIds[1]);
		}
		
		
		String salePrice = myRequest.getParameter("newSalePrice");
		String remark = myRequest.getParameter("newRemark");
		
		//System.out.print("id="+id+", categoryname="+category);
		
		
		//填充商品信息表，执行插入操作
		GoodsInfo goods = new GoodsInfo();
		goods.CateId = Integer.parseInt(id);
		goods.CateName = category;
		goods.Remark = remark;
		goods.GoodsName = goodsName;
		goods.IsSale = 0;
		goods.Price = Integer.parseInt(salePrice);
		goods.TotalNumber = newTotalNumber;
		goods.SaleNumber = 0;
		goods.IsSale = Integer.parseInt(isSale);
		goods.State = "正常";
		
		goods.GoodsNum = goods.getNewGoodsNum();
		
		
		
		
		//判断是采购还是新增
		String type = myRequest.getParameter("type");
		if(providerNameAndId.equals("0")){
			//执行插入操作
			if(type.equals("1")){//采购
				myResponse.getWriter().print("error");
			}else{
			
				int rst = goods.AddNewGoodsInfo(goods);
				if(rst > 0){
					myResponse.getWriter().print("success");
				}else{
					myResponse.getWriter().print("error1");
				}
			}
		}else{
			
			//判断是采购还是新增
			int rst = 0;
			if(type.equals("1")){//采购
				if(!goodsnum.equals("")){
					rst = goods.UpdateGodosInfoAsBuy(goodsnum, goods.Price, goods.IsSale, goods.TotalNumber);
				}else{
					myResponse.getWriter().print("error");
				}
				
			}else{//新增
				rst = goods.AddNewGoodsInfo(goods);
			}

		
			if(rst > 0){
				//填充进货信息
				ImportInfo importinfo = new ImportInfo();
				importinfo.GoodsNum = goods.GoodsNum;
				importinfo.GoodsName = goodsName;
				importinfo.ProviderId = pId;
				importinfo.ProviderName = pName;
				importinfo.Number = newTotalNumber;
				importinfo.Price = price;
				importinfo.UserNum = mySession.getAttribute("username").toString();
				importinfo.UserName = mySession.getAttribute("truename").toString();
				
				int rst2 = importinfo.AddImportInfo(importinfo);
				if(rst2 > 0){
					myResponse.getWriter().print("success");
				}else{
					myResponse.getWriter().print("error2");
				}
			}else{
				myResponse.getWriter().print("error3");
			}
		}
		
		//myResponse.getWriter().print(goods.getNewGoodsNum()) ;
		
	}
	

	//测试
	public void test() throws ServletException, IOException{
		
		ExcelUtil excel = new ExcelUtil();
		List<HashMap<String, Object>> list = null;

		try {
			list = new ArrayList<HashMap<String, Object>>();
			
			// 实例化数据库连接工具类
			//dbu = new DataBaseUtil();
			//String sql = "select StuNum,StuName,StuPwd from stuinfo";
			// = dbu.getQuery(sql);
			
			HashMap<String, Object> map = null;
			for(int i =0; i < 10; i ++){
				map = new HashMap<String,Object>();
				String stuNum = "stuNum"+i;
				String stuName = "stuName"+i;
				String stuPwd = "stuPwd"+i;
				
				map.put("stuNum", stuNum);
				map.put("stuName", stuName);
				map.put("stuPwd", stuPwd);
				
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		try {
			String path = myRequest.getRealPath("/") + "students.xls";
			excel.exportExcelData(list, path);
		
			RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/UpdatePwd.jsp");
			dispatcher.forward(myRequest, myResponse);
		} catch (RowsExceededException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//新增商品分类
	public void AddNewCategoryAction() throws SQLException, IOException{
		String cateName = myRequest.getParameter("cateName");
		String cateRemark = myRequest.getParameter("cateRemark");
		
		CategoryInfo cate = new CategoryInfo();
		int rst = cate.addNewCategoryInfo(cateName, cateRemark);
		if(rst == 1){//执行成功
			myResponse.getWriter().print("success");
		}else if(rst == -1){
			myResponse.getWriter().print("error1");
		}else{
			myResponse.getWriter().print("error2");
		}
	}
	
	
	//商品下架
	public void DownToSaleAction() {
		try {
			String goodsNum = myRequest.getParameter("goodsNum");
			int rst = new GoodsInfo().ExecuteDownToSale(goodsNum);
			if (rst > 0) {
				myResponse.getWriter().print("success");
			} else {

				myResponse.getWriter().print("error");

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	// 商品上架
	public void UpToSaleAction() {
		try {
			String goodsNum = myRequest.getParameter("goodsNum");
			int rst = new GoodsInfo().ExecuteUpToSale(goodsNum);
			if (rst > 0) {
				myResponse.getWriter().print("success");
			} else {

				myResponse.getWriter().print("error");

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 更改密码
	public void UpdatePwdAction() throws ServletException, IOException {
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/UpdatePwd.jsp");
		dispatcher.forward(myRequest, myResponse);
	}

	// 退货处理
	public void GoodsBackAction() throws ServletException, IOException, SQLException {
		// 跳转到退货处理页面
		//反馈订单信息
		ArrayList<ExportInfo> exportInfoArr = new ExportInfo().getAllExportInfo();
		myRequest.setAttribute("exportInfoArr", exportInfoArr);
		
		
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/GoodsBack.jsp");
		dispatcher.forward(myRequest, myResponse);
	}

	// 检查登录信息Action
	public void CheckLoginAction() throws IOException {
		System.out.println("进入CheckLoginAction()成功！");
		String username = myRequest.getParameter("username");
		String password = myRequest.getParameter("password");

		String rst = new UserInfo().CheckLogin(username, password);
		System.out.println("数据访问完成！rst返回");

		if (rst == "success") {
			mySession.setAttribute("username", username);
			mySession.setAttribute("usertype", "user");

			myResponse.getWriter().print("success");
		} else {
			myResponse.getWriter().print("error");
		}
	}

	// 通过查看session中的username是否为空，检查用户是否登陆
	public Boolean IsLogin() {
		if (mySession.getAttribute("username") != null && mySession.getAttribute("usertype") != null && mySession.getAttribute("usertype").toString().equals("user")) {
			return true;
		} else {
			return false;
		}
	}

	// 展示员工主页信息Action
	public void ShowUserInfoAction() throws ParseException, ServletException, IOException {
		System.out.println("进入ShowUserInfoAction()成功！");
		String userNum = mySession.getAttribute("username").toString();

		UserInfo user = new UserInfo().getUserInfoByStuNum(userNum);
		System.out.println("数据访问成功，返回");

		if (user != null) {
			mySession.setAttribute("truename", user.UserName);

			myRequest.setAttribute("user", user);
			// System.out.print(s.StuName);
		}
		// 跳转到员工主页
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/Index.jsp");
		dispatcher.forward(myRequest, myResponse);

	}

	// 修改员工密码Action
	public void UpdateStaffPwdAction() throws IOException {
		String username = mySession.getAttribute("username").toString();
		String oldPwd = myRequest.getParameter("oldPwd").toString();
		String newPwd = myRequest.getParameter("newPwd").toString();
		System.out.print("进入数据访问层访问数据！");
		String rst = new UserInfo().updateStaffPwd(username, oldPwd, newPwd);

		System.out.print("rst:" + rst);
		myResponse.getWriter().print(rst);
	}

	// 修改员工基本信息Action
	public void UpdateStaffInfoAction() throws IOException {
		System.out.println("进入UpdateStaffInfoAction()成功！");

		String userName = myRequest.getParameter("UserName");
		String Gender = myRequest.getParameter("Gender");
		String Email = myRequest.getParameter("Email");
		String Phone = myRequest.getParameter("Phone");
		String userNum = mySession.getAttribute("username").toString();

		System.out.println(userName + Gender + Email + Phone + userNum);
		String rst = new UserInfo().updateStaffInfo(userName, Gender, Email, Phone, userNum);

		myResponse.getWriter().print(rst);
	}

	// 进入商品销售页面Action
	public void EnterGoodsExportAction() throws ServletException, IOException, SQLException {
		//System.out.print("进入EnterGoodsExportAction()成功！");
		String sql = "select * from GoodsInfo where DelFlag =0 and IsSale = 1 order by GoodsNum desc";
		ArrayList<GoodsInfo> goodsInfoArr = new GoodsInfo().getAllGoodsInfo(sql);
		//获取商品类型列表
		ArrayList<CategoryInfo> cateInfoArr = new CategoryInfo().getAllCategoryInfo();
		//System.out.println("数据访问成功，返回");
		myRequest.setAttribute("goodsInfoArr", goodsInfoArr);
		myRequest.setAttribute("cateInfoArr", cateInfoArr);
		
		
		
		// 跳转到商品销售页
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/GoodsExport.jsp");
		dispatcher.forward(myRequest, myResponse);
	}

	// 购买商品Action
	public void SaleGoodsAction() throws IOException {
		System.out.println("进入SaleGoodsAction()成功！");

		String goodsNum = myRequest.getParameter("goodsnum");
		String goodsName = myRequest.getParameter("goodsname");
		String number = myRequest.getParameter("salenumber");
		String price = myRequest.getParameter("price");
		String userNum = (String) mySession.getAttribute("username");
		String userName = (String) mySession.getAttribute("truename");

		int rst1 = new GoodsInfo().UpdateGoodsInfoAsSale(goodsNum, Integer.valueOf(number));
		if(rst1 > 0){
			int rst2 = new ExportInfo().SaleGoods(userNum, userName, goodsNum, goodsName, number, price);
			if(rst2 > 0){
				myResponse.getWriter().print("success");
			}else{
				myResponse.getWriter().print("error2");
			}
		}else{
			myResponse.getWriter().print("error1");
		}
	}

	// 退货Action
	public void SaleBackAction() {
		System.out.println("进入SaleBackAction()成功！");

		String exportId = myRequest.getParameter("exportId");
		String goodsNum = myRequest.getParameter("goodsNum");
		String goodsName = myRequest.getParameter("goodsName");
		String customerPhone = myRequest.getParameter("customerPhone");
		String customerName = myRequest.getParameter("customerName");
		String description = myRequest.getParameter("description");

		String userNum = (String) mySession.getAttribute("username");
		String userName = (String) mySession.getAttribute("truename");

		String rst = new BackInfo().SaleBack(exportId, goodsNum, goodsName, customerName, customerPhone, description,
				userNum, userName);
		System.out.println("数据访问成功，返回");
		try {
			myResponse.getWriter().print(rst); // 返回js
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	// 查询销售单号Action
	public void QueryExportInfoAction() throws IOException {
		System.out.println("进入QueryExportInfo()成功！");
		String exportId = myRequest.getParameter("exportId");

		ExportInfo exportInfo = new ExportInfo().QueryExportInfoByExportId(exportId);

		System.out.println("数据访问成功，返回");
		if (exportInfo != null) {
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"Total\"" + ":\"" + 1 + "\"");
			sb.append(",\"Row\":[");

			sb.append("{");
			sb.append("\"Id\"" + ":\"" + exportInfo.Id + "\",");
			sb.append("\"GoodsNum\"" + ":\"" + exportInfo.GoodsNum + "\",");
			sb.append("\"GoodsName\"" + ":\"" + exportInfo.GoodsName + "\",");
			sb.append("\"Number\"" + ":\"" + exportInfo.Number + "\",");
			sb.append("\"Price\"" + ":\"" + exportInfo.Price + "\",");
			sb.append("\"UserNum\"" + ":\"" + exportInfo.UserNum + "\",");
			sb.append("\"UserName\"" + ":\"" + exportInfo.UserName + "\",");
			sb.append("\"SubTime\"" + ":\"" + exportInfo.SubTime + "\"");
			sb.append("}");

			sb.append("]");
			sb.append("}");
			myResponse.getWriter().print(sb.toString());
			/*
			 * JsonConfig jsonConfig=new JsonConfig(); JSONArray
			 * jsonarray=JSONArray.fromObject(exportInfo,jsonConfig);
			 * myResponse.getWriter().print(exportInfo);
			 * System.out.println("3333333333333");
			 */
			/*
			 * System.out.println("id:"+exportInfo.Id); //声明JSONObject
			 * JSONObject json=new JSONObject(); //传属性
			 * json=json.fromObject(exportInfo);
			 */
			// System.out.println(exportInfo.Id);
			// json.put("exportInfo",exportInfo);
			// json.put("s","123789");
			// json.put("t",123);

			// myResponse.getWriter().write(json.toString());
		} else {
			System.out.println("对象为空，单号不存在！");
			myResponse.getWriter().print("none");
		}
	}

	// 进入入货页面Action
	public void EnterGoodsImportAction() throws SQLException, ServletException, IOException {
		String sql = "select * from GoodsInfo where DelFlag =0  order by GoodsNum desc";
		//获取商品列表
		ArrayList<GoodsInfo> goodsInfoArr = new GoodsInfo().getAllGoodsInfo(sql);
		//获取商品类型列表
		ArrayList<CategoryInfo> cateInfoArr = new CategoryInfo().getAllCategoryInfo();
		//获取提供商列表
		ArrayList<ProviderInfo> proInfoArr = new ProviderInfo().getAllProviderInfo();
		System.out.println("数据访问成功，返回");
		myRequest.setAttribute("goodsInfoArr", goodsInfoArr);
		myRequest.setAttribute("cateInfoArr", cateInfoArr);
		myRequest.setAttribute("proInfoArr", proInfoArr);
		// 跳转到商品销售页
		RequestDispatcher dispatcher = myRequest.getRequestDispatcher("WEB-INF/View/Home/GoodsImport.jsp");
		dispatcher.forward(myRequest, myResponse);

	}

	// 退出系统
	public void Exit() {
		mySession.setAttribute("username", null);

	}

	// 确认入货Action
	public void GoodsImportAction() throws SQLException {
		System.out.println("进入GoodsImportAction()成功！");
		String goodsNum = myRequest.getParameter("goodsNum");
		System.out.println(goodsNum);
		String goodsName = myRequest.getParameter("goodsName");
		/* String providerName = myRequest.getParameter("providerName"); */
		String number = myRequest.getParameter("number");
		String price = myRequest.getParameter("price");

		String userNum = (String) mySession.getAttribute("username");
		String userName = (String) mySession.getAttribute("truename");

		String address = myRequest.getParameter("address");
		String phone = myRequest.getParameter("phone");

		// 先根据商品编号来确定该商品的供货商名字
		String providerName = new ImportInfo().GetProviderNameByGooodsNum(goodsNum);
		System.out.println("数据访问成功，返回" + providerName);

		String rst = new ImportInfo().GoodsImport(goodsNum, goodsName, providerName, number, price, userNum, userName);
		System.out.println("数据访问成功，返回" + rst);
		try {
			myResponse.getWriter().print(rst);
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
}
