package page;

public class Page_DTO {
	private int page_no;
	private String title;
	private String data;
	private int parent;
	private int orderno;
	
	public Page_DTO() {}

	
	public Page_DTO(int page_no, String title, String data, int parent, int orderno) {
		super();
		this.page_no = page_no;
		this.title = title;
		this.data = data;
		this.parent = parent;
		this.orderno = orderno;
	}


	public int getPage_no() {
		return page_no;
	}

	public void setPage_no(int page_no) {
		this.page_no = page_no;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public int getParent() {
		return parent;
	}
	
	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getOrderno() {
		return orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}



	
	
}
