package com.snowcity.ssls.dao;
import com.snowcity.ssls.domain.Reader;
import com.snowcity.ssls.util.JDBCUtils;
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
}
