package com.project.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PayCoin {
	//지급 내역 테이블
	private int historyNo;
	private int userNo;
	private int itemId;
	private String itemName;
	private int amount;
	private Date regDate;

}
