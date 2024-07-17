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
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.oho.frcowner.service.NtcBbsService;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.NtcBbsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/frcowner")
public class NtcBbsController {

	@Autowired
	NtcBbsService ntcBbsService;
	
	@GetMapping("/ntcBoardList")
	public String ntcBoardList(Model model, Principal principal) {
		log.info("공지사항 게시판 list에 진입");
		
		List<NtcBbsVO> ntcBbsList = this.ntcBbsService.list();
		log.info("점주 공지사항 list -> ntcBbsList : " + ntcBbsList);
		
		model.addAttribute("ntcBbsList" , ntcBbsList);
		
		if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser cu = (CustomUser) a.getPrincipal();
	        if (cu != null) {
	            EmployeeVO emp = cu.getEmployeeVO();
	            if (emp != null) {
	                model.addAttribute("empClsf", emp.getEmpClsf());
	            }
	        }
	    }
		return "board/ntcBoardList";
	}
	

	@GetMapping("/ntcBoardDetail")
	public String ntcBoardDetail(@RequestParam("nbNo") String nbNo, Model model, Principal principal) {
	    log.info("점주 게시판 Detail에 진입!");

	    ntcBbsService.count(nbNo);

	    NtcBbsVO ntcBbs = this.ntcBbsService.detail(nbNo);
	    log.info("점주 게시글 Detail -> ntcBbs : " + ntcBbs);
	    
	    List<ComentVO> comentList = this.ntcBbsService.comentList(nbNo);
	    
	    ntcBbs.setComentList(comentList);
	    log.info("점주 게시판 Coment -> comentList : " + comentList);

	    // 로그인된 사용자의 EmployeeVO 정보를 가져옵니다.
	    if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        if (a != null) {
	            CustomUser cu = (CustomUser) a.getPrincipal();
	            if (cu != null) {
	                EmployeeVO emp = cu.getEmployeeVO();
	                model.addAttribute("user", emp);
	            }
	        }
	    }

	    model.addAttribute("ntcBbs", ntcBbs);
	    log.info("ntcBbs: " + ntcBbs);

	    return "board/ntcBoardDetail";
	}


	

	@GetMapping("/ntcBoardCreate")
    public String showCreateNtcBoardForm(Model model) {
		log.info("점주 공지사항 게시판 Create에 진입! (GET)");

        model.addAttribute("ntcBbsVO", new NtcBbsVO());
        
        return "board/ntcBoardCreate"; 
    }
	
	@PostMapping("/ntcBoardCreate")
	public String ntcBoardCreate(@Validated @ModelAttribute(value="NtcBbsVO") NtcBbsVO ntcBbsVO,
	                          BindingResult brResult, Principal principal, ModelAndView mav) {
	    log.info("점주 공지사항 게시판 Create에 진입! (POST)");
	    log.info("ntcBoardCreate->brResult.hasErrors() : " + brResult);

	    if (brResult.hasErrors()) {
	        List<ObjectError> allErrors = brResult.getAllErrors();
	        List<ObjectError> globalErrors = brResult.getGlobalErrors();
	        List<FieldError> fieldErrors = brResult.getFieldErrors();

	        for (ObjectError objectError : allErrors) {
	            log.info("allError : " + objectError);
	        }

	        for (ObjectError objectError : globalErrors) {
	            log.info("globalError : " + objectError);
	        }

	        for (FieldError fieldError : fieldErrors) {
	            log.info("fieldError : " + fieldError);
	        }

	        return "frcowner/ntcBoardCreate";
	    }

	    log.info("if문 종료");

	    // Principal에서 emp_no 설정
	    if (principal != null) {
	        UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser customUser = (CustomUser) auth.getPrincipal();
	        EmployeeVO emp = customUser.getEmployeeVO();
	        
	        if (emp != null) {
	        	ntcBbsVO.setEmpNo(emp.getEmpNo());  // emp_no 설정
	        } else {
	            log.error("EmployeeVO is null");
	            return "redirect:/login";
	        }
	    } else {
	        log.error("Principal is null");
	        return "redirect:/login";
	    }

	    int result = this.ntcBbsService.create(ntcBbsVO);

	    log.info("가맹점 공지사항 boardCreate -> result : " + result);
	    log.info("가맹점 공지사항 boardCreate-> ntcBbsVO: " + ntcBbsVO);

	    return "redirect:/frcowner/ntcBoardList";
	    
	}
	
	@GetMapping("/ntcBoardUpdate")
    public String boardUpdate(@RequestParam("nbNo") String nbNo, Model model) {
		log.info("점주 공지사항 게시판 Update에 진입! (GET)");
	    
		NtcBbsVO ntcBbs = this.ntcBbsService.detail(nbNo);
		log.info("ntcBbs : " + ntcBbs);
		
        model.addAttribute("ntcBbs", ntcBbs);
        
        return "board/ntcBoardUpdate";  
    }
	
	@PostMapping("/ntcBoardUpdate")
	public String boardUpdate(NtcBbsVO ntcBbsVO, Model model, Principal principal) {
		log.info("점주 게시판 Update에 진입! (Post)");
		
		int result = this.ntcBbsService.update(ntcBbsVO);
		log.info("updatePost->result: " + result);
		
		if (principal != null) {
	        UsernamePasswordAuthenticationToken a = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser cu = (CustomUser) a.getPrincipal();
	        if (cu != null) {
	            EmployeeVO emp = cu.getEmployeeVO();
	            if (emp != null) {
	                model.addAttribute("empClsf", emp.getEmpClsf());
	            }
	        }
	    }
		
		model.addAttribute("ntcBbsVO", ntcBbsVO);
		
		return "redirect:/frcowner/ntcBoardList";  
	}
	
	@GetMapping("/ntcBoardDelete")
	public String ntcBoardDeletePost(@RequestParam("nbNo") String nbNo) {
		log.info("점주 공지사항 게시판 Delete에 진입!)");
		
		ntcBbsService.delete(nbNo);
		
		return "redirect:/frcowner/ntcBoardList"; 
	}
	
	/*----------------------------------------------------------------------------------<아래부터 댓글 컨트롤러>----------------------------------------------------------------------------------*/
	
	/**
	 * 점주 댓글 생성
	 * @author PC-01
	 *
	 */
	@ResponseBody
	@PostMapping("/ntcCmtCreate")
	public ResponseEntity<Map<String, Object>> cmntCreate(@RequestBody ComentVO comentVO) {
		log.info("댓글 create에 진입!");
		log.info("cmntCreatePost -> comentVO: " + comentVO);

	    int result = ntcBbsService.createCmt(comentVO);
	    log.info("cmntCreateAjax - >result : " + result);

	    Map<String, Object> response = new HashMap<>();
	    
	    if (result > 0) {
	        response.put("status", "SUCCESS");
	        response.put("nbNo", comentVO.getCmntCd()); 
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    } else {
	        response.put("status", "FAIL");
	        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	
	/**
	 * 점주 댓글 수정
	 * @author PC-01
	 *
	 */
	@ResponseBody
	@PostMapping("/ntcCmtUpdate")
	public ResponseEntity<Map<String, String>> ntcCmtUpdate(@RequestBody ComentVO comentVO) {
		log.info("댓글 Update에 진입!");
		
		int result = this.ntcBbsService.updateCmt(comentVO);
		log.info("updateAjax -> result : " + result);
		
		Map<String, String> response = new HashMap<>();
		
		if (result > 0) {
			response.put("status", "SUCCESS");
		} else {
			response.put("status", "FAILURE");
		}
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	
	
	/**
	 * 점주 댓글 삭제
	 * @author PC-01
	 *
	 */
	@ResponseBody
	@PostMapping("/ntcCmtDelete")
	public ResponseEntity<Map<String, String>> ntcCmtDelete(@RequestBody ComentVO comentVO) {
	    log.info("댓글 Delete에 진입!");
	    
	    int result = this.ntcBbsService.deleteCmt(comentVO);
	    log.info("deleteAjax -> result: " + result);
	    
	    Map<String, String> response = new HashMap<>();
	    
	    if (result > 0) {
	        response.put("status", "SUCCESS");
	    } else {
	        response.put("status", "FAILURE");
	    }
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
	}

	
	
	/**
	 * EmployeeVO 정보 가져오기
	 * @author PC-01
	 * @return 
	 *
	 */
	@ResponseBody
	@GetMapping("/ntcGetEmp")
	public ResponseEntity<EmployeeVO> ntcGetEmp(Principal principal) {
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
