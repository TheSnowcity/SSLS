package com.snowcity.ssls.util;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import com.alibaba.druid.pool.DruidDataSourceFactory;
public class JDBCUtils {
    private static DataSource ds ;
    static {
        try {
            //1.加载配置文件
            Properties pro = new Properties();
            //使用ClassLoader加载配置文件，获取字节输入流
            InputStream is = JDBCUtils.class.getClassLoader()
                    .getResourceAsStream("druid.properties");
            pro.load(is);
            //2.初始化连接池对象
            ds = DruidDataSourceFactory.createDataSource(pro);
        } catch (IOException e) {
            throw new RuntimeException("找不到druid.properties文件， 请在resources文件夹中创建druid.properties文件", e);
        } catch (Exception e) {
            throw new RuntimeException("数据库初始化异常", e);
        }
    }
    public static DataSource getDataSource(){
        return ds;
    }
    public static Connection getConnection() throws SQLException {
        return  ds.getConnection();
    }
}

