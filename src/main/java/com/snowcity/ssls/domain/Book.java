package com.snowcity.ssls.domain;

import java.util.Date;

public class Book {
    private int id;               // 书ID
    private String title;         // 书名
    private String author;        // 作者
    private Category category;    // 分类（对象关联）
    private int stock;            // 储存量
    private Date onDate;     // 上架时间

    public Book() {}

    public Book(int id, String title, String author, Category category, int stock, Date publishDate) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.stock = stock;
        this.onDate = onDate;
    }

    // Getter 和 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Date getOnDate() {
        return onDate;
    }

    public void setOnDate(Date publishDate) {
        this.onDate = publishDate;
    }
}
