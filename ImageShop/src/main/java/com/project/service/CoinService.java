package com.project.service;

import java.util.List;

import com.project.domain.ChargeCoin;

public interface CoinService {
	// 코인 충전처리
	public int charge(ChargeCoin chargeCoin) throws Exception;

	public List<ChargeCoin> list(int userNo) throws Exception;

}
