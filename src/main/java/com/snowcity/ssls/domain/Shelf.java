package com.snowcity.ssls.domain;

import com.snowcity.ssls.dao.BookDao;

import java.util.ArrayList;
import java.util.List;

public class Shelf {
    private List<ShelfItem> shelfItemList;

    public List<ShelfItem> getShelfItemList() {
        return shelfItemList;
    }

    public void setShelfItemList(List<ShelfItem> shelfItemList) {
        this.shelfItemList = shelfItemList;
    }

    public Shelf() {
        shelfItemList = new ArrayList<ShelfItem>();
    }
    public void add(int id){
        BookDao bookDao = new BookDao();
        Book book = bookDao.getById(id);
        ShelfItem shelfItem = new ShelfItem(id, book.getName(), book.getAuthors(),book.getPress(),book.getImageUrl());
        boolean foundFlag = false;
        for (ShelfItem item : this.shelfItemList) {
            if (item.getId() == id) {
//                item.setQuantity(item.getQuantity() + quantity);
                foundFlag = true;
                break;
            }
        }
        if (foundFlag==false){
            this.shelfItemList.add(shelfItem);
        }
    }

    public void remove(int id){
        for (ShelfItem item : this.shelfItemList) {
            if (item.getId() == id) {
                this.shelfItemList.remove(item);
                break;
            }
        }
    }
}
