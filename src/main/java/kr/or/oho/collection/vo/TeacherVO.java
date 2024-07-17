package kr.or.oho.collection.vo;

public class TeacherVO extends PeopleVO {

	private String operateType;
	
	private String manageType;
	
	public TeacherVO() {
		
	}
	
	public TeacherVO(String name,
			String sex,
			int age,
			String operateType,
			String manageType
			) {
		this.setName(name);
		this.setSex(sex);
		this.setAge(age);
		this.operateType = operateType;
		this.manageType = manageType;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public String getManageType() {
		return manageType;
	}

	public void setManageType(String manageType) {
		this.manageType = manageType;
	}

	@Override
	public String toString() {
		return super.toString()+"TeacherVO [operateType=" + operateType + ", manageType=" + manageType + "]";
	}
}
