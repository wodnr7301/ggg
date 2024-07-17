package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.EdnPrgrmVO;

public interface EdnPrgrmMapper {
	public List<EdnPrgrmVO> list();
	public int add(EdnPrgrmVO ednPrgrmVO);
	public int update(EdnPrgrmVO ednPrgrmVO);
	public int delete(EdnPrgrmVO ednPrgrmVO);
	public List<EdnPrgrmVO> getEpNmList();
	public List<EdnPrgrmVO> getEpNmDetailList(EdnPrgrmVO ednPrgrmVO);
}
