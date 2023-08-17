package kr.or.dw.product.vo;

public class ProductVO {
	private String num;
	private String name;
	private int cla;
	private int cost;
	private String p_description;
	private String img;
	private String gb_view;
	
	public String getGb_view() {
		return gb_view;
	}
	public void setGb_view(String gb_view) {
		this.gb_view = gb_view;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getP_description() {
		return p_description;
	}
	public void setP_description(String p_description) {
		this.p_description = p_description;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCla() {
		return cla;
	}
	public void setCla(int cla) {
		this.cla = cla;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	
}
