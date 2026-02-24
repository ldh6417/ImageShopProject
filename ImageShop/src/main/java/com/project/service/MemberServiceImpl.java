package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired 
	private MemberMapper mapper;
}
