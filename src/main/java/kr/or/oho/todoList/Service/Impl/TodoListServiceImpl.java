package kr.or.oho.todoList.Service.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.oho.mapper.TodoListMapper;
import kr.or.oho.todoList.Service.TodoListService;
import kr.or.oho.vo.TodoListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TodoListServiceImpl implements TodoListService{

	@Autowired
	TodoListMapper todoListMapper;
	
	@Override
	public List<TodoListVO> getCalendarList(Map<String, Object> map) {
		
		return todoListMapper.getCalendarList(map);
	}
	
	@Override
	public List<TodoListVO> getCheckBoxList(Map<String, Object> map) {
		
		return todoListMapper.getCheckBoxList(map);
	}

	@Override
	public List<TodoListVO> getCheckBoxList2(Map<String, Object> map) {
		
		return todoListMapper.getCheckBoxList2(map);
	}
	
	@Override
	public List<TodoListVO> getCheckBoxList3(Map<String, Object> map) {
		
		return todoListMapper.getCheckBoxList3(map);
	}
	
	@Override
	public TodoListVO getCalendarDetail(TodoListVO todoListVO) {

		return todoListMapper.getCalendarDetail(todoListVO);
	}
	
	@Override
	public int getCalendarCount(String empNo) {
		
		return todoListMapper.getCalendarCount(empNo);
	}
	
	@Override
	public int createPost(TodoListVO todoListVO) {
		
		return todoListMapper.createPost(todoListVO);
	}

	@Override
	public int updatePost(TodoListVO todoListVO) {
		
		return todoListMapper.updatePost(todoListVO);
	}

	@Override
	public int deletePost(TodoListVO todoListVO) {
		
		return todoListMapper.deletePost(todoListVO);
	}


}
