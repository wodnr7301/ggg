package kr.or.oho.devmng.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.devmng.service.FrcCnsltService;
import kr.or.oho.mapper.FrcCnsltMapper;
import kr.or.oho.vo.ItvBscInfoVO;
import kr.or.oho.vo.ReserveFounderVO;

@Service
public class FrcCnsltServiceImpl implements FrcCnsltService {

	@Autowired
	FrcCnsltMapper frcCnsltMapper;
	
	@Override
	public List<ReserveFounderVO> list(String empNo) {
		return this.frcCnsltMapper.list(empNo);
	}

	@Override
	public ReserveFounderVO detail(ItvBscInfoVO itvBscInfoVO) {
		return this.frcCnsltMapper.detail(itvBscInfoVO);
	}

	@Override
	public int update(ItvBscInfoVO itvBscInfoVO) {
		return this.frcCnsltMapper.update(itvBscInfoVO);
	}

	@Override
	public boolean cancel(ItvBscInfoVO itvBscInfoVO) {
		int result = this.frcCnsltMapper.interviewerDelete(itvBscInfoVO);
		result += this.frcCnsltMapper.cancel(itvBscInfoVO);
		
		if(result == 2) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<ReserveFounderVO> cnsltYList() {
		return this.frcCnsltMapper.cnsltYList();
	}

	@Override
	public ReserveFounderVO cnsltYOne(ReserveFounderVO reserveFounderVO) {
		return this.frcCnsltMapper.cnsltYOne(reserveFounderVO);
	}

	@Override
	public int listCnt(Map<String, String> map) {
		return this.frcCnsltMapper.listCnt(map);
	}

}
