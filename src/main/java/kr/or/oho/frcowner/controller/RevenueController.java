package kr.or.oho.frcowner.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.oho.frcorder.service.FrcorderService;
import kr.or.oho.frcowner.service.RevenueService;
import kr.or.oho.mapper.EmployeeMapper;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.RevenueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/frcowner")
public class RevenueController {

    @Autowired
    RevenueService revenueService;
    

    
    /**
	 * 매출관리 메인 페이지
	 * @author PC-01
	 *
	 */
    @GetMapping("/revenue")
    public String revenueMain(@RequestParam(required = false) String fsWrtYear, Model model, Principal principal) {
        log.info("매출관리 메인 페이지에 진입");
    	
        if (fsWrtYear == null) {
            fsWrtYear = "2024";  //기본 연도로 2024년 설정
        }
        log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
        
        String empNo = null;
        
        if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser cu = (CustomUser) a.getPrincipal();
	        if (cu != null) {
	            EmployeeVO emp = cu.getEmployeeVO();
	            if (emp != null) {
	            	empNo = emp.getEmpNo();
	                model.addAttribute("empNo", emp.getEmpNo());
	            }
	        }
	    }
        
        List<RevenueVO> revenueData = revenueService.data(fsWrtYear, empNo);
        log.info("매출 데이터 -> revenueData : " + revenueData);
        
        model.addAttribute("revenueData", revenueData);
        model.addAttribute("fsWrtYear", fsWrtYear);
        
    	return "franchise/revenue";
    }

    
    /**
	 * 매출 현황 관리(리스트) 
	 * @author PC-01
	 *
	 */
    @GetMapping("/monthRevenue")
    public String getMonthRevenue(@RequestParam(required = false) String fsWrtYear, Model model, Principal principal) {
        log.info("월별 매출 현황 List에 진입");
        
        if (fsWrtYear == null) {
            fsWrtYear = "2024";  //기본 연도로 2024년 설정
        }
        log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
        
        String empNo = null;
        
        if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser cu = (CustomUser) a.getPrincipal();
	        if (cu != null) {
	            EmployeeVO emp = cu.getEmployeeVO();
	            if (emp != null) {
	            	empNo = emp.getEmpNo();
	                model.addAttribute("empNo", emp.getEmpNo());
	            }
	        }
	    }
        
        List<RevenueVO> revenueList = revenueService.list(fsWrtYear, empNo);
        log.info("월별 매출 list -> revenueList: " + revenueList);

        model.addAttribute("revenueList", revenueList);
        model.addAttribute("fsWrtYear", fsWrtYear);
        
        return "franchise/monthRevenue";
    }

    /**
	 * 매출 현황 관리(등록)
	 * @author PC-01
	 *
	 */
    @ResponseBody
    @PostMapping("/revenueCreate")
    public Map<String, Object> rvnCreate(@RequestBody RevenueVO revenueVO, Principal principal) {
        int result = revenueService.createRvn(revenueVO);
        log.info("createRvn -> result :" + result);

        Map<String, Object> response = new HashMap<>();
        if (result > 0) {
            response.put("status", "SUCCESS");
        } else {
            response.put("status", "FAIL");
        }

        return response;
    }
    
    /**
	 * 매출 현황 관리(수정)
	 * @author PC-01
	 *
	 */
    @ResponseBody
    @PostMapping("/revenueUpdate")
    public Map<String,Object> rvnUpdate(@RequestBody RevenueVO revenueVO, Principal principal) {
    	int result = revenueService.updateRvn(revenueVO);
    	log.info("updateRvn -> result : " + result);
    	
    	Map<String, Object> response = new HashMap<>();
    	if (result > 0) {
    		response.put("status", "SUCCESS");
    	} else {
    		response.put("status", "FAIL");
    	}
    	
    	return response;
    }

    /**
	 * 매출 현황 관리(삭제)
	 * @author PC-01
	 *
	 */
    @PostMapping("/revenueDelete")
    public ResponseEntity<String> deleteRevenue(@RequestBody RevenueVO revenueVO, Principal principal) {
        int result = this.revenueService.deleteRvn(revenueVO);
        log.info("updateAjax -> result : " + result);
        
        return ResponseEntity.ok("Deleted Success");
    }
    
    
    /**
 	 * 월별 매출 현황 리스트 
 	 * @author PC-01
 	 *
 	 */
     @GetMapping("/revenueMonth")
     public String getRevenueMonth(@RequestParam(required = false) String fsWrtYear, Model model, Principal principal) {
         log.info("월별 매출 현황 List에 진입");
         
         String empNo = null;
         
         if (principal != null) {
 	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
 	        CustomUser cu = (CustomUser) a.getPrincipal();
 	        if (cu != null) {
 	            EmployeeVO emp = cu.getEmployeeVO();
 	            if (emp != null) {
 	            	empNo = emp.getEmpNo();
 	                model.addAttribute("empNo", emp.getEmpNo());
 	            }
 	        }
 	    }
         
         if (fsWrtYear == null) {
             fsWrtYear = "2024";  //기본 연도로 2024년 설정
         }
         log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
         
         List<RevenueVO> revenueList = revenueService.monthList(fsWrtYear, empNo);
         log.info("월별 매출 list -> revenueList: " + revenueList);
         
         List<RevenueVO> revenueData = revenueService.data(fsWrtYear, empNo);
         log.info("매출 데이터 -> revenueData : " + revenueData);

         model.addAttribute("revenueList", revenueList);
         model.addAttribute("revenueData", revenueData);
         model.addAttribute("fsWrtYear", fsWrtYear);
         
         return "franchise/revenueMonth";
     }
     
     /**
  	 * 월별 매출 그래프 AJAX 
  	 * @author PC-01
  	 *
  	 */
     @ResponseBody
     @GetMapping(value="/revenueMonthChartAjax",produces = "application/json;charset=UTF-8")
     public Map<String,Object> getRevenueMonthChartAjax(@RequestParam(required = false) String fsWrtYear, Principal principal) {
         log.info("월별 매출 현황 List에 진입");
         
         String empNo = null;
         
         if (principal != null) {
 	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
 	        CustomUser cu = (CustomUser) a.getPrincipal();
 	        if (cu != null) {
 	            EmployeeVO emp = cu.getEmployeeVO();
 	            if (emp != null) {
 	            	empNo = emp.getEmpNo();
 	            }
 	        }
 	    }
         
         if (fsWrtYear == null) {
             fsWrtYear = "2024";  //기본 연도로 2024년 설정
         }
         log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
         
         List<RevenueVO> revenueData = revenueService.data(fsWrtYear, empNo);
         log.info("매출 데이터 -> revenueData : " + revenueData);

         Map<String,Object> pgData = new HashMap<String, Object>();
         
         pgData.put("fsWrtYear", fsWrtYear);
         pgData.put("revenueData", revenueData);
         
         return pgData;
     }
     
     
     /**
 	  * 연도별 매출 현황 리스트
 	  * @author PC-01
 	  *
 	  */
     @GetMapping("/revenueYear")
     public String getRevenueYear(RevenueVO revenueVO, Model model, Principal principal) {
         log.info("연도별 매출 현황 List에 진입");
         
         String empNo = null;
         
         if (principal != null) {
 	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
 	        CustomUser cu = (CustomUser) a.getPrincipal();
 	        if (cu != null) {
 	            EmployeeVO emp = cu.getEmployeeVO();
 	            if (emp != null) {
 	            	empNo = emp.getEmpNo();
 	                model.addAttribute("empNo", emp.getEmpNo());
 	            }
 	        }
 	    }
         
         List<RevenueVO> revenueList = revenueService.yearList(revenueVO, empNo);
         log.info("연도별 매출 list -> revenueList: " + revenueList);
         
         model.addAttribute("revenueList", revenueList);
         
         return "franchise/revenueYear";
     }
     
     
     /**
  	  * 분기별 매출 현황 리스트
  	  * @author PC-01
  	  *
  	  */
      @GetMapping("/revenueQuater")
      public String getRevenueQuater(@RequestParam(required = false) String fsWrtYear, Model model, Principal principal) {
          log.info("분기별 매출 현황 List에 진입");
          
          if (fsWrtYear == null) {
              fsWrtYear = "2024";  //기본 연도로 2024년 설정
          }
          log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
          
          String empNo = null;
          
          if (principal != null) {
  	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
  	        CustomUser cu = (CustomUser) a.getPrincipal();
  	        if (cu != null) {
  	            EmployeeVO emp = cu.getEmployeeVO();
  	            if (emp != null) {
  	            	empNo = emp.getEmpNo();
  	                model.addAttribute("empNo", emp.getEmpNo());
  	            }
  	        }
  	      }
          
          List<RevenueVO> revenueList = revenueService.quaterList(fsWrtYear, empNo);
          log.info("분기별 매출 list -> revenueList: " + revenueList);

          model.addAttribute("revenueList", revenueList);
          model.addAttribute("fsWrtYear", fsWrtYear);
          
          return "franchise/revenueQuater";
      }
     
      /**
       * 분기별 매출 그래프 AJAX
       * @author PC-01
       *
       */
      @ResponseBody
      @GetMapping(value="/revenueQuaterChartAjax",produces = "application/json;charset=UTF-8")
      public Map<String,Object> getRevenueQuaterChartAjax(@RequestParam(required = false) String fsWrtYear, Principal principal) {
          log.info("월별 매출 현황 List에 진입");
          
          if (fsWrtYear == null) {
              fsWrtYear = "2024";  //기본 연도로 2024년 설정
          }
          log.info("현재 fswrtYear(년도) 설정값 : " + fsWrtYear);
          
          String empNo = null;
          
          if (principal != null) {
  	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
  	        CustomUser cu = (CustomUser) a.getPrincipal();
  	        if (cu != null) {
  	            EmployeeVO emp = cu.getEmployeeVO();
  	            if (emp != null) {
  	            	empNo = emp.getEmpNo();
  	            }
  	        }
  	      }
          
          List<RevenueVO> revenueList = revenueService.quaterList(fsWrtYear, empNo);
          log.info("분기별 매출 list -> revenueList: " + revenueList);

          Map<String,Object> pgData = new HashMap<String, Object>();
          
          pgData.put("fsWrtYear", fsWrtYear);
          pgData.put("revenueList", revenueList);
          
          return pgData;
      }
      
      
     /**
  	 * EmployeeVO 정보 가져오기
  	 * @author PC-01
  	 * @return 
  	 *
  	 */
  	@ResponseBody
  	@GetMapping("/revenueGetEmp")
  	public ResponseEntity<EmployeeVO> GetEmp(Principal principal) {
  	    if (principal == null) {
  	        log.error("Principal is null");
  	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
  	    }

  	    UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
  	    
  	    CustomUser cu;
  	    
  	    try {
  	        cu = (CustomUser) a.getPrincipal();
  	    } catch (ClassCastException e) {
  	        log.error("Failed to cast principal to CustomUser", e);
  	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
  	    }

  	    if (cu == null) {
  	        log.error("CustomUser is null");
  	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
  	    }

  	    EmployeeVO emp = cu.getEmployeeVO();
  	    log.info("EmployeeVO emp 잘 나오는지 확인 --> " + emp);
  	    
  	    if (emp == null) {
  	        log.error("EmployeeVO is null");
  	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
  	    }

  	    log.info("empVO : " + emp);
  	    return new ResponseEntity<>(emp, HttpStatus.OK);
  	}
}
