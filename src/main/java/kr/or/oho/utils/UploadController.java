package kr.or.oho.utils;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.or.oho.mapper.AttachMapper;
import kr.or.oho.vo.AttachVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class UploadController {
	
	//static String uploadFolder => null이 메모리에 올라감
	@Autowired
	String uploadFolder;
	
	//root-context.xml => uploadFolderDirect
	@Autowired
	String uploadFolderDirect; 
	
	//static AttachMapper attachMapper => null이 메모리에 올라감
	@Autowired
	AttachMapper attachMapper;
	
	//첨부파일 1개 업로드(1 : 1)			파일객체,					글로벌 코드 String ??
	/**
	 * @param uploadFile
	 * @param afGlocd
	 * @return 업로드 된 파일 갯수
	 */
	public int uploadOne(MultipartFile uploadFile, String afGlocd) {
		log.info("globalCode12312312312 : "+ afGlocd);
		int result = 0;
		//	c:\\...\\upload + "\\" + 2024\\05\\07
		File uploadPath = new File(this.uploadFolderDirect, getFolder());
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		log.info("-----------------------------------------");
		log.info("파일명 :" + uploadFile.getOriginalFilename());
		log.info("파일 크기 :" + uploadFile.getSize());
		log.info("MIME :" + uploadFile.getContentType());
		
		String uploadFileName = uploadFile.getOriginalFilename();
		log.info("업로드 파일명 : " + uploadFileName);
		
		//UUID : 랜덤값 생성
		UUID uuid = UUID.randomUUID();
		//asdfasdf_개똥이.jpg
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		//복사 설계
		File saveFile = new File(uploadPath, uploadFileName);
		
		//복사 실행
		try {
			uploadFile.transferTo(saveFile);
			
			//웹경로
			String afNm = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			log.info("파일 웹 경로 : " + afNm);
			
			AttachVO attachVO = new AttachVO();
			attachVO.setAfGlocd(afGlocd);
			attachVO.setAfSeq(1);;
			attachVO.setAfNm(afNm);;
			attachVO.setAfSz(uploadFile.getSize());
			attachVO.setAfExtnNm(uploadFile.getContentType());
			attachVO.setAfPstdt(null);
			
			log.info("uploadOne -> attachVO :" + attachVO);
			
			result = attachMapper.insertAttach(attachVO);
			log.info("uploadOne-> result : " + result);
			
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		} 
		
		
		return result;
	}
	
		/**
		 * @param uploadFile
		 * @param afGlocd
		 * @return 업로드 된 파일 갯수
		 */
	//첨부파일 N개 업로드(1 : N)			파일객체,					글로벌 코드 String empNo ex) EMP063
		public int uploadMulti(MultipartFile[] uploadFile, String afGlocd) {
			
			// 연월일 폴더 처리 시작///////////
			//	c:\\...\\upload + "\\" + 2024\\05\\07
			File uploadPath = new File(this.uploadFolderDirect, getFolder());
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			// 연월일 폴더 처리 끝////////////
			
			// 스프링 파일객체 타입의 배열로부터 파일객체를 하나씩 꺼내보자
			
			String uploadFileName = ""; //업로드용
			String afNm = ""; //DB용
			int afSeq = 1;
			int result = 0;
			
			for(MultipartFile multipartFile : uploadFile) {
				log.info("-----------------------------------------");
				log.info("파일명 :" + multipartFile.getOriginalFilename());
				log.info("파일 크기 :" + multipartFile.getSize());
				log.info("MIME :" + multipartFile.getContentType());
				
				uploadFileName = multipartFile.getOriginalFilename();
				
				//UUID : 랜덤값 생성
				UUID uuid = UUID.randomUUID();
				//asdfasdf_개똥이.jpg
				uploadFileName = uuid.toString() + "_" + uploadFileName;
				
				//파일 복사 계획(, : +"\\"+)
				//File 객체 설계(복사할 대상 경로, 파일명)
				//File saveFile = new File(uploadFolder, uploadFileName);
					
				//uploadPath : D:\\A_TeachingMaterial\\06_spring\\springProj\\src\\
				//					main\\webapp\\resources\\upload\\2024\\05\\07
				File saveFile = new File(uploadPath, uploadFileName);
					
				//파일 복사 실행
				try {
						multipartFile.transferTo(saveFile);
						
						//웹경로(2024\\05\\07 => 2024/05/07/asdfdsa_개똥이.jpg)
						afNm = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
						
						AttachVO attachVO = new AttachVO();
						attachVO.setAfGlocd(afGlocd);
						attachVO.setAfSeq(afSeq++); // 1(하드코딩할거면)
						attachVO.setAfNm(afNm);
						attachVO.setAfSz(multipartFile.getSize());
						attachVO.setAfExtnNm(multipartFile.getContentType());
						attachVO.setAfPstdt(null);
						
						log.info("uploadMulti -> attachVO :" + attachVO);
						
						result += this.attachMapper.insertAttach(attachVO);
						log.info("uploadMulti-> result : " + result);
					
					} catch (IllegalStateException | IOException e) {
						log.error(e.getMessage());
					}
			}
			
			
			return result;
		}
		
	
	//연/월/일 폴더 생성
    public String getFolder() {
      //2022-11-16 형식(format) 지정
      //간단한 날짜 형식
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      
      //날짜 객체 생성(java.util 패키지)
      Date date = new Date();
      
      //2022-11-16
      String str = sdf.format(date);
      
      //2024-01-30 -> 2024\\01\\30
      //File.separator : \\(윈도우 경로) 
      return str.replace("-", File.separator);
   }
    
    
    
	/**
	 * 파일명 지정해서 파일 하나 업로드
	 * @param uploadFile 업로드 할 파일
	 * @param afGlocd 기본키
	 * @param newName 저장할 새 파일명
	 * @return 업로드 성공한 파일 수 1:성공
	 */
	public int renameUploadOne(MultipartFile uploadFile, String afGlocd, String newName) {
		log.info("globalCode12312312312 : " + afGlocd);
		int result = 0;
		// c:\\...\\upload + "\\" + 2024\\05\\07
		File uploadPath = new File(this.uploadFolderDirect, getFolder());
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		log.info("-----------------------------------------");
		log.info("원래 파일명 :" + uploadFile.getOriginalFilename());
		log.info("파일 크기 :" + uploadFile.getSize());
		log.info("MIME :" + uploadFile.getContentType());

		String uploadFileName = newName;
		log.info("업로드 파일명 : " + uploadFileName);

		// UUID : 랜덤값 생성
		UUID uuid = UUID.randomUUID();
		// asdfasdf_개똥이.jpg
		uploadFileName = uuid.toString() + "_" + uploadFileName;

		// 복사 설계
		File saveFile = new File(uploadPath, uploadFileName);

		// 복사 실행
		try {
			uploadFile.transferTo(saveFile);

			// 웹경로
			String afNm = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			log.info("파일 웹 경로 : " + afNm);

			AttachVO attachVO = new AttachVO();
			attachVO.setAfGlocd(afGlocd);
			attachVO.setAfSeq(1);
			;
			attachVO.setAfNm(afNm);
			;
			attachVO.setAfSz(uploadFile.getSize());
			attachVO.setAfExtnNm(uploadFile.getContentType());
			attachVO.setAfPstdt(null);

			log.info("uploadOne -> attachVO :" + attachVO);

			result = attachMapper.insertAttach(attachVO);
			log.info("uploadOne-> result : " + result);

		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage());
		}

		return result;
	}
	
	
	
	
	
	//CKEiditor5 파일업로드
	   // /image/upload
	   // ckeditor는 이미지 업로드 후 이미지 표시하기 위해 uploaded 와 url을 json 형식으로 받아야 함
	   // modelandview를 사용하여 json 형식으로 보내기위해 모델앤뷰 생성자 매개변수로 jsonView 라고 써줌
	   // jsonView 라고 쓴다고 무조건 json 형식으로 가는건 아니고 @Configuration 어노테이션을 단 
	   // WebConfig 파일에 MappingJackson2JsonView 객체를 리턴하는 jsonView 매서드를 만들어서 bean으로 등록해야 함
	   
	   @ResponseBody
	   @PostMapping("/image/upload")
	   public Map<String, Object> image(MultipartHttpServletRequest request) throws IllegalStateException, IOException{
	      ModelAndView mav = new ModelAndView("jsonView");
	      
	      // ckeditor에서 파일을 보낼 때 upload : [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 밸류를 받아서
	       // uploadFile에 저장함
	      MultipartFile uploadFile = request.getFile("upload");
	      log.info("uploadFile : " + uploadFile);
	      
	      // 파일 명
	      String originalFileName = uploadFile.getOriginalFilename();
	      log.info("originalFileName : " + originalFileName);
	      
	      //originalFileName : 개똥이.jpg -> .jpg
	      String ext = originalFileName.substring(originalFileName.indexOf(".")); //확장자의 위치에서부터 끝까지
	      
	      // 서버에 저장될 때 중복된 파일 이름인 경우를 방지하기 위해 UUID에 확장자를 붙여 새로운 파일 이름을 생성
	      // asdlfksdfakl.jpg
	      String newFileName = UUID.randomUUID() +"_"+ originalFileName;
	      
	      File f = new File(uploadFolder); //root-context.xml에 있는 bean(경로 설정), 만약 없으면 경로를 생성
	      if(f.exists() == false) {
	         f.mkdirs();
	      }
	      
	      // 저장 경로로 파일 객체를 저장하겠다. uploadFolderDirect -> root-context.xml의 bean
	      // c:\\ 업로드 경로 \\ asdfsdfdf.jpg
	      File file = new File(uploadFolder, newFileName);
	      
	      // 파일 복사
	      uploadFile.transferTo(file);
	      
	      // 브라우저에서 이미지 불러올 때 절대 경로로 불러오면 보안의 위험 있어 
	      // 상대경로를 쓰거나 이미지 불러오는 jsp 또는 클래스 파일을 만들어
	       // 가져오는 식으로 우회해야 함
	       // 때문에 savePath와 별개로 상대 경로인 uploadPath 만들어줌
	      String uploadPath = "/upload/" + newFileName; // 웹 페이지 저장 상대 경로
	      
	      // uploaded, url 값을 modelandview를 통해 보냄
//	      mav.addObject("uploaded", true); // 업로드 완료
//	      mav.addObject("url", uploadPath); // 업로드 파일의 경로
	      
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("uploaded", true);
	      map.put("url", uploadPath);
	      //map :{uploaded=true, url=/upload/abe10693-623d-47b0-9daa-fd960a5717ce_111가1234.jpg}
	      log.info("map :" + map);
	      
	      return map;
	   }



	
}
