package kr.or.oho.mapper;

import kr.or.oho.vo.AttachVO;

public interface AttachMapper {
	
	//ATTACH 테이블에 insert
	public int insertAttach(AttachVO attachVO);
		
	//글로벌 코드를 조건으로 하여 첫번째 첨부파일 객체를 가져옴(String empNo)
	public AttachVO getFileName(String globalCode);
	
}
