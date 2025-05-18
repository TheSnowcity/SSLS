package com.snowcity.ssls.domain;

public class ShelfItem {
    private int id;
    private String name;
    private String authors;
    private String press;
    private String imageUrl;

    public ShelfItem() {
    }

    public ShelfItem(int id, String name, String authors, String press, String imageUrl) {
        this.id = id;
        this.name = name;
        this.authors = authors;
        this.press = press;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthors() {
        return authors;
    }

    public void setAuthors(String authors) {
        this.authors = authors;
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
