package kr.or.oho.frcowner.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.frcowner.service.FreeBbsService;
import kr.or.oho.mapper.FreeBbsMapper;
import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.FreeBbsVO;

@Service
public class FreeBbsServiceImpl implements FreeBbsService {

	
	@Autowired
	FreeBbsMapper frcownerMapper;
	
	
	@Override
    public List<FreeBbsVO> list() {
        List<FreeBbsVO> freeBbsList = this.frcownerMapper.list();

       // displayNo 설정
       for (int i = 0; i < freeBbsList.size(); i++) {
           freeBbsList.get(i).setDisplayNo(i + 1); 
       }

        return freeBbsList;
	}

	@Override
	public int create(FreeBbsVO freeBbsVO) {
		return this.frcownerMapper.create(freeBbsVO);
	}

	@Override
	public FreeBbsVO detail(String fbNo) {
		return frcownerMapper.detail(fbNo);
	}


	@Override
	public void count(String fbNo) {
		this.frcownerMapper.count(fbNo);
	}


	@Override
	public List<ComentVO> comentList(String fbNo) {
		return frcownerMapper.comentList(fbNo);
	}


	@Override
	public int update(FreeBbsVO freeBbsVO) {
		return this.frcownerMapper.update(freeBbsVO);
	}

	@Override
	public void delete(String fbNo) {
		frcownerMapper.delete(fbNo);
	}

	@Override
	public int createCmt(ComentVO comentVO) {
		return this.frcownerMapper.createCmt(comentVO);
	}

	@Override
	public int deleteCmt(ComentVO comentVO) {
		return this.frcownerMapper.deleteCmt(comentVO);
	}

	@Override
	public int updateCmt(ComentVO comentVO) {
		return this.frcownerMapper.updateCmt(comentVO);
	}

	@Override
	public List<FreeBbsVO> empBoardList() {
		List<FreeBbsVO> freeBbsList = this.frcownerMapper.empBoardList();

	       // displayNo 설정
	       for (int i = 0; i < freeBbsList.size(); i++) {
	           freeBbsList.get(i).setDisplayNo(i + 1); 
	       }

	        return freeBbsList;
	}
	

}
