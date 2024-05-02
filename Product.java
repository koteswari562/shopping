package shop.cart;

public class Product {
	int id;
	String name;
	int price;
	String imgpath;

	public Product(int id, String name, int price, String imgpath) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.imgpath = imgpath;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public int getPrice() {
		return price;
	}

	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}

	public String getImgpath() {
		return imgpath;
	}

}
