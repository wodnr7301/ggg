package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.IntervieweeVO;
import kr.or.oho.vo.ReserveFounderVO;

public interface IntervieweeMapper {

	public List<IntervieweeVO> getList();

	public int insertReserveFounder(ReserveFounderVO data);

}
