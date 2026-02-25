package com.project.service;

import java.util.List;

import com.project.domain.Member;

public interface MemberService {

public	int register(Member member) throws Exception;

public List<Member> list()throws Exception;

}
