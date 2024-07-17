package kr.or.oho.utils.service;

import kr.or.oho.vo.AttachVO;

public interface DownloadService {

	/**
	 * 파일 다운로드를 위한 정보를 가져오는 메소드
	 * @param attachVO
	 * @return
	 */
	public AttachVO getAttachVOList(AttachVO attachVO);

}
