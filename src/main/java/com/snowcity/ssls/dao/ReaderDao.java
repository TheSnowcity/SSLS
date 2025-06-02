package com.snowcity.ssls.dao;

import com.snowcity.ssls.domain.Reader;
import com.snowcity.ssls.utils.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.DigestUtils;

import java.nio.charset.StandardCharsets;
public class ReaderDao {
    private static JdbcTemplate template=new JdbcTemplate(JDBCUtils.getDataSource());
    public Reader getByEmailAndPwd(String email, String pwd){
        Reader reader=null;
        try{
            String sql = "select * from reader where email=? and password=?";
            String pwdMD5=DigestUtils.md5DigestAsHex(pwd.getBytes(StandardCharsets.UTF_8));
            reader=template.queryForObject(sql,new BeanPropertyRowMapper<Reader>(Reader.class),email,pwd);
        }catch (Exception e){
            e.printStackTrace();
        }
        finally {
            return reader;
        }
    }

    public Reader getReaderById(int readerId){
        Reader reader = null;
        try{
            String sql = "select * from reader where id=?";
            reader=template.queryForObject(sql,new BeanPropertyRowMapper<Reader>(Reader.class),readerId);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return reader;
        }
    }

    // 修改密码
    public void changePassword(int readerId, String newPassword) {
        String sql="UPDATE reader SET password=? WHERE id=?";
        template.update(sql, newPassword, readerId);
    }


    // 账户充值
    public void recharge(int readerId, double amount) {
        String sql="UPDATE reader SET balance = balance + ? WHERE id=?";
        template.update(sql, amount, readerId);
    }

    // 判断用户名是否合法（不重复）
    public boolean checkUsername(String username){
        Reader reader = null;
        try{
            String sql = "SELECT * FROM reader WHERE username=?";
            reader = template.queryForObject(sql, new BeanPropertyRowMapper<Reader>(Reader.class), username);
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            return reader == null;
        }
    }

    // 判断邮箱是否合法（不重复）
    public boolean checkEmail(String email){
        Reader reader = null;
        try{
            String sql = "SELECT * FROM reader WHERE email=?";
            reader = template.queryForObject(sql, new BeanPropertyRowMapper<Reader>(Reader.class), email);
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            return reader == null;
        }
    }

    public void createReader(Reader reader){
        String sql = "INSERT INTO reader (userType, name, username, gender, password, email, balance, phone, register_date) VALUES(?,?,?,?,?,?,?,?,?)";
        template.update(sql, reader.getUserType(), reader.getName(), reader.getUsername(), reader.getGender(), reader.getPassword(), reader.getEmail(), reader.getBalance(), reader.getPhone(), reader.getRegisterDate());
    }
}
