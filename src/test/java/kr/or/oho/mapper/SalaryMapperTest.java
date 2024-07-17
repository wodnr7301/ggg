package kr.or.oho.mapper;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.or.oho.vo.SalaryVO;

public class SalaryMapperTest {
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[] {
				"/kr/or/oho/mapper/test-context.xml"
		});

		SalaryMapper salaryMapper = (SalaryMapper)context.getBean("salaryMapper");
		System.out.println("salaryMapper: "+salaryMapper);

		 List<SalaryVO> list = salaryMapper.allList();
		 System.out.println(list.size());
		 for(SalaryVO salaryVO:list) {
			 System.out.println(salaryVO);
		 }
	}
}
