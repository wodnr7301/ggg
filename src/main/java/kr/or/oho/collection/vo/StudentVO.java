package kr.or.oho.collection.vo;

public class StudentVO extends PeopleVO {

	private String hak;
	private String ban;
	private String no;
	
	public StudentVO() {
		
	}
	
	public StudentVO(String name,
				String sex,
				int age,
				String hak,
				String ban,
				String no
	) {
		this.setName(name);
		this.setSex(sex);
		this.setAge(age);
		this.setHak(hak);
		this.ban = ban;
		this.no = no;
	}
	
	public String getHak() {
		return hak;
	}
	public void setHak(String hak) {
		this.hak = hak;
	}
	public String getBan() {
		return ban;
	}
	public void setBan(String ban) {
		this.ban = ban;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	
	@Override
	public String toString() {
		return super.toString()+ "StudentVO [hak=" + hak + ", ban=" + ban + ", no=" + no + "]";
	}
}
