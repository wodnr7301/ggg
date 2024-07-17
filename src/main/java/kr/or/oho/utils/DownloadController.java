package kr.or.oho.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.or.oho.utils.service.DownloadService;
import kr.or.oho.vo.AttachVO;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class DownloadController {
	
	@Autowired
	DownloadService downloadService;
	
	@GetMapping("/download/{globalCd}/{seq}")
	public void download(HttpServletResponse response, @PathVariable("globalCd") String globalCd, @PathVariable("seq") int seq) throws Exception {
        
		AttachVO attachVO = new AttachVO();
		attachVO.setAfGlocd(globalCd);
		attachVO.setAfSeq(seq);
		
		AttachVO getAttachVO = this.downloadService.getAttachVOList(attachVO);
		
		FileInputStream fileInputStream = null;
		try {
        	String path = "D:\\team1\\source\\OhoKorea\\src\\main\\webapp\\resources\\upload"+getAttachVO.getAfNm(); // 경로에 접근할 때 역슬래시('\') 사용
        	
        	log.debug("path =" + path);
        	File file = new File(path);
        	
        	 // UTF-8 인코딩된 파일 이름 생성 (바뀐 부분)
            String encodedFileName = URLEncoder.encode(file.getName(), StandardCharsets.UTF_8.toString());
            encodedFileName = encodedFileName.replaceAll("\\+", "%20"); // 공백 처리

            // Content-Disposition 헤더 설정 (바뀐 부분)
            response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        	
        	fileInputStream = new FileInputStream(path); // 파일 읽어오기 
        	OutputStream out = response.getOutputStream();
        	
        	int read = 0;
                byte[] buffer = new byte[1024];
                while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
                    out.write(buffer, 0, read);
                }
                
        } catch (Exception e) {
            throw new Exception("download error");
        }finally {
        	if(fileInputStream!=null) {
        		try {
        			fileInputStream.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
        	}
		}
    }
}