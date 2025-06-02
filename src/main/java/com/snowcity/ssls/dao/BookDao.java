package com.snowcity.ssls.dao;



import com.snowcity.ssls.domain.Book;
import com.snowcity.ssls.utils.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.List;

public class BookDao {
    private JdbcTemplate template= new JdbcTemplate(JDBCUtils.getDataSource());
    public List<Book> getNewList(){
        List<Book> bookList = null;
        try{
            String sql = "select * from book order by publishDate desc limit 16";
            bookList = template.query(sql,new BeanPropertyRowMapper<>(Book.class));
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return bookList;
        }
    }


    public Book getById(int id) {
        Book book = null;
        try {
            String sql = "select * from book where id=?";
            book = template.queryForObject(sql, new BeanPropertyRowMapper<>(Book.class), id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return book;
        }
    }

    public List<Book> getByCategory(int categoryId) {
        List<Book> bookList = null;
        try {
            String sql = "select * from book where categoryId=?";
            bookList = template.query(sql,new BeanPropertyRowMapper<>(Book.class), categoryId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return bookList;
        }
    }

    public List<Book> getByStatus(String status) {
        List<Book> bookList = null;
        try {
            String sql = "select * from book where status=?";
            bookList = template.query(sql,new BeanPropertyRowMapper<>(Book.class), status);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return bookList;
        }
    }


    public List<Book> getByCategoryAndStatus(int categoryId, String status) {
        List<Book> bookList = null;
        try {
            String sql = "select * from book where categoryId=? and status=?";
            bookList = template.query(sql,new BeanPropertyRowMapper<>(Book.class), categoryId, status);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return bookList;
        }
    }

    public void updateBook(Book book) {
        String sql = "UPDATE Book SET status = ? WHERE id = ?";
        template.update(sql, book.getStatus(), book.getId());
    }
}


