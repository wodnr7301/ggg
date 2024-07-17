package kr.or.oho.openmng.service;

import java.util.List;

import kr.or.oho.vo.EdnPrgrmVO;

public interface EdnPrgrmService {
	public List<EdnPrgrmVO> list();
	public int add(EdnPrgrmVO ednPrgrmVO);
	public int update(EdnPrgrmVO ednPrgrmVO);
	public int delete(EdnPrgrmVO ednPrgrmVO);
}
