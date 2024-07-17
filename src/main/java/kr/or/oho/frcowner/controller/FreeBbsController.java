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

import kr.or.oho.frcowner.service.FreeBbsService;
import kr.or.oho.security.CustomUser;
import kr.or.oho.vo.ComentVO;
import kr.or.oho.vo.EmployeeVO;
import kr.or.oho.vo.FreeBbsVO;
import lombok.extern.slf4j.Slf4j;

/** 
 * 가맹점주 게시판 && 게시판 댓글
 * @author PC-01
 * 
 */
@Slf4j
@Controller
@RequestMapping("/frcowner")
public class FreeBbsController {
	
	
	@Autowired
	FreeBbsService freeBbsService; 
	
	
	/**
	 * 점주 자유게시판 리스트
	 * @author PC-01
	 *
	 */
	@GetMapping("/boardList")
	public String boardList(Model model, Principal principal) {
	    log.info("점주 게시판 list에 진입!");

	    List<FreeBbsVO> freeBbsList = this.freeBbsService.list();
	    log.info("점주 게시판 list -> freeBbsList : " + freeBbsList);
	    
	    model.addAttribute("freeBbsList", freeBbsList);

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
	    return "board/boardList";
	}

	
	
	
	/**
	 * 점주 자유게시판 상세보기
	 * @author PC-01
	 *
	 */
	 @GetMapping("/boardDetail")
	 public String boardDetail(@RequestParam("fbNo") String fbNo, Model model, Principal principal) {
	     log.info("점주 게시판 Detail에 진입!");

	     freeBbsService.count(fbNo);

	     FreeBbsVO freeBbs = this.freeBbsService.detail(fbNo);
	     log.info("점주 게시글 Detail -> freeBbs : " + freeBbs);
	     
	     List<ComentVO> comentList = this.freeBbsService.comentList(fbNo);
	     
	     freeBbs.setComentList(comentList);
	     log.info("점주 게시판 Coment -> comentList : " + comentList);

	     model.addAttribute("freeBbs", freeBbs);
	     log.info("freeBbs: " + freeBbs);

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
	     
	     return "board/boardDetail";
	 }

	
	 
	/**
	 * 점주 자유게시글 생성(GET)
	 * @author PC-01
	 *
	 */ 
	@GetMapping("/boardCreate")
    public String showCreateBoardForm(Model model) {
		log.info("점주 게시판 Create에 진입! (GET)");

        model.addAttribute("freeBbsVO", new FreeBbsVO());
        
        return "board/boardCreate"; 
    }
	
	
	
	/**
	 * 점주 자유게시글 생성(POST)
	 * @author PC-01
	 *
	 */
	@PostMapping("/boardCreate")
	public String boardCreate(@Validated @ModelAttribute(value="freeBbsVO") FreeBbsVO freeBbsVO,
	                          BindingResult brResult, Principal principal, Model model) {
	    log.info("점주 게시판 Create에 진입! (POST)");
	    log.info("boardCreate->brResult.hasErrors() : " + brResult);

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

	        return "frcowner/boardCreate";
	    }

	    log.info("if문 종료");

	    // Principal에서 emp_no 설정
	    if (principal != null) {
	        UsernamePasswordAuthenticationToken auth = (UsernamePasswordAuthenticationToken) principal;
	        CustomUser customUser = (CustomUser) auth.getPrincipal();
	        EmployeeVO emp = customUser.getEmployeeVO();
	        
	        if (emp != null) {
	            freeBbsVO.setEmpNo(emp.getEmpNo());  // emp_no 설정
	        } else {
	            log.error("EmployeeVO is null");
	            return "redirect:/login";
	        }
	    } else {
	        log.error("Principal is null");
	        return "redirect:/login";
	    }

	    int result = this.freeBbsService.create(freeBbsVO);

	    log.info("boardCreate -> result : " + result);
	    log.info("boardCreate->freeBbsVO: " + freeBbsVO);

	    return "redirect:/frcowner/boardList";
	}

	
	
	/**
	 * 점주 자유게시글 수정(GET)
	 * @author PC-01
	 *
	 */
	@GetMapping("/boardUpdate")
    public String boardUpdate(@RequestParam("fbNo") String fbNo, Model model) {
		log.info("점주 게시판 Update에 진입! (GET)");
	    
		FreeBbsVO freeBbs = this.freeBbsService.detail(fbNo);
		log.info("freeBbs : " + freeBbs);
		
        model.addAttribute("freeBbs", freeBbs);
        
        return "board/boardUpdate";  
    }
	
	
	
	/**
	 * 점주 자유게시글 수정(POST)
	 * @author PC-01
	 *
	 */
	@PostMapping("/boardUpdate")
	public String boardUpdate(FreeBbsVO freeBbsVO, Model model) {
		log.info("점주 게시판 Update에 진입! (Post)");
		
		int result = this.freeBbsService.update(freeBbsVO);
		log.info("updatePost->result: " + result);
		
		model.addAttribute("freeBbsVO", freeBbsVO);
		
		return "redirect:/frcowner/boardList";  
	}
	
	
	
	/**
	 * 점주 자유게시글 삭제
	 * @author PC-01
	 *
	 */
	@GetMapping("/boardDelete")
	public String boardDeletePost(@RequestParam("fbNo") String fbNo) {
		log.info("점주 게시판 Delete에 진입!)");
		
		freeBbsService.delete(fbNo);
		
		return "redirect:/frcowner/boardList"; 
	}
	
	
	
	/*----------------------------------------------------------------------------------<아래부터 댓글 컨트롤러>----------------------------------------------------------------------------------*/
	
	
	
	/**
	 * 점주 댓글 생성
	 * @author PC-01
	 *
	 */
	@ResponseBody
	@PostMapping("/cmtCreate")
	public ResponseEntity<Map<String, Object>> cmntCreate(@RequestBody ComentVO comentVO) {
		log.info("댓글 create에 진입!");
		log.info("cmntCreatePost -> comentVO: " + comentVO);

	    int result = freeBbsService.createCmt(comentVO);
	    log.info("cmntCreateAjax - >result : " + result);

	    Map<String, Object> response = new HashMap<>();
	    
	    if (result > 0) {
	        response.put("status", "SUCCESS");
	        response.put("fbNo", comentVO.getCmntCd()); 
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
	@PostMapping("/cmtUpdate")
	public ResponseEntity<Map<String, String>> cmtUpdate(@RequestBody ComentVO comentVO) {
		log.info("댓글 Update에 진입!");
		
		int result = this.freeBbsService.updateCmt(comentVO);
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
	@PostMapping("/cmtDelete")
	public ResponseEntity<Map<String, String>> cmtDelete(@RequestBody ComentVO comentVO) {
	    log.info("댓글 Delete에 진입!");
	    
	    int result = this.freeBbsService.deleteCmt(comentVO);
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
	@GetMapping("/getEmp")
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