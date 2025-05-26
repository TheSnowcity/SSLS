-- 创建数据库SSLS
CREATE DATABASE IF NOT EXISTS SSLS;
USE SSLS;

-- 创建图书分类表Category
CREATE TABLE Category (
      id INT AUTO_INCREMENT PRIMARY KEY,
      code VARCHAR(50) NOT NULL,
      name VARCHAR(50) NOT NULL
);

-- 创建图书表Book
CREATE TABLE Book (
      id INT AUTO_INCREMENT PRIMARY KEY,
      code VARCHAR(50) NOT NULL,
      name VARCHAR(100) NOT NULL,
      authors VARCHAR(100) NOT NULL,
      press VARCHAR(100) NOT NULL,
      imageUrl VARCHAR(100),
      description VARCHAR(1000),
      publishDate DATE, -- 修改为DATE类型
      price DECIMAL(10, 2),
      status VARCHAR(50),
      categoryId INT NOT NULL,
      FOREIGN KEY (categoryId) REFERENCES Category(id)
);

-- 创建读者表Reader
CREATE TABLE Reader (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userType VARCHAR(30) NOT NULL,
    name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(30) NOT NULL
);

-- 创建借阅表Borrow
CREATE TABLE Borrow (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    reader_id INT NOT NULL,
    due_date DATETIME NOT NULL,
    return_date DATETIME NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Book(id),
    FOREIGN KEY (reader_id) REFERENCES Reader(id)
);

-- 创建罚款缴纳表Fine
CREATE TABLE Fine (
      id INT AUTO_INCREMENT PRIMARY KEY,
      borrow_id INT NOT NULL,
      penalty_amount DECIMAL(10, 2) NOT NULL,
      FOREIGN KEY (borrow_id) REFERENCES Borrow(id)
);

-- 向Category表插入5条以上记录
INSERT INTO Category (code, name) VALUES
('C001', '文学类'),
('C002', '科技类'),
('C003', '历史类'),
('C004', '经济类'),
('C005', '哲学类'),
('C006', '艺术类');

-- 向Book表插入30条以上记录（修改日期格式）
INSERT INTO Book (code, name, authors, press, imageUrl, description, publishDate, price, status, categoryId) VALUES
('B001', '百年孤独', '加西亚·马尔克斯', '南海出版公司', '/bookimg/book1.jpg', '这是一部魔幻现实主义文学巨著', '1989-01-01', 59.00, '在库', 1),
('B002', '时间简史', '斯蒂芬·霍金', '湖南科学技术出版社', '/bookimg/book2.jpg', '讲述了宇宙的起源和发展', '1988-04-01', 45.00, '在库', 2),
('B003', '史记', '司马迁', '中华书局', '/bookimg/book3.jpg', '中国第一部纪传体通史', '1959-09-01', 88.00, '在库', 3),
('B004', '资本论', '卡尔·马克思', '人民出版社', '/bookimg/book4.jpg', '阐述了马克思主义政治经济学', '1867-09-14', 98.00, '在库', 4),
('B005', '理想国', '柏拉图', '商务印书馆', '/bookimg/book5.jpg', '古希腊哲学经典著作', '1986-08-01', 35.00, '在库', 5),
('B006', '蒙娜丽莎', '相关艺术研究书籍', '艺术出版社', '/bookimg/book6.jpg', '关于蒙娜丽莎的艺术解析', '2000-05-01', 60.00, '在库', 6),
('B007', '追风筝的人', '卡勒德·胡赛尼', '上海人民出版社', '/bookimg/book7.jpg', '讲述阿富汗的故事', '2006-05-01', 42.00, '在库', 1),
('B008', '万物简史', '比尔·布莱森', '接力出版社', '/bookimg/book8.jpg', '介绍科学知识的科普书籍', '2005-01-01', 52.00, '在库', 2),
('B009', '中国通史', '吕思勉', '中华书局', '/bookimg/book9.jpg', '系统介绍中国历史', '1940-01-01', 78.00, '在库', 3),
('B010', '经济学原理', 'N·格里高利·曼昆', '北京大学出版社', '/bookimg/book10.jpg', '经济学入门经典教材', '1998-01-01', 68.00, '在库', 4),
('B011', '存在与时间', '马丁·海德格尔', '生活·读书·新知三联书店', '/bookimg/book11.jpg', '现代哲学重要著作', '1927-04-01', 55.00, '在库', 5),
('B012', '艺术的故事', '贡布里希', '广西美术出版社', '/bookimg/book12.jpg', '艺术史经典书籍', '1950-01-01', 85.00, '在库', 6),
('B013', '简·爱', '夏洛蒂·勃朗特', '上海译文出版社', '/bookimg/book13.jpg', '经典文学作品', '1995-07-01', 38.00, '在库', 1),
('B014', '物种起源', '查尔斯·达尔文', '商务印书馆', '/bookimg/book14.jpg', '生物学经典著作', '1859-11-24', 48.00, '在库', 2),
('B015', '全球通史', '斯塔夫里阿诺斯', '北京大学出版社', '/bookimg/book15.jpg', '介绍世界历史的书籍', '1970-01-01', 75.00, '在库', 3),
('B016', '国富论', '亚当·斯密', '华夏出版社', '/bookimg/book16.jpg', '经济学奠基之作', '1776-03-09', 65.00, '在库', 4),
('B017', '悲剧的诞生', '弗里德里希·尼采', '商务印书馆', '/bookimg/book17.jpg', '哲学著作', '1872-01-01', 40.00, '在库', 5),
('B018', '世界美术名作二十讲', '傅雷', '生活·读书·新知三联书店', '/bookimg/book18.jpg', '介绍美术名作的书籍', '1985-01-01', 58.00, '在库', 6),
('B019', '骆驼祥子', '老舍', '人民文学出版社', '/bookimg/book19.jpg', '中国现代文学经典', '1936-01-01', 32.00, '在库', 1),
('B020', '自然哲学的数学原理', '艾萨克·牛顿', '北京大学出版社', '/bookimg/book20.jpg', '物理学经典著作', '1687-07-05', 80.00, '在库', 2),
('B021', '中国古代史', '钱穆', '商务印书馆', '/bookimg/book21.jpg', '关于中国古代历史的研究', '1940-01-01', 70.00, '在库', 3),
('B022', '就业、利息和货币通论', '约翰·梅纳德·凯恩斯', '商务印书馆', '/bookimg/book22.jpg', '经济学重要著作', '1936-02-04', 56.00, '在库', 4),
('B023', '查拉图斯特拉如是说', '弗里德里希·尼采', '生活·读书·新知三联书店', '/bookimg/book23.jpg', '尼采的代表作之一', '1883-01-01', 45.00, '在库', 5),
('B024', '中国绘画史', '潘天寿', '上海人民美术出版社', '/bookimg/book24.jpg', '介绍中国绘画的历史', '1960-01-01', 62.00, '在库', 6),
('B025', '呐喊', '鲁迅', '人民文学出版社', '/bookimg/book25.jpg', '鲁迅的短篇小说集', '1923-08-01', 30.00, '在库', 1),
('B026', '相对论', '阿尔伯特·爱因斯坦', '科学出版社', '/bookimg/book26.jpg', '现代物理学重要理论', '1916-01-01', 72.00, '在库', 2),
('B027', '明史', '张廷玉等', '中华书局', '/bookimg/book27.jpg', '记载明朝历史的正史', '1739-01-01', 90.00, '在库', 3),
('B028', '博弈论与经济行为', '冯·诺依曼、摩根斯坦', '生活·读书·新知三联书店', '/bookimg/book28.jpg', '博弈论的经典著作', '1944-01-01', 60.00, '在库', 4),
('B029', '精神现象学', '黑格尔', '商务印书馆', '/bookimg/book29.jpg', '黑格尔的哲学著作', '1807-01-01', 50.00, '在库', 5),
('B030', '西方美术史', '朱光潜', '人民美术出版社', '/bookimg/book30.jpg', '介绍西方美术的发展', '1982-01-01', 70.00, '在库', 6);

-- 向读者表插入3条以上记录
INSERT INTO Reader (userType, name, username, password, email, phone) VALUES
('学生', '张三', 'zhangsan', '123456', 'zhangsan@example.com', '13800000000'),
('教师', '李四', 'lisi', '654321', 'lisi@example.com', '13900000000'),
('职工', '王五', 'wangwu', 'abcdef', 'wangwu@example.com', '13600000000'),
('学生', '赵六', 'zhaoliu', 'fedcba', 'zhaoliu@example.com', '13700000000');

-- 第一步：删除原有 DATE 类型的 borrow_date 字段
ALTER TABLE borrow DROP COLUMN borrow_date;

-- 第二步：新增 DATETIME 类型的 borrow_date 字段（默认值为当前时间）
ALTER TABLE borrow
    ADD COLUMN borrow_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '借阅日期（含时间）';

-- 修改字段类型为 DATETIME（包含日期和时间）
ALTER TABLE borrow
    MODIFY COLUMN due_date DATE NOT NULL,
    MODIFY COLUMN return_date DATE DEFAULT NULL,
    MODIFY COLUMN borrow_date DATE NOT NULL ;