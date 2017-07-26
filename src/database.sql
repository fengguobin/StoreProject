


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`store` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `store`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountname` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `account` */

insert  into `account`(`id`,`accountname`,`password`) values (1,'xiaomi','xiaomi'),(2,'admin','admin');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`name`) values (1,'手机通信'),(2,'手机配件'),(3,'电脑配件');

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `company_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `company` */

insert  into `company`(`id`,`name`,`password`,`company_name`) values (1,'apple','apple','苹果'),(2,'huawei','huawei','华为'),(3,'xiaomi','xiaomi','小米');

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` varchar(32) NOT NULL,
  `totalPrice` double DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `address` varchar(30) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order` */

insert  into `order`(`id`,`totalPrice`,`state`,`address`,`name`,`telephone`,`user_id`,`company_id`) values ('5b727cfca2f34d1491d8100c119b935e',99,0,'广东','朱伟添','15625128948',2,1),('83bdf79b1cff4011bed49791b8dd68a3',149,0,'广州','朱伟添','15625128948',2,3),('915dec70ba8b41ab90ae0a21dc33e108',4888,0,'','朱伟添','15625128948',2,1),('99604611908d4ae5aad24bf50e178443',4888,20,'广东','朱添','15625128948',2,1),('a7ea5a09ef3c4131841545a915c93310',2148,0,'广州','朱添','15625128948',2,3);

/*Table structure for table `orderitem` */

DROP TABLE IF EXISTS `orderitem`;

CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(32) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `itemTotalPrice` double DEFAULT NULL,
  `order_id` varchar(32) NOT NULL,
  `product_img` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id`,`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `orderitem` */

insert  into `orderitem`(`id`,`product_name`,`product_price`,`count`,`itemTotalPrice`,`order_id`,`product_img`) values (1,'苹果7',4888,1,4888,'99604611908d4ae5aad24bf50e178443','8e3c5870cfd1414ab02bd48e429130a2.jpg'),(2,'小米5s',1999,1,1999,'a7ea5a09ef3c4131841545a915c93310','1d07da9ad09e4026a4c58d48e0a797e9.jpg'),(3,'小米充电宝',149,1,149,'a7ea5a09ef3c4131841545a915c93310','66dd0e4e7fdc4c48a3797e5e81780e3c.jpg'),(4,'小米充电宝',149,1,149,'83bdf79b1cff4011bed49791b8dd68a3','66dd0e4e7fdc4c48a3797e5e81780e3c.jpg'),(5,'苹果7',4888,1,4888,'915dec70ba8b41ab90ae0a21dc33e108','8e3c5870cfd1414ab02bd48e429130a2.jpg'),(6,'苹果耳机',99,1,99,'5b727cfca2f34d1491d8100c119b935e','10bc6955e1754192bd300879bf98674b.jpg');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `cprice` double DEFAULT NULL,
  `xprice` double DEFAULT NULL,
  `img` varchar(200) DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  `hot` int(1) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `category_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`id`,`name`,`cprice`,`xprice`,`img`,`createdate`,`hot`,`desc`,`state`,`category_id`,`company_id`) values (1,'苹果7',4999,4888,'8e3c5870cfd1414ab02bd48e429130a2.jpg','2017-05-25',1,'苹果7描述',0,1,1),(2,'苹果6s',3999,3888,'eb43f9dbf8964f76a2c1b72070534f57.jpg','2017-05-25',0,'苹果6s描述',0,1,1),(3,'苹果耳机',199,99,'10bc6955e1754192bd300879bf98674b.jpg','2017-05-25',0,'苹果耳机描述',0,2,1),(4,'苹果air',6999,6888,'78714bc455e44882bdf9e5c96432e035.jpg','2017-05-25',0,'苹果air描述',0,3,1),(5,'小米5s',2088,1999,'1d07da9ad09e4026a4c58d48e0a797e9.jpg','2017-05-25',1,'小米5s描述',0,1,3),(6,'小米5s plus',2699,2599,'0eac8515bdaf47b5973bfe59a690b4e7.jpg','2017-05-25',1,'小米5s plus描述',0,1,3),(7,'小米充电宝',169,149,'66dd0e4e7fdc4c48a3797e5e81780e3c.jpg','2017-05-25',1,'小米充电宝描述',0,2,3),(8,'小米Air尊享版',6099,5999,'43e15059a6654772a406084227f9b68b.jpg','2017-05-25',1,'小米Air尊享版描述',0,3,3),(9,'华为P10 plus',4999,4888,'71643869589b44af95468a5dce31ad69.jpg','2017-05-25',0,'华为P10描述',0,1,2),(10,'华为P10',3888,3788,'6cba1e0e18e8431f82b2497698bf318d.jpg','2017-05-25',1,'华为P10描述',0,1,2);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`uid`,`username`,`password`,`name`,`email`,`telephone`,`birthday`,`sex`,`state`,`code`) values (2,'timewar','123456','朱伟添','user01@store.com','15625128948','2016-05-23','male',1,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
