-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- 主機: localhost:8889
-- 產生時間： 2016 年 11 月 24 日 16:27
-- 伺服器版本: 5.5.42
-- PHP 版本： 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `test_2016-11`
--

-- --------------------------------------------------------

--
-- 資料表結構 `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `source` varchar(200) NOT NULL,
  `time` datetime NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `news`
--

INSERT INTO `news` (`id`, `title`, `source`, `time`, `description`) VALUES
(1, '新疆50小時雪連天xxx', '聯合新聞網xxx', '2016-11-18 02:00:00', '今日新聞 · 生活資訊 · 元氣網 · NBA台灣 · 追星圖擊隊 · 願景工程 ... 新鮮事 · udn 部落格 · 基金 · 房市 · 我的新聞 · udn APP · 網站總覽 ... 相關新聞 ...'),
(3, '臉書假新聞作者：自認沒做錯事', '中央通訊社', '2016-11-15 00:00:00', '成立假新聞網站並在臉書上發布消息的作者說，他設立假新聞網站純粹是開玩笑，部分媒體平常刊登近乎造假的新聞，他寫的假新聞受到讀者喜愛， ...'),
(8, 'DATA 2', 'DATA 2', '2016-11-18 02:00:00', 'DATA 2....');

-- --------------------------------------------------------

--
-- 資料表結構 `reply`
--

CREATE TABLE `reply` (
  `id` int(11) NOT NULL,
  `source` varchar(300) NOT NULL,
  `description` text NOT NULL,
  `news_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `reply`
--

INSERT INTO `reply` (`id`, `source`, `description`, `news_id`) VALUES
(3, 'xxxx', 'xxxx', 1),
(4, 'AAAA', 'AAAAA', 1),
(5, 'NNN', 'NNN', 1);

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `reply`
--
ALTER TABLE `reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- 使用資料表 AUTO_INCREMENT `reply`
--
ALTER TABLE `reply`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints `reply`
--
ALTER TABLE `reply`
  ADD CONSTRAINT `t1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
