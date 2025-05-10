package com.snowcity.ssls.domain;

public class Category {
    private int id;         // 分类ID
    private String name;    // 分类名称

    public Category() {}

    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getter 和 Setter
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
}
