package kr.or.oho.mapper;

import java.util.List;
import java.util.Map;

import kr.or.oho.vo.TodoListVO;


public interface TodoListMapper {

	List<TodoListVO> getCalendarList(Map<String, Object> map);
	
	List<TodoListVO> getCheckBoxList(Map<String, Object> map);
	
	List<TodoListVO> getCheckBoxList2(Map<String, Object> map);
	
	List<TodoListVO> getCheckBoxList3(Map<String, Object> map);
	
	TodoListVO getCalendarDetail(TodoListVO todoListVO);
	
	int getCalendarCount(String empNo);
	
	int createPost(TodoListVO todoListVO);

	int updatePost(TodoListVO todoListVO);

	int deletePost(TodoListVO todoListVO);





}
