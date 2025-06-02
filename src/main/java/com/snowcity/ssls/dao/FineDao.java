package com.snowcity.ssls.dao;

import com.snowcity.ssls.domain.Fine;
import com.snowcity.ssls.utils.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class FineDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    // 生成罚款记录
    public void createFine(Fine fine) {
        String sql = "INSERT INTO Fine (borrow_id, penalty_amount, payment_status, fine_date) " +
                "VALUES (?, ?, ?, ?)";
        template.update(sql,
                fine.getBorrow_id(),
                fine.getPenalty_amount(),
                fine.getPayment_status(),
                fine.getFine_date()
        );
    }

    // 通过罚款ID查询
    public Fine getFineById(int fineId) {
        String sql = "SELECT * FROM Fine WHERE id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Fine.class), fineId);
    }

    // 更新罚款状态
    public void updateFineStatus(Fine fine) {
        String sql = "UPDATE Fine SET payment_status = ? WHERE id = ?";
        template.update(sql, fine.getPayment_status(), fine.getId());
    }

    // 根据借阅ID查询罚款记录（可选）
    public Fine getFineByBorrowId(int borrowId) {
        String sql = "SELECT * FROM Fine WHERE borrow_id = ?";
        try {
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Fine.class), borrowId);
        } catch (Exception e) {
            return null; // 无记录时返回null
        }
    }

    // 根据读者 ID 查询全部罚款记录（通过 borrow 表关联）
    public List<Fine> getFinesByReaderId(int readerId) {
        String sql = "SELECT f.* " +
                "FROM Fine f " +
                "JOIN Borrow b ON f.borrow_id = b.id " + // 关联 borrow 表
                "WHERE b.reader_id = ?"; // 通过 reader_id 过滤
        return template.query(sql, new BeanPropertyRowMapper<>(Fine.class), readerId);
    }

    // 根据读者ID查询未处理的罚款记录
    public List<Fine> getUnpaidFinesByReaderId(int readerId) {
        String sql = "SELECT f.* " +
                "FROM Fine f " +
                "JOIN Borrow b ON f.borrow_id = b.id " +
                "WHERE b.reader_id = ? " +
                "AND f.payment_status = '未处理'"; // 添加状态过滤
        return template.query(sql, new BeanPropertyRowMapper<>(Fine.class), readerId);
    }

    // 根据读者ID查询已缴纳的罚款记录
    public List<Fine> getPaidFinesByReaderId(int readerId) {
        String sql = "SELECT f.* " +
                "FROM Fine f " +
                "JOIN Borrow b ON f.borrow_id = b.id " +
                "WHERE b.reader_id = ? " +
                "AND f.payment_status = '已缴纳'"; // 添加状态过滤
        return template.query(sql, new BeanPropertyRowMapper<>(Fine.class), readerId);
    }
}