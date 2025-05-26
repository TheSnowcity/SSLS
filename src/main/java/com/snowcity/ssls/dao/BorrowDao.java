package com.snowcity.ssls.dao;


import com.snowcity.ssls.domain.Borrow;
import com.snowcity.ssls.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class BorrowDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    public int getBorrowingCount(int readerId) {
        String sql = "SELECT COUNT(*) FROM Borrow WHERE reader_id = ? AND status = '已借出'";
        return template.queryForObject(sql, Integer.class, readerId);
    }

    public void createBorrow(Borrow borrow) {
        String sql = "INSERT INTO Borrow (book_id, reader_id, due_date, return_date, status, borrow_date) VALUES (?,?,?,?,?,?)";
        template.update(sql, borrow.getBook_id(), borrow.getReader_id(), borrow.getDue_date(), borrow.getReturn_date(), borrow.getStatus(), borrow.getBorrow_date());
    }

//    public List<Borrow> getBorrowingByReaderId(int readerId) {
//        String sql = "SELECT b.*, book.name, book.imageUrl " +
//                "FROM Borrow b " +
//                "JOIN Book ON b.book_id = Book.id " +
//                "WHERE b.reader_id = ? AND b.status = '已借出'";
//        List<Borrow> list =template.query(sql, new BeanPropertyRowMapper<>(Borrow.class), readerId);
//        System.out.println("借阅记录数量：" + list.size()); // 若为 0，说明未查询到数据
//        return template.query(sql, new BeanPropertyRowMapper<>(Borrow.class), readerId);
//    }
    public List<Borrow> getBorrowingByReaderId(int readerId) {
        String sql = "SELECT b.*, book.name, book.imageUrl " +
                "FROM Borrow b " +
                "JOIN Book ON b.book_id = Book.id " +
                "WHERE b.reader_id = ?";
        List<Borrow> list =template.query(sql, new BeanPropertyRowMapper<>(Borrow.class), readerId);
        System.out.println("借阅记录数量：" + list.size()); // 若为 0，说明未查询到数据
        return template.query(sql, new BeanPropertyRowMapper<>(Borrow.class), readerId);
    }
    // 在BorrowDao中添加根据ID查询借阅记录的方法
//    public Borrow getBorrowById(int borrowId) {
//        String sql = "SELECT b.*, book.name, book.imageUrl " +
//                "FROM Borrow b " +
//                "JOIN Book ON b.book_id = Book.id " +
//                "WHERE b.id = ?";
//        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Borrow.class), borrowId);
//    }
    // 通过 borrowId 查询借阅记录（包含图书信息）
//    public Borrow getBorrowById(int borrowId) {
//        String sql = "SELECT " +
//                "b.id, b.book_id, b.reader_id, b.due_date, b.return_date, b.borrow_date, " +
//                "book.name AS book_name, book.imageUrl AS book_imageUrl " + // 别名与 Borrow 类属性匹配
//                "FROM Borrow b " +
//                "JOIN Book ON b.book_id = Book.id " +
//                "WHERE b.id = ?";
//        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Borrow.class), borrowId);
//    }
    // 通过 borrowId 查询借阅记录，并关联 book 表获取图书信息
    public Borrow getBorrowById(int borrowId) {
        String sql = "SELECT " +
                "b.id, b.book_id, b.reader_id, b.due_date, b.return_date, b.status, b.borrow_date, " + // borrow 表字段
                "book.name AS name, book.imageUrl AS imageUrl " + // book 表字段，设置别名
                "FROM Borrow b " +
                "INNER JOIN Book ON b.book_id = book.id " + // 内连接，确保 borrow.book_id 存在于 book 表中
                "WHERE b.id = ?"; // 通过借阅记录ID过滤

        try {
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Borrow.class), borrowId);
        } catch (Exception e) {
            return null; // 无记录时返回 null
        }
    }

//    // 添加更新借阅记录的方法
//    public void updateBorrow(Borrow borrow) {
//        String sql = "UPDATE Borrow SET return_date = ?, status = ? WHERE id = ?";
//        template.update(sql, borrow.getReturn_date(), borrow.getStatus(), borrow.getId());
//    }
//    //扩展方法：更新数据库中的应还日期（due_date）
//    private void updateDueDateInDatabase(Borrow borrow) {
//        String sql = "UPDATE Borrow SET due_date = ? WHERE id = ?";
//        template.update(sql, borrow.getDue_date(), borrow.getId());
//    }
// 在BorrowDao中修改updateBorrow方法
    public void updateBorrow(Borrow borrow) {
        String sql = "UPDATE Borrow SET due_date = ?, return_date = ?, status = ? WHERE id = ?";
        template.update(sql, borrow.getDue_date(), borrow.getReturn_date(), borrow.getStatus(), borrow.getId());
    }
}
