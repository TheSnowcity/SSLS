package com.snowcity.ssls.domain;

import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.util.Date;
public class Borrow {
    private int id;
    private int book_id;
    private int reader_id;
    private LocalDate due_date;
    private LocalDate return_date;
    private String status;
    // 新增图书属性（需与 SQL 中的字段名一致，注意驼峰命名）
    private String name;        // 对应 book.name
    private String imageUrl;    // 对应 book.imageUrl

    private LocalDate borrow_date; // 新增：借阅日期字段

    // 判断是否逾期
//    public boolean isOverdue() {
//        if (return_date != null || due_date == null) {
//            return false;
//        }
//        return LocalDate.now().isAfter(due_date);
//    }
    public boolean isOverdue() {
        // 若应还日期为空，直接返回 false
        if (due_date == null) {
            return false;
        }
        // 关键修改：比较 due_date 和当前日期，忽略 return_date
        return LocalDate.now().isAfter(due_date);
    }
    // 计算逾期天数（不使用ChronoUnit）
    public long getOverdueDays() {
        if (!isOverdue()) {
            return 0;
        }

        LocalDate currentDate = LocalDate.now();
        LocalDate dueDate = this.due_date;

        // 手动计算日期间隔天数
        long days = 0;
        LocalDate tempDate = dueDate;

        while (tempDate.isBefore(currentDate)) {
            tempDate = tempDate.plusDays(1);
            days++;
        }

        return days;
    }

    public Borrow() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getReader_id() {
        return reader_id;
    }

    public void setReader_id(int reader_id) {
        this.reader_id = reader_id;
    }

    public LocalDate getDue_date() {
        return due_date;
    }

    public void setDue_date(LocalDate due_date) {
        this.due_date = due_date;
    }

    public LocalDate getReturn_date() {
        return return_date;
    }

    public void setReturn_date(LocalDate return_date) {
        this.return_date = return_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public LocalDate getBorrow_date() {
        return borrow_date;
    }

    public void setBorrow_date(LocalDate borrow_date) {
        this.borrow_date = borrow_date;
    }
}
