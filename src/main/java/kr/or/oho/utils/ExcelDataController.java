package kr.or.oho.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.oho.devmng.service.PreFrcService;
import kr.or.oho.interviewee.service.IntervieweeService;
import kr.or.oho.vo.IntervieweeVO;
import kr.or.oho.vo.ReserveFounderVO;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class ExcelDataController {

	@Autowired
	PreFrcService preFrcService;
	
	@Autowired
	IntervieweeService intervieweeService;

	@ResponseBody
	@PostMapping("/excel/read")
	public ReserveFounderVO readExcel(@RequestBody MultipartFile file, Model model) throws IOException { // 2
		log.debug("exel/read에 왔다.");
		List<ReserveFounderVO> preFrcList = new ArrayList<ReserveFounderVO>();
		ReserveFounderVO resultList = new ReserveFounderVO();
		
		try (InputStream is = file.getInputStream();) {

			Workbook workbook = new XSSFWorkbook(file.getInputStream());

			Sheet worksheet = workbook.getSheetAt(0);
			
			int cnt = 0;
			int result = 0;

			for (int i = 0; i < worksheet.getPhysicalNumberOfRows(); i++) { // 1번째 행부터 끝까지
				Row row = worksheet.getRow(i);

				ReserveFounderVO data = new ReserveFounderVO();
				data.setRfEmlAddr(row.getCell(0).getStringCellValue()); //이메일
				log.debug("setRfEmlAddr");
				data.setRfNm(row.getCell(1).getStringCellValue()); //이름
				log.debug("setRfNm");
				data.setRfZip((int) row.getCell(2).getNumericCellValue()); //우편번호
				log.debug("setRfZip");
				data.setRfAddr(row.getCell(3).getStringCellValue()); //주소
				log.debug("setRfAddr");
				data.setRfDaddr(row.getCell(4).getStringCellValue()); //상세주소
				log.debug("setRfDaddr");
				data.setRfTelno(row.getCell(5).getStringCellValue()); //전화번호
				log.debug("setRfTelno");
				
				data.setRfYmd(DateUtil.getJavaDate(row.getCell(6).getNumericCellValue())); //신청일
				log.debug("setRfYmd");
				data.setRfHlo(row.getCell(7).getStringCellValue()); //신청지역
				log.debug("setRfHlo");
				data.setFtNo(String.valueOf((int)row.getCell(8).getNumericCellValue())); //신청 가맹유형
				log.debug("setFtNo");

				cnt += this.intervieweeService.insertReserveFounder(data);
				result++;
			}
			
			log.debug("cnt : " + cnt);
			preFrcList = this.preFrcService.list();
			
			resultList.setReserveFounderList(preFrcList);
			resultList.setResult(result);
			log.debug("preFrcList : " + preFrcList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultList;
	}

}
