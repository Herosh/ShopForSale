package Core;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

/**
 * 操作Excel的工具类
 * 
 */

public class ExcelUtil {

	/**
	 * 导出Excel文档
	 * 
	 * @param list 数据列表的集合
	 * @param path 存储Excel路径
	 * @return void 无
	 * @throws WriteException
	 * @throws RowsExceededException
	 */
	public void exportExcelData(List<HashMap<String, Object>> list, String path)
			throws RowsExceededException, WriteException {

		String[] title = { "学号", "姓名", "密码" };

		try {

			File file = new File(path);
			// 创建一个Excel工作薄对象
			jxl.write.WritableWorkbook wb = jxl.Workbook.createWorkbook(file);
			// 创建一个工作表格对象
			WritableSheet sheet = wb.createSheet("学生表", 0);

			Label label = null;
			// 创建表头
			for (int i = 0; i < title.length; i++) {
				label = new Label(i, 0, title[i]);
				sheet.addCell(label);
			}
			
			Label labelNext = null;
			HashMap<String, Object> map = null;
			
			// 追加数据
			for (int i = 0; i < list.size(); i++) {
				
				map = list.get(i);
				
				//往第i+1行的第一列的格子里 追加数据
				labelNext = new Label(0,i+1,String.valueOf(map.get("stuNum")));
				sheet.addCell(labelNext);
				
				labelNext = new Label(1,i+1,String.valueOf(map.get("stuName")));
				sheet.addCell(labelNext);
				
				labelNext = new Label(2,i+1,String.valueOf(map.get("stuPwd")));
				sheet.addCell(labelNext);
			}
			
			//写入数据
			wb.write();
			//关闭工作薄
			wb.close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
