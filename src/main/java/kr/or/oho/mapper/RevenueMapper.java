package kr.or.oho.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.oho.vo.RevenueVO;

public interface RevenueMapper {

	List<RevenueVO> revenueList(@Param("fsWrtYear") String fsWrtYear, @Param("empNo") String empNo);

	int createRvn(RevenueVO revenueVO);

	int updateRvn(RevenueVO revenueVO);

	int deleteRvn(RevenueVO revenueVO);

	List<RevenueVO> revenueData(@Param("fsWrtYear") String fsWrtYear, @Param("empNo") String empNo);

	List<RevenueVO> monthList(@Param("fsWrtYear") String fsWrtYear, @Param("empNo") String empNo);

	List<RevenueVO> yearList(@Param("revenueVO")RevenueVO revenueVO, @Param("empNo") String empNo);

	List<RevenueVO> quaterList(@Param("fsWrtYear") String fsWrtYear, @Param("empNo") String empNo);

	List<RevenueVO> revenueList2(RevenueVO revenue);

}
