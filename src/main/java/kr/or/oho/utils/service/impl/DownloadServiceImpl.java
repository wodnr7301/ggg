package kr.or.oho.utils.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.DownloadMapper;
import kr.or.oho.utils.service.DownloadService;
import kr.or.oho.vo.AttachVO;

@Service
public class DownloadServiceImpl implements DownloadService {
	
	@Autowired
	DownloadMapper downloadMapper;

	@Override
	public AttachVO getAttachVOList(AttachVO attachVO) {
		return this.downloadMapper.getAttachVOList(attachVO);
	}
}
