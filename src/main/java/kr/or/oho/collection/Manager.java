package kr.or.oho.collection;

import java.util.ArrayList;
import java.util.List;

import kr.or.oho.collection.vo.PeopleVO;
import kr.or.oho.collection.vo.StudentVO;
import kr.or.oho.collection.vo.TeacherVO;

public class Manager {
	private List<PeopleVO> peopleVOList = new ArrayList<PeopleVO>();
	
	public void printPeopleVOListToFile() {
		System.out.println("############저장된 사람의 정보를 출력합니다.###############");
		System.out.println("건수 : " + peopleVOList.size());
		for(PeopleVO peopleVO:peopleVOList) {
//			System.out.println(peopleVO);
			//파일에 출력해 보세요
			
			
		}
	}
	
	public void printTeacherVOList() {
		System.out.println("저장된 교사의 정보를 출력합니다.");
		for (PeopleVO peopleVO : peopleVOList) {
			if (peopleVO instanceof TeacherVO) {
				System.out.println(peopleVO);
			}
		}
	}
	
	public PeopleVO findPeopleVOByName(PeopleVO peopleVO) {
		PeopleVO resultPeopleVO = null;
		
		for(PeopleVO listPeopleVO:peopleVOList) {
			if(peopleVO.getName().equals(listPeopleVO.getName())) {
				resultPeopleVO = listPeopleVO;
			}
		}
		
		return resultPeopleVO;
	}
	
	//아래 소스 수정없이 동작하도록 구현해보세요. hint) VO의 equals를 Override할 것
	public PeopleVO findPeopleVOByNameAPI(PeopleVO peopleVO) {
		PeopleVO resultPeopleVO = null;
		int index = peopleVOList.indexOf(peopleVO);
		
		if(index > -1) {
			resultPeopleVO = peopleVOList.get(index);
		}
		
		return resultPeopleVO;
	}
	
	
	public int deletePeopleVOByName(PeopleVO peopleVO) {
		int cnt = 0;

		PeopleVO resultPeopleVO = null;
		
		for(PeopleVO listPeopleVO:peopleVOList) {
			if(peopleVO.getName().equals(listPeopleVO.getName())) {
				resultPeopleVO = listPeopleVO;
			}
		}
		if(peopleVOList.remove(resultPeopleVO)) {
			cnt++;
		}
		
		return cnt;
	}
	
	public int deletePeopleVOByNameAPI(PeopleVO peopleVO) {
		int cnt = 0;
		
		if(peopleVOList.remove(peopleVO)) {
			cnt++;
		}
		
		return cnt;
	}
	
	
	
	public void addPeopleVO(PeopleVO peopleVO) {
		this.peopleVOList.add(peopleVO);
		System.out.println("성공적으로 저장되었습니다.");
	}
	
	public static void main(String[] args) {
		Manager manager = new Manager();
//		manager.printPeopleVOList();
		
		PeopleVO peopleVO1 = new StudentVO(
				"홍길동", "남자", 12, "3", "2", "20"
				);
		PeopleVO peopleVO2 = new StudentVO(
				"유관순", "여자", 12, "2", "1", "15"
				);
		PeopleVO peopleVO3 = new StudentVO(
				"강감찬", "남자", 5, "2", "3", "10"
				);
		PeopleVO peopleVO4 = new TeacherVO(
				"김수핟", "여자", 5, "정교사", "담임교사"
				);
		PeopleVO peopleVO5 = new TeacherVO(
				"장영어", "남자", 5, "기간제", "일반교사"
				);
//		peopleVO.setName("홍길동");
//		peopleVO.setSex("남자");
//		peopleVO.setAge(12);
//		((StudentVO)peopleVO).setHak("3");
//		((StudentVO)peopleVO).setBan("2");
//		((StudentVO)peopleVO).setNo("20");
		
		manager.addPeopleVO(peopleVO1);
		manager.addPeopleVO(peopleVO2);
		manager.addPeopleVO(peopleVO3);
		manager.addPeopleVO(peopleVO4);
		manager.addPeopleVO(peopleVO5);
		
//		manager.printPeopleVOList();
		
		manager.printTeacherVOList();
		
		PeopleVO peopleVO = new PeopleVO();
		peopleVO.setName("강감찬");
		PeopleVO findPeopleVO = manager.findPeopleVOByName(peopleVO);
		System.out.println("findPeopleVO: " + findPeopleVO);
		
		findPeopleVO = manager.findPeopleVOByNameAPI(peopleVO);
		System.out.println("findPeopleVO: " + findPeopleVO);

		int cnt = manager.deletePeopleVOByNameAPI(peopleVO);
		System.out.println("del cnt: " + cnt);
		
//		manager.printPeopleVOList();
		
	}
}
