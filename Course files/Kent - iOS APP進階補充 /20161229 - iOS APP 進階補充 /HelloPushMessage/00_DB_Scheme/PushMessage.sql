-- phpMyAdmin SQL Dump
-- version 2.11.1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: Apr 01, 2016, 04:17 AM
-- 伺服器版本: 5.6.26
-- PHP 版本: 5.4.30

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 資料庫: `PushMessage`
--
CREATE DATABASE `PushMessage` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `PushMessage`;

-- --------------------------------------------------------

--
-- 資料表格式： `ChatMessages`
--

CREATE TABLE IF NOT EXISTS `ChatMessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `GroupName` text CHARACTER SET utf8 NOT NULL,
  `UserName` text CHARACTER SET utf8 NOT NULL,
  `Type` int(11) NOT NULL DEFAULT '0',
  `Message` text CHARACTER SET utf8 NOT NULL,
  `LastUpdateDateTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4651 ;

-- --------------------------------------------------------

--
-- 資料表格式： `DeviceTokenList`
--

CREATE TABLE IF NOT EXISTS `DeviceTokenList` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `GroupName` text CHARACTER SET utf8 NOT NULL,
  `UserName` text CHARACTER SET utf8 NOT NULL,
  `DeviceToken` text CHARACTER SET utf8 NOT NULL,
  `LastUpdateDateTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;
