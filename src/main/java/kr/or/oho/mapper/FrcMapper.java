package kr.or.oho.mapper;

import java.util.List;

import kr.or.oho.vo.ComcdVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FranchiseVO;

public interface FrcMapper {
	public String frcsNoSelect();
	public int add(FranchiseVO franchiseVO);
	//지역통계에 쓸 가맹점리스트
	public List<FranchiseVO> frcsRegionList();
	//지역구분 별 가맹점 개수
	public List<ComcdVO> countRegion();
	//지역구분 별 가맹점 개수(올해만)
	public List<ComcdVO> countRegionYear();
	
	/**
	 * 가맹점목록
	 * @return
	 */
	public List<FranchiseVO> frcsList();
	
	/**
	 * 가맹점 목록 상세 - 가맹점주 정보
	 * @param frcsVO
	 * @return
	 */
	public EmployeeVO frcsDetail(EmployeeVO frcsVO);
	
	/**
	 * 가맹점 정보수정용 정보 가져오기
	 * @param frcsNo
	 * @return
	 */
	public FranchiseVO getFranchiseInfo(String frcsNo);
	
	/**
	 * 가맹점주 정보수정용 정보 가져오기
	 * @param frcsNo
	 * @return
	 */
	public EmployeeVO getFrcsEmpInfo(String frcsNo);
	
	/**
	 * 가맹점 정보 수정
	 * @param frcsVO
	 * @return
	 */
	public int updateFranchiseInfo(FranchiseVO frcsVO);
	
	/**
	 * 가맹점주 정보 수정
	 * @param employeeVO
	 * @return
	 */
	public int updateFrcsEmpInfo(EmployeeVO employeeVO);
	
	/**
	 * 가맹점 삭제
	 * @param frcsNo
	 * @return
	 */
	public int deleteFranchise(FranchiseVO frcsNo);
	
	/**
	 * 가맹점주 삭제
	 * @param frcsNo
	 * @return
	 */
	public int deleteFrcsEmp(FranchiseVO frcsNo);
	
	/**
	 * 사원삭제
	 * @param empNo
	 * @return
	 */
	public int deleteEmp(EmployeeVO empNo);
	
}
