package com.snowcity.ssls.domain;

import java.time.LocalDate;

public class Fine {
    private int id;
    private int borrow_id;
    private double penalty_amount;
    private String payment_status; // 对应数据库字段
    private LocalDate fine_date;   // 对应数据库字段

    // 构造方法
    public Fine() {
        this.payment_status = "未处理"; // 默认状态
        this.fine_date = LocalDate.now(); // 默认当前日期
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBorrow_id() {
        return borrow_id;
    }

    public void setBorrow_id(int borrow_id) {
        this.borrow_id = borrow_id;
    }

    public double getPenalty_amount() {
        return penalty_amount;
    }

    public void setPenalty_amount(double penalty_amount) {
        this.penalty_amount = penalty_amount;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }

    public LocalDate getFine_date() {
        return fine_date;
    }

    public void setFine_date(LocalDate fine_date) {
        this.fine_date = fine_date;
    }
}