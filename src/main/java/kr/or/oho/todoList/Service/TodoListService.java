package kr.or.oho.todoList.Service;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.TodoListVO;

public interface TodoListService {

	List<TodoListVO> getCalendarList(Map<String, Object> map);

	List<TodoListVO> getCheckBoxList(Map<String, Object> map);
	
	List<TodoListVO> getCheckBoxList2(Map<String, Object> map);
	
	List<TodoListVO> getCheckBoxList3(Map<String, Object> map);
	
	TodoListVO getCalendarDetail(TodoListVO todoListVO);
	
	/**
	 * 오늘 날짜의 일정 갯수 가져오기
	 * @param
	 * @return 
	 */
	int getCalendarCount(String empNo);
	
	int createPost(TodoListVO todoListVO);

	int updatePost(TodoListVO todoListVO);

	int deletePost(TodoListVO todoListVO);






	

}
