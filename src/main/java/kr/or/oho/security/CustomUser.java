package kr.or.oho.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.oho.vo.EmployeeVO;
import lombok.Getter;


@Getter
public class CustomUser extends User{

	private EmployeeVO emp;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	 public CustomUser(EmployeeVO emp, Collection<? extends GrantedAuthority> authorities) {
	        super(emp.getEmpId(), emp.getEmpPswd(), authorities);
	        this.emp = emp;
	    }
	
	
	public EmployeeVO getEmployeeVO() {
		return emp;
	}
	
	public void setEmployeeVO(EmployeeVO emp) {
		this.emp = emp;
	}
	
}
