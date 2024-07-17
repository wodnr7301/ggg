package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.BizMemberVO;
import kr.or.oho.vo.BizVO;

public interface BizMapper {

	public List<BizVO> getBizVOList();

	public int createBiz(BizVO bizVO);

	public int createBizMember(BizMemberVO bizMemberVO);

	public BizVO detail(BizVO bizVO);

	public int deleteMember(BizVO bizVO);

	public int updateMember(BizMemberVO bizMemberVO);

	public int updateBiz(BizVO bizVO);

	public int updateStatus(BizVO bizVO);

	public int updateStatusN(BizVO bizVO);

}
