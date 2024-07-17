package kr.or.oho.eatrzt.service.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.velocity.runtime.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.oho.eatrzt.service.EatrztService;
import kr.or.oho.mapper.AttachMapper;
import kr.or.oho.mapper.EatrztMapper;
import kr.or.oho.vo.AtrzlnVO;
import kr.or.oho.vo.AttachVO;
import kr.or.oho.vo.EatrztVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.HldyMngLdgrVO;
import kr.or.oho.vo.TmpltVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EatrztServiceImpl implements EatrztService {

	@Autowired
	EatrztMapper eatrztMapper;
	
	@Autowired
	AttachMapper attachMapper;
	
	@Override
	public List<EatrztVO> docBoxList(String empNo) {
		return this.eatrztMapper.docBoxList(empNo);
	}

	@Override
	public List<EatrztVO> beforeApvBoxList(String empNo) {
		return this.eatrztMapper.beforeApvBoxList(empNo);
	}

	@Override
	public List<EatrztVO> apvBoxList(String empNo) {
		return this.eatrztMapper.apvBoxList(empNo);
	}

	@Override
	public TmpltVO createPost(TmpltVO tmpltVO) {
		return this.eatrztMapper.createPost(tmpltVO);
	}

	@Override
	public List<EmployeeVO> getName() {
		return this.eatrztMapper.getName();
	}

	@Override
	public List<TmpltVO> tmpltList() {
		return this.eatrztMapper.tmpltList();
	}

	@Override
	public EatrztVO comList(String empNo) {
		return this.eatrztMapper.comList(empNo);
	}

	//기안자 상신
	@Transactional
	@Override
	public int eatrztPost(EatrztVO eatrztVO) {
		//1) 부모
		int result = this.eatrztMapper.eatrztPost(eatrztVO);
		
		//ATRZLN테이블에 기안자로써 insert
		AtrzlnVO atrzlnVO = new AtrzlnVO();
		//A001	E002	D001		0
		atrzlnVO.setAtrzlnNo("");
		atrzlnVO.setEmpNo(eatrztVO.getEmpNo());
		atrzlnVO.setEatrztNo(eatrztVO.getEatrztNo());
		atrzlnVO.setAtrzlnPro(0);
		/*
		 /*
		 EatrztVO(eatrztNo=null, empNo=-1, empId=null, tmpltNo=1, eatrztTtl=오호, eatrztCn=내용
				, eatrztRepdt=null, eatrztAtrzdt=null, eatrztPrcsYn=null, deptNo=null, deptNm=null
				, comcdCdnm=null, empNm=null, tmpltTtl=null, tmpltVO=null, employeeVO=null, deptVO=null
				, atrzlnVOList=null)
		 */
		//2) 기안자
		result += this.eatrztMapper.atrzlnPost(atrzlnVO);
		
		//3) 결재자들
		/*
		, atrzlnVOList=
		[
			AtrzlnVO(atrzlnNo=null, empNo=EMP038, eatrztNo=null, atrzlnDt=null, atrzlnPro=1), 
			AtrzlnVO(atrzlnNo=null, empNo=A102, eatrztNo=null, atrzlnDt=null, atrzlnPro=2), 
			AtrzlnVO(atrzlnNo=null, empNo=EMP019, eatrztNo=null, atrzlnDt=null, atrzlnPro=3)
		]
		 */
		List<AtrzlnVO> atrzlnVOList = eatrztVO.getAtrzlnVOList();
		
		int cnt = 1;
		for(AtrzlnVO vo : atrzlnVOList) {
			vo.setEatrztNo(eatrztVO.getEatrztNo());
			vo.setAtrzlnPro(cnt++);
			
			result += this.eatrztMapper.atrzlnPost2(vo);
		}
		
		log.info("result(끝) : " + result);
		return result;
	}
	
	@Override
	public List<Map<String, Object>> atrzlnList() {
		return this.eatrztMapper.atrzlnList();
	}
	
	@Override
	public EatrztVO getEatrzt(EatrztVO eatrztVO) {
		return this.eatrztMapper.getEatrzt(eatrztVO);
	}
	
	@Override
	public List<AttachVO> attachList (EatrztVO eatrztVO) {
		
		List<AttachVO> attachList = this.eatrztMapper.attachList(eatrztVO);
		for (AttachVO attachVO : attachList) {
			long afSz = attachVO.getAfSz();
			long changeSz = Math.round(afSz/1024);
			
			attachVO.setAfSz(changeSz);
		}
		
		return attachList;
	}
	
	@Override
	public int atrUpdatePost(AtrzlnVO atrzlnVO) {
		int result = eatrztMapper.atrUpdatePost(atrzlnVO);
		log.info("atrUpdatePost -> atrzlnVO: " + atrzlnVO);
		
		int atrzlnPro = eatrztMapper.checkFinalApproval(atrzlnVO.getAtrzlnNo());

		// finalApprovalValue 결재자 인원수에 따라 값 바껴야함
        int finalApprovalValue = eatrztMapper.finalApprovalValue(atrzlnVO.getEatrztNo());

        if (atrzlnPro == finalApprovalValue) {
            // Update eatrzt
            eatrztMapper.updateEatrztAfterApproval(atrzlnVO.getEatrztNo());
            // 넘어온게 연차 서식을 가지고 있는 결재선인지 check   
            int checkHldyTmplt = eatrztMapper.checkHldyTmplt(atrzlnVO);
            log.info("checkHldyTmplt 결과 :" + checkHldyTmplt);
            HldyMngLdgrVO hldyMngLdgrVO = new HldyMngLdgrVO();
            hldyMngLdgrVO.setEmpNo(atrzlnVO.getEmpNo());//
            hldyMngLdgrVO.setHsNo(atrzlnVO.getHsNo());
            hldyMngLdgrVO.setHmlUseDt(atrzlnVO.getHmlUseDt());
            hldyMngLdgrVO.setHmlEndDt(atrzlnVO.getHmlEndDt());
            hldyMngLdgrVO.setEatrztNo(atrzlnVO.getEatrztNo());
            hldyMngLdgrVO.setHmlRsn(atrzlnVO.getHmlRsn());;
            // if
            	if(checkHldyTmplt == 1) {
            		// 연차 관리 대장 insert
            		result += eatrztMapper.hldyInsert(hldyMngLdgrVO);	
            	}
        }

        return result;
	}

	@Override
	public AtrzlnVO check(AtrzlnVO chkAtrzlnVO) {
		return this.eatrztMapper.check(chkAtrzlnVO);
	}

	@Override
	public int eatrztUpdate(EatrztVO eatrztVO) {
		int result = eatrztMapper.eatrztUpdate(eatrztVO);
		
		 result += eatrztMapper.atrzlnUpdate(eatrztVO.getEatrztNo());
		
		return result;
	}

	@Override
	public int delUpdate(EatrztVO eatrztVO) {
		return this.eatrztMapper.delUpdate(eatrztVO);
	}

	@Override
	public List<EatrztVO> nDocBoxList(String empNo) {
		return this.eatrztMapper.nDocBoxList(empNo);
	}

	@Override
	public List<AtrzlnVO> stampAtrList(EatrztVO eatrztVO) {
		return this.eatrztMapper.stampAtrList(eatrztVO);
	}

	@Override
	public List<AtrzlnVO> stampAtrList2(EatrztVO eatrztVO) {
		return this.eatrztMapper.stampAtrList2(eatrztVO);
	}

	@Override
	public List<EatrztVO> nApvBoxList(String empNo) {
		return this.eatrztMapper.nApvBoxList(empNo);
	}
	
}
