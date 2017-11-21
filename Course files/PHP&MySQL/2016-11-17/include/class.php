<?php
	error_reporting(0);
	class cal{
		var $num1;
		var $num2;
		function add(){
			return $this->num1+$this->num2;
		}
		function sub(){
			return $this->num1-$this->num2;
		}
		function mul(){
			return $this->num1*$this->num2;
		}
		function div(){
			return $this->num1/$this->num2;
		}
		function __construct($a,$b){
			$this->num1=$a;
			$this->num2=$b;
		}
	}
	include("interface.php");
?>
