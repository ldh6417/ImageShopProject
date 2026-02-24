package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.common.domain.CodeLabelValue;
import com.project.domain.Member;
import com.project.service.CodeService;
import com.project.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/user")
public class MemberController {
	@Autowired
	private MemberService service;

	@Autowired
	private CodeService codeService;

	// 스프링 시큐리티의 비밀번호 암호처리기
	@Autowired
	private PasswordEncoder passwordEncoder;

	// 등록 페이지
	@GetMapping("/register")
	public void registerForm(Member member, Model model) throws Exception {
		// 직업코드 목록을 조회하여 뷰에 전달
		String groupCode = "A00";
		List<CodeLabelValue> jobList = codeService.getCodeList(groupCode);
		model.addAttribute("jobList", jobList);

	}
}
